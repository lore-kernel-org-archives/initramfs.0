From: =?UTF-8?B?UHJ6ZW15c8WCYXcgUnVkeQ==?= <prudy1-h7QdYz1kt/Q@public.gmane.org>
Subject: [PATCH 1/2] luks key on ext dev - wait for luks
Date: Tue, 07 Jun 2011 20:26:45 +0200
Message-ID: <islqh5$vpc$2@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This really waits for the luks mapper device, so luksOpen can do it job:

 modules.d/90crypt/parse-crypt.sh |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/modules.d/90crypt/parse-crypt.sh
b/modules.d/90crypt/parse-crypt.sh
index 7ec232a..a2d64a0 100755
--- a/modules.d/90crypt/parse-crypt.sh
+++ b/modules.d/90crypt/parse-crypt.sh
@@ -23,8 +23,20 @@ else
                 printf -- '$env{DEVNAME} luks-$env{ID_FS_UUID}"\n'
             } >> /etc/udev/rules.d/70-luks.rules.new
 -            printf -- '[ -e /dev/disk/by-uuid/*%s* ]\n' $luksid \
-                >> $hookdir/initqueue/finished/90-crypt.sh
+            [ -e $hookdir/initqueue/finished/90-crypt.sh ] || \
+            {
+                printf -- 'UUIDS=:\n'
+                printf -- 'for dm in /dev/dm-*; do\n'
+                printf -- '[ -e "$dm" ] || exit 1\n'
+                printf -- 'dmid=`/sbin/dmsetup info -c -o uuid
--noheadings "$dm"`\n'
+                printf -- 'uuid=${dmid#CRYPT-LUKS*-}\n'
+                printf -- '[ "x$uuid" = "x$dmid" ] && continue\n'
+                printf -- 'UUIDS="${UUIDS}${uuid%%%%-*}:"\n'
+                printf -- 'done\n'
+            } > $hookdir/initqueue/finished/90-crypt.sh
+            uuid=$luksid
+            while [ "$uuid" != "${uuid#*-}" ]; do
uuid=${uuid%%-*}${uuid#*-}; done
+            printf -- '[ "x${UUIDS#*:%s:}" != "x$UUIDS" ] || exit 1\n'
$uuid >> $hookdir/initqueue/finished/90-crypt.sh
             {
                 printf -- '[ -e /dev/disk/by-uuid/*%s* ] || ' $luksid
                 printf -- 'warn "crypto LUKS UUID "%s" not found"\n'
$luksid
