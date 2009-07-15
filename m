From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 02/14] 10redhat-i18n: Fix handling of kbd maps which are a symlink
Date: Wed, 15 Jul 2009 18:50:34 +0200
Message-ID: <1247676646-3837-3-git-send-email-harald@redhat.com>
References: <1247676646-3837-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1247676646-3837-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Some keyboard maps are symlinks to others, we were not handling this
properly, this patch fixes this.
---
 modules.d/10redhat-i18n/install |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/modules.d/10redhat-i18n/install b/modules.d/10redhat-i18n/install
index 3658193..a6dbc07 100755
--- a/modules.d/10redhat-i18n/install
+++ b/modules.d/10redhat-i18n/install
@@ -32,6 +32,14 @@ if [[ -f /etc/sysconfig/keyboard || -f /etc/sysconfig/console/default.kmap ]]; t
         findkeymap $KEYMAP
 
         for FN in $KEYMAPS; do
+            if [ -L $FN ]; then
+		TARGET=$(readlink -f $FN)
+		TG=$(echo $TARGET | sed -e 's/\.gz$//' -e 's/\.bz2$//')
+		LN=$(echo $FN | sed -e 's/\.gz$//' -e 's/\.bz2$//')
+                mkdir -p "$initdir/$(dirname $LN)"
+                ln -s "$TG" "$initdir/$LN"
+                FN=$TARGET
+            fi
             inst $FN
             case $FN in
                 *.gz) gzip -d "$initdir$FN" ;;
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
