From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] add initqueue --env and "online" hook
Date: Tue,  6 Mar 2012 18:25:25 -0500
Message-ID: <1331076325-24148-2-git-send-email-wwoods@redhat.com>
References: <1331076325-24148-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1331076325-24148-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The "online" hook runs whenever a network interface comes online (that
is, once it's actually up and configured).

The initqueue --env argument is used to set "$netif" to the name of the
newly-online network interface.
---
 dracut-functions.sh                 |    2 +-
 modules.d/40network/net-genrules.sh |   24 +++++++++---------------
 modules.d/99base/initqueue.sh       |   15 +++++++--------
 3 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/dracut-functions.sh b/dracut-functions.sh
index 20fc6e1..694912d 100755
--- a/dracut-functions.sh
+++ b/dracut-functions.sh
@@ -34,7 +34,7 @@ fi
 
 # export standard hookdirs
 [[ $hookdirs ]] || {
-    hookdirs="cmdline pre-udev pre-trigger netroot initqueue pre-mount"
+    hookdirs="cmdline pre-udev pre-trigger netroot initqueue online pre-mount"
     hookdirs+=" pre-pivot mount emergency shutdown-emergency shutdown cleanup"
     export hookdirs
 }
diff --git a/modules.d/40network/net-genrules.sh b/modules.d/40network/net-genrules.sh
index 323d185..8d3d306 100755
--- a/modules.d/40network/net-genrules.sh
+++ b/modules.d/40network/net-genrules.sh
@@ -31,33 +31,27 @@ fix_bootif() {
         IFACES=${bondslaves%% *}
     fi
 
+    ifup='/sbin/ifup $env{INTERFACE}'
+    [ -z "$netroot" ] && ifup="$ifup -m"
+
     # BOOTIF says everything, use only that one
     BOOTIF=$(getarg 'BOOTIF=')
     if [ -n "$BOOTIF" ] ; then
         BOOTIF=$(fix_bootif "$BOOTIF")
-        if [ -n "$netroot" ]; then
-            printf 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="%s", OPTIONS+="event_timeout=360", RUN+="/sbin/ifup $env{INTERFACE}"\n' "$BOOTIF"
-        else
-            printf 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="%s", OPTIONS+="event_timeout=360", RUN+="/sbin/ifup $env{INTERFACE} -m"\n' "$BOOTIF"
-        fi
+        printf 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="%s", OPTIONS+="event_timeout=360", RUN+="%s"\n' "$BOOTIF" "$ifup"
 
     # If we have to handle multiple interfaces, handle only them.
     elif [ -n "$IFACES" ] ; then
         for iface in $IFACES ; do
-            if [ -n "$netroot" ]; then
-                printf 'SUBSYSTEM=="net", ENV{INTERFACE}=="%s", OPTIONS+="event_timeout=360", RUN+="/sbin/ifup $env{INTERFACE}"\n' "$iface"
-            else
-                printf 'SUBSYSTEM=="net", ENV{INTERFACE}=="%s", OPTIONS+="event_timeout=360", RUN+="/sbin/ifup $env{INTERFACE} -m"\n' "$iface"
-            fi
+            printf 'SUBSYSTEM=="net", ENV{INTERFACE}=="%s", OPTIONS+="event_timeout=360", RUN+="%s"\n' "$iface" "$ifup"
         done
 
     # Default: We don't know the interface to use, handle all
     else
-        if [ -n "$netroot" ]; then
-            printf 'SUBSYSTEM=="net", OPTIONS+="event_timeout=360", RUN+="/sbin/ifup $env{INTERFACE}"\n'
-        else
-            printf 'SUBSYSTEM=="net", OPTIONS+="event_timeout=360", RUN+="/sbin/ifup $env{INTERFACE} -m"\n'
-        fi
+        printf 'SUBSYSTEM=="net", OPTIONS+="event_timeout=360", RUN+="%s"\n' "$ifup"
     fi
 
+    # Run the "online" hook
+    printf 'SUBSYSTEM=="net", ACTION=="online", RUN+="/sbin/initqueue --onetime --env netif=$env{INTERFACE} source_hook online"\n'
+
 } > /etc/udev/rules.d/60-net.rules
diff --git a/modules.d/99base/initqueue.sh b/modules.d/99base/initqueue.sh
index 2c06a0b..3387e88 100755
--- a/modules.d/99base/initqueue.sh
+++ b/modules.d/99base/initqueue.sh
@@ -25,6 +25,8 @@ while [ $# -gt 0 ]; do
             unique="yes";;
         --name)
             name="$2";shift;;
+        --env)
+            env="$2"; shift;;
         *)
             break;;
     esac
@@ -43,14 +45,11 @@ shift
 
 [ -x "$exe" ] || exe=$(command -v $exe)
 
-if [ -n "$onetime" ]; then
-    {
-        echo '[ -e "$job" ] && rm "$job"'
-        echo "$exe $@"
-    } > "/tmp/$$-${job}.sh"
-else
-    echo "$exe $@" > "/tmp/$$-${job}.sh"
-fi
+{
+    [ -n "$onetime" ] && echo '[ -e "$job" ] && rm "$job"'
+    [ -n "$env" ] && echo "$env"
+    echo "$exe $@"
+} > "/tmp/$$-${job}.sh"
 
 mv -f "/tmp/$$-${job}.sh" "$hookdir/initqueue${qname}/${job}.sh"
 [ -z "$qname" ] && >> $hookdir/initqueue/work
-- 
1.7.7.6
