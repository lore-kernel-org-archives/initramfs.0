From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 3/4] dracut-systemd/rootfs-generator.sh: always create
 generated files.
Date: Thu, 26 Mar 2015 15:41:48 +1100
Message-ID: <20150326044147.10121.57679.stgit@notabene.brown>
References: <20150326043938.10121.34223.stgit@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150326043938.10121.34223.stgit-wvvUuzkyo1EYVZTmpyfIwg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

When 'systemctl daemon-reload' is run, systemd will clean out
/run/systemd/generator and re-run all the generators.
So it is important that the generators always create the required
files.

rootfs-generator.sh currently does *not* create the desired files
if $hookdir/initqueue/finished/devexists-${_name}.sh
exists.

This is not removed by "systectl daemon-reload" so the first time this
generator is run it will do the right thing.  Subsequent times it
won't.

This results in incorrect timeouts after "daemon-reload" is run.

So let the existence of each file only guard the creation that file.

Signed-off-by: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/98dracut-systemd/rootfs-generator.sh |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/modules.d/98dracut-systemd/rootfs-generator.sh b/modules.d/98dracut-systemd/rootfs-generator.sh
index f3c7d1f237df..97512c07ab06 100755
--- a/modules.d/98dracut-systemd/rootfs-generator.sh
+++ b/modules.d/98dracut-systemd/rootfs-generator.sh
@@ -11,14 +11,15 @@ generator_wait_for_dev()
     _timeout=$(getarg rd.timeout)
     _timeout=${_timeout:-0}
 
-    [ -e "$hookdir/initqueue/finished/devexists-${_name}.sh" ] && return 0
+    if ! [ -e "$hookdir/initqueue/finished/devexists-${_name}.sh" ]; then
 
-    printf '[ -e "%s" ]\n' $1 \
-        >> "$hookdir/initqueue/finished/devexists-${_name}.sh"
-    {
-        printf '[ -e "%s" ] || ' $1
-        printf 'warn "\"%s\" does not exist"\n' $1
-    } >> "$hookdir/emergency/80-${_name}.sh"
+        printf '[ -e "%s" ]\n' $1 \
+            >> "$hookdir/initqueue/finished/devexists-${_name}.sh"
+        {
+            printf '[ -e "%s" ] || ' $1
+            printf 'warn "\"%s\" does not exist"\n' $1
+        } >> "$hookdir/emergency/80-${_name}.sh"
+    fi
 
     _name=$(dev_unit_name "$1")
     if ! [ -L /run/systemd/generator/initrd.target.wants/${_name}.device ]; then

