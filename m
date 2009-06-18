From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: 13 NFS syntax variations
Date: Thu, 18 Jun 2009 12:15:04 +0200
Message-ID: <4A3A13A8.6050100@bfh.ch>
References: <4A39A9AF.6070009@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A39A9AF.6070009-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Warren Togami wrote:
> I ask the contributors again, please consider that we should reduce 
> redundant ways of configuring dracut as much as possible.  Please 
> consider that this code will ship in various products for the next 
> decade.  Is it really a good idea to confuse people by having 
> documentation and examples floating around be in several different 
> formats?  Sure we developers can understand 13 different syntax 
> variations, but this is a lot more complicated to users trying to 
> understand examples they find.
> 
> Here seems to be every possible dracut NFS syntax variation.
> 
> Group A
> root=[<server-ip>:]<root-dir>[:<nfs-options>]
> root=nfs:[<server-ip>:]<root-dir>[:<nfs-options>]
> root=nfs4:[<server-ip>:]<root-dir>[:<nfs-options>]
> 
> Group B
> netroot=[<server-ip>:]<root-dir>[:<nfs-options>]
> netroot=nfs:[<server-ip>:]<root-dir>[:<nfs-options>]
> netroot=nfs4:[<server-ip>:]<root-dir>[:<nfs-options>]
> 
> Group C
> root=dhcp
>     DHCP root-path=[<server-ip>:]<root-dir>[:<nfs-options>]
>     DHCP root-path=nfs:[<server-ip>:]<root-dir>[:<nfs-options>]
>     DHCP root-path=nfs4:[<server-ip>:]<root-dir>[:<nfs-options>]
> 
> Legacy nfsroot.txt
> root=/dev/nfs nfsroot=[<server-ip>:]<root-dir>[,<nfs-options>]
> 
> Legacy Variations
> root=/dev/nfs4 nfsroot=[<server-ip>:]<root-dir>[,<nfs-options>]
> root=nfs nfsroot=[<server-ip>:]<root-dir>[,<nfs-options>]
> root=nfs4 nfsroot=[<server-ip>:]<root-dir>[,<nfs-options>]
> 
> DHCP Fallbacks
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=Documentation/filesystems/nfsroot.txt 
> 
> Seewer's code seems to implement various DHCP-derived fallbacks as 
> documented from this ancient method.  I suppose this is OK, except:
> 
> * The fallbacks should kick-in only if server-ip is blank from root= or 
> DHCP root-path.

Yes. But (sorry if I seem to be slow) I don't see the difference between
my code and your statement. It does exactly that. If server-ip is missing
from root, nfsroot or dhcp root-path it does the fallback.  

>> 54   If the `nfsroot' parameter is NOT given on the command line,
>> 55   the default "/tftpboot/%s" will be used.
> 
> * We should do this only in the case where root=/dev/nfs, or not do it 
> at all.  A hard-coded "/tftpboot" root-dir override in the modern 
> syntaxes makes no sense.

Good point, agreed.

> 
> * We should however support the %s substitution in exactly the same way 
> as the kernel.  Looking at our current code though, it seems we don't. 
> The docs don't do hostname.

Removing hostname isn't a problem, patch below
 
> What should we cut?
> 
> 1) The most obvious to cut are the Legacy Variations.  Why should
> dracut invent three new syntaxes and immediately declare them Legacy? 
> Removing these would be the simplest.

If I understand David Dillow correctly they were meant as shortcuts.
Removing them doesn't break anything, so I agree.

> 
> 2) Harald and I think we should cut Group B.  The netroot= syntax is 
> necessary only for remote block device protocols like iscsci and nbd 
> when you want to use LVM or crypto on those block devices.  For NFS it 
> is only redundant.

Reduntant: Yes. But it keeps the argument scheme consistent. And dracut
is allowed to introduce new syntaxes if they make sense.

> Removing these would be a bit complex surgery because netroot= is 
> tightly ingrained into the current code.

Not true, see patch below.

> 3) I personally think we should cut the "nfs:" prefixed syntaxes from 
> Group A, B and C because they have no precedent and we're better off 
> with fewer variations.  Others have disagreed though.

See above, I like consistency. But that's just my opinion.

Regards,
Philippe

diff --git a/modules.d/95nfs/nfsroot b/modules.d/95nfs/nfsroot
index 46c2b42..5f52457 100755
--- a/modules.d/95nfs/nfsroot
+++ b/modules.d/95nfs/nfsroot
@@ -109,9 +109,7 @@ if [ "${path#*%s}" != "$path" ]; then
     ip=$(ip -o -f inet addr show $netif)
     ip=${ip%%/*}
     ip=${ip##* }
-    read node < /proc/sys/kernel/hostname
-    [ "$node" = "(none)" ] && node=$ip
-    path=${path%%%s*}$node${path#*%s}
+    path=${path%%%s*}$ip${path#*%s}
 fi
 
 # Look through the options and remove rw/locking options
diff --git a/modules.d/95nfs/parse-nfsroot.sh b/modules.d/95nfs/parse-nfsroot.sh
index 5413ad5..55fbc50 100755
--- a/modules.d/95nfs/parse-nfsroot.sh
+++ b/modules.d/95nfs/parse-nfsroot.sh
@@ -71,23 +71,23 @@ netroot_to_var() {
 [ -z "$netroot" ] && netroot=$(getarg netroot=)
 [ -z "$nfsroot" ] && nfsroot=$(getarg nfsroot=)
 
+# Netroot cmdline argument must be ignored, but must be used if
+# we're inside netroot to parse dhcp root-path
+if [ -n "$netroot" ] ; then
+    if [ "$netroot" = "$(getarg netroot=)" ] ; then
+	warn "Ignoring netroot argument for NFS"
+	netroot=$root
+    fi
+else
+    netroot=$root;
+fi
+
 # Handle old style <server-ip>:/<path
 case "$netroot" in
     [0-9]*:/*|[0-9]*\.[0-9]*\.[0-9]*[!:]|/*)
        netroot=nfs:$netroot;;
 esac
 
-# Root takes precedence over netroot
-case "${root%%:*}" in
-    nfs|nfs4|/dev/nfs|/dev/nfs4)
-    if [ -n "$netroot" ] ; then
-	warn "root takes precedence over netroot. Ignoring netroot"
-
-    fi
-    netroot=$root
-    ;;
-esac
-
 # If it's not empty or nfs we don't continue
 case "${netroot%%:*}" in
     ''|nfs|nfs4|/dev/nfs|/dev/nfs4);;
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
