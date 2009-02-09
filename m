From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 30/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:36:57 -0800 (PST)
Message-ID: <fb222d6b5cf0d977c741f1bdd26aa489d27f696e.1234137268.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=G1j1alEXKfuEchyv/FyARtds6uZLdryh0n3xBct9DvU=;
        b=Z4AQWwfv1gEure18LcgmxieEg4LBsNPn3MzLfWLm9uU/uvScajLC9JKtwYjtNk9pcT
         uooVZ5/1qZXl1r74C1rRvI71fAdm1fFOGqKC0JVRenRN62NWzFbJS1JwPnXpUT3fWQj8
         owsmCQ0DCNDC9YBYVheHfW54YHJyrmpsDUxAU=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

We no longer need plymouth. Since dracut is supposed to be distro agnostic,
probably best to not include it in the base backage, and work out an easy way
for distros to add it as needed.

init will ask for a passphrase directly if an encrypted root is detected.

Also, use udevadm settle with a 30 second timeout instead of a hardcoded
30 count loop.
---
 dracut |    5 -----
 init   |   36 +++++++++++-------------------------
 2 files changed, 11 insertions(+), 30 deletions(-)

diff --git a/dracut b/dracut
index cade0e9..382290e 100755
--- a/dracut
+++ b/dracut
@@ -128,9 +128,4 @@ done </proc/mounts
     exit 1
 }
 
-# plymouth
-if [ -x /usr/libexec/plymouth/plymouth-populate-initrd ]; then
-    /usr/libexec/plymouth/plymouth-populate-initrd -t "$initdir" || :
-fi
-
 ( cd "$initdir"; find . |cpio -H newc -o |gzip -9 > "$outfile"; )
diff --git a/init b/init
index ea06687..b12743c 100755
--- a/init
+++ b/init
@@ -7,7 +7,6 @@
 
 emergency_shell()
 {
-    [ -x /bin/plymouth ] && plymouth --hide-splash
     echo ; echo
     echo "Bug in initramfs /init detected. Dropping to a shell. Good luck!"
     echo
@@ -36,6 +35,7 @@ mount -t tmpfs -omode=0755 udev /dev
 
 # FIXME: what device nodes does plymouth really _need_ ?
 mknod /dev/ptmx c 5 2
+mknod /dev/console c 5 0
 mknod /dev/fb c 29 0
 mkdir /dev/pts
 mount -t devpts -o gid=5,mode=620 /dev/pts /dev/pts
@@ -43,12 +43,6 @@ mknod /dev/tty0 c 4 0
 mknod /dev/tty1 c 4 1
 mknod /dev/null c 1 3
 
-# start plymouth if it's available
-# arguably we need some of udev run first for fbmods and above devnodes :/
-[ -x /bin/plymouthd ] && plymouthd
-[ -x /bin/plymouth ] && plymouth --show-splash
-
-
 # start up udev and trigger cold plugs
 udevd --daemon
 udevadm trigger >/dev/null 2>&1
@@ -60,7 +54,6 @@ NEWROOT="/sysroot"
 # it'd be nice if we had a udev rule that just did all of the bits for
 # figuring out what the specified root is and linking it /dev/root
 root=$(getarg 'root=*'); root=${root#root=}
-plymouth --update "Going to mount rootfs ($root)"
 case $root in
     LABEL=*) root=${root#LABEL=}
              root=${root//\//\\x2f}
@@ -72,21 +65,16 @@ esac
 
 # should we have a timeout?
 tries=0
-plymouth --update "Waiting up to 30 seconds for $root to become available"
-until [[ -e $root ]]; do
-    [[ -f /cryptroot ]] && {
-	tries=27
-	cryptopts=$(< /cryptroot)
-	if [ -x /bin/plymouth ] && plymouth --ping; then
-	    /bin/plymouth ask-for-password \
-		--command "/sbin/cryptsetup luksOpen $cryptopts" && break
-	else
-	    /sbin/cryptsetup luksOpen $cryptopts && break
-	fi
-    sleep 1
-    ((tries++ > 30)) && emergency_shell
-done
-plymouth --update "Mounting rootfs after $tries seconds"
+echo "Waiting up to 30 seconds for $root to become available"
+udevadm settle --timeout=30
+[[ -f /cryptroot ]] && {
+    echo "Encrypted root detected."
+    cryptopts=$(< /cryptroot)
+    /sbin/cryptsetup luksOpen $cryptopts || emergency_shell
+    udevadm settle --timeout=30
+}
+echo "Trying to mount rootfs $root"
+[[ -e $root ]] || emergency_shell
 ln -s "$root" /dev/root    
 mount -o ro /dev/root $NEWROOT || emergency_shell
 
@@ -113,8 +101,6 @@ fi
 # kill off udev
 kill $(pidof udevd)
 
-[ -x /bin/plymouth ] && plymouth --newroot=$NEWROOT
-
 # FIXME: nash die die die
 exec switch_root
 # davej doesn't like initrd bugs
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
