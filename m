From: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Subject: [Dracut PATCH] usrmount: Fix miss-detection of btrfs subvolumes.
Date: Fri,  3 May 2013 17:16:05 +0100
Message-ID: <1367597765-26656-1-git-send-email-colin@mageia.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>

This causes the root FS options to be incorrectly applied to to /usr
In some cases this can cause boot failure e.g. due to and XFS /usr
not supporting the 'acl' option from the ext4 root FS.

https://bugs.mageia.org/show_bug.cgi?id=9884
---
 modules.d/98usrmount/mount-usr.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/modules.d/98usrmount/mount-usr.sh b/modules.d/98usrmount/mount-usr.sh
index a4a66ae..de7dcc2 100755
--- a/modules.d/98usrmount/mount-usr.sh
+++ b/modules.d/98usrmount/mount-usr.sh
@@ -61,14 +61,14 @@ mount_usr()
                 LABEL=*)
                     _dev="$(echo $_dev | sed 's,/,\\x2f,g')"
                     _dev="/dev/disk/by-label/${_dev#LABEL=}"
-		    ;;
+                    ;;
                 UUID=*)
                     _dev="${_dev#block:}"
                     _dev="/dev/disk/by-uuid/${_dev#UUID=}"
                     ;;
             esac
             if strstr "$_opts" "subvol=" && \
-                [ "${root#block:}" -ef $_dev ]
+                [ "${root#block:}" -ef $_dev ] && \
                 [ -n "$rflags" ]; then
                 # for btrfs subvolumes we have to mount /usr with the same rflags
                 rflags=$(filtersubvol "$rflags")
-- 
1.8.1.5
