From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH RFC 1/5] We now know how to configure the network interfaces.
Date: Wed, 25 Feb 2009 18:42:05 -0800 (PST)
Message-ID: <cd38313900d1086b09e2d4279e2fed2df5bf46ec.1235615754.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:from:subject
         :to:x-mailer;
        bh=5P4Agt2HUDbB5u7H+McYWt8O4evJZ+6YvzxdjfFqTW0=;
        b=g0gcFBhwq/IaIG2asCnEQsNXwkf66vsazsueiJvg0URNf0e6tMaHsHVZ64sYu8M40l
         FAeTlSg1qKO0tlGyoPWdlXMjUUbVPkwOJ3eSoqonMFnhbd8DPtXGw7KZwfb6n2iS3OYO
         I8FKjHtxIRAoj3zyHnmInTylyiEjNo1qfZiVg=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Provided that you are configuring them via DHCP. RARP, BOOTP, and static
configuration are not written yet.

Also, adding nic drivers really bloats the initrd.

I am looking for feedback on these patches from people who actually implement
booting over the network.  This patch series does not include support for that
yet -- you will not find nfsroot= handling, or booting to a fs supplied by
dhcp yet.  I do want to make it as easy as possible to add support for booting
over the network, as well as making it easy for people to customize things to
meet their site requirements.

This patch series is also available as the network-configurability branch at
http://git.fnordovax.org/dracut.  It may be rebased without warning to keep
it in sync with the rest of dracut.

---
 README                 |    6 +++++-
 dhclient-script        |   24 ++++++++++++++++++++++++
 hooks/kill-dhclient.sh |    2 ++
 ifup                   |   20 ++++++++++++++++++++
 modules/40network.sh   |    7 +++++++
 rules.d/60-net.rules   |    1 +
 6 files changed, 59 insertions(+), 1 deletions(-)

diff --git a/README b/README
index 1c377b4..6c70fc1 100644
--- a/README
+++ b/README
@@ -37,7 +37,11 @@ Some general rules for writing modules:
  * Generator modules should have a two digit numeric prefix -- they run in
    ascending sort order. Anything in the 90-99 range is stuff that dracut
    relies on, so try not to break those hooks.
- * Generator modules and hooks must have a .sh extension. 
+ * Generator modules and hooks must have a .sh extension.
+ * We have some breakpoints for debugging your hooks.  If you pass 'break'
+   as a kernel parameter, the initramfs will drop to a shell just before
+   switching to a new root. You can pass 'break=hookpoint', and the initramfs
+   will break just before hooks in that hookpoint run. 
 
 Also, there is an attempt to keep things as distribution-agnostic as
 possible.  Every distribution has their own tool here and it's not
diff --git a/dhclient-script b/dhclient-script
new file mode 100755
index 0000000..0db5921
--- /dev/null
+++ b/dhclient-script
@@ -0,0 +1,24 @@
+#!/bin/sh
+# very simple dhclient-script.  All it cares about is bringing the interface
+# up, and it does not even try to do anything else.
+
+case $reason in
+    PREINIT) ip link set "$interface" up ;;
+    BOUND) ipopts="$new_ip_address"
+     	[ "$new_interface_mtu" ] && ip link set $interface mtu $new_interface_mtu
+	[ "$new_subnet_mask" ] && ipopts="$ipopts/$new_subnet_mask"
+	[ "$new_broadcast_address" ] && ipopts="$ipopts broadcast $new_broadcast_address"
+	ip addr add $ipopts dev $interface
+	[ "$new_routers" ] && ip route add default via ${new_routers%%,*} dev $interface
+	[ "$new_domain_name" ] && echo "domain $new_domain_name" > /etc/resolv.conf
+	if [ "$new_domain_search" ]; then
+	    echo "search $new_domain_search" |sed 's/,//g' >> /etc/resolv.conf
+	elif [ "$new_domain_name" ]; then
+	    echo "search $new_domain_name" >> /etc/resolv.conf
+	fi
+	(   IFS=",";
+	    for s in $new_domain_name_servers; do
+		echo "nameserver $s" >> /etc/resolv.conf
+	    done ) ;;
+    *) ;;
+esac
diff --git a/hooks/kill-dhclient.sh b/hooks/kill-dhclient.sh
new file mode 100644
index 0000000..3dd3b43
--- /dev/null
+++ b/hooks/kill-dhclient.sh
@@ -0,0 +1,2 @@
+#!/bin/sh
+kill $(pidof dhclient)
\ No newline at end of file
diff --git a/ifup b/ifup
new file mode 100755
index 0000000..cf5828c
--- /dev/null
+++ b/ifup
@@ -0,0 +1,20 @@
+#!/bin/sh
+echo "$*" >>/dev/net-interfaces-found
+
+# loopback is always handled the same way
+[ "$1" = "lo" ] && {
+    ip link set lo up
+    ip addr add 127.0.0.1/8 dev lo
+    exit 0
+}
+
+# spin through the kernel command line, looking for ip= lines
+while read p; do
+    case $p in
+	'ip=none'|'ip=off') exit 0;; # we were told to not configure anything
+	'ip=dhcp'|'ip=on'|'ip=any') dhclient -nw "$1"; exit 0;; 
+	'ip=bootp'|'ip=rarp'|'ip=both') exit 0;; #dunno how to do this
+	ip=*) exit 0;; #to be written
+	*) continue;;
+    esac
+done
\ No newline at end of file
diff --git a/modules/40network.sh b/modules/40network.sh
new file mode 100755
index 0000000..3def154
--- /dev/null
+++ b/modules/40network.sh
@@ -0,0 +1,7 @@
+#!/bin/bash
+dracut_install ip dhclient
+inst "$dsrc/ifup" "/sbin/ifup"
+inst "$dsrc/dhclient-script" "/sbin/dhclient-script"
+instmods =networking ecb arc4
+inst_rules "$dsrc/rules.d/60-net.rules"
+inst_hook pre-pivot 10 "$dsrc/hooks/kill-dhclient.sh"
diff --git a/rules.d/60-net.rules b/rules.d/60-net.rules
new file mode 100644
index 0000000..4b030c3
--- /dev/null
+++ b/rules.d/60-net.rules
@@ -0,0 +1 @@
+ACTION=="add", SUBSYSTEM=="net", RUN+="/sbin/ifup $env{INTERFACE}"
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
