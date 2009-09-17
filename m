From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [PATCH 8/8] Move netroot to initqueue
Date: Thu, 17 Sep 2009 17:30:23 +0200
Message-ID: <4AB2560F.40505@bfh.ch>
References: <1253200609-31629-1-git-send-email-philippe.seewer@bfh.ch> <1253200609-31629-9-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1253200609-31629-9-git-send-email-philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On irc harald pointed out that we might get rid of the online
event completely and schedule netroot for the initqueue inside
ifup and dhclient. That is much better.
---
 modules.d/40network/dhclient-script |    2 +-
 modules.d/40network/ifup            |    2 +-
 modules.d/40network/net-genrules.sh |    4 ----
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/modules.d/40network/dhclient-script b/modules.d/40network/dhclient-script
index b03cf1c..d6c1448 100755
--- a/modules.d/40network/dhclient-script
+++ b/modules.d/40network/dhclient-script
@@ -73,7 +73,7 @@ case $reason in
 	    [ "${line#new_}" = "$line" ] && continue
 	    echo "$line" 
 	done >/tmp/dhclient.$netif.dhcpopts
-	echo online > /sys/class/net/$netif/uevent
+	/sbin/initqueue --onetime /sbin/netroot $netif
 	;;
     *) ;;
 esac
diff --git a/modules.d/40network/ifup b/modules.d/40network/ifup
index 25cab26..5002774 100755
--- a/modules.d/40network/ifup
+++ b/modules.d/40network/ifup
@@ -42,7 +42,7 @@ do_static() {
     [ -n "$gw" ] && echo ip route add default via $gw dev $netif > /tmp/net.$netif.gw
     [ -n "$hostname" ] && echo "echo $hostname > /proc/sys/kernel/hostname" > /tmp/net.$netif.hostname
 
-    echo online > /sys/class/net/$netif/uevent
+    /sbin/initqueue --onetime /sbin/netroot $netif
 }
 
 PATH=$PATH:/sbin:/usr/sbin
diff --git a/modules.d/40network/net-genrules.sh b/modules.d/40network/net-genrules.sh
index ba369cc..c213a28 100755
--- a/modules.d/40network/net-genrules.sh
+++ b/modules.d/40network/net-genrules.sh
@@ -36,8 +36,4 @@ fix_bootif() {
     else
 	printf 'ACTION=="add", SUBSYSTEM=="net", RUN+="/sbin/ifup $env{INTERFACE}"\n'
     fi
-
-    # Udev event 'online' only gets fired from ifup/dhclient-script.
-    # No special rules required
-    printf 'ACTION=="online", SUBSYSTEM=="net", RUN+="/sbin/netroot $env{INTERFACE}"\n'
 } > /etc/udev/rules.d/60-net.rules
-- 
1.6.0.4


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
