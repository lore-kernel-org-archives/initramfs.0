From: Frederick Grose <fgrose-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Don't truncate the overlay file on a reset.
Date: Wed, 29 Aug 2012 21:15:34 -0400
Message-ID: <CAEcBt+XLgwWV7GDtrR18aZ6MR1GtZihcWub-CNxL0mr7NS_YpQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=MEIncP0VP99dMzmhu//kWJ6VglaQXqgsp2e43FEEDag=;
        b=Ea/VvdL7WRCJMR1GMBiU6ZycBhcu/QLl5RYNzSAGh9iF7vH375u9RyjMt9G7X4/EDJ
         8K8/NrYe6JgCaP69/QsW6n2NOEEGrdZ9cR/8Q/c2VumIH4Vt/2tE5nZXQ3hNuBDpkJuR
         u3asKffBnUPk2E5VJI3BJEDK/oOCjG0EKX6OBh1l58QQmofguW9KXrEntOp5DYRpVkMs
         l54HxKD2SQZ5fKPJZFjAt2d2iumhEqPa9jHlMq7M4LnTdeoVWV+Xsy7Qc4mygtBxaIar
         FnkAFyIjU82F8W+VnAoyPI5XZGgxk6RIE/EDzDHHjFKOkqSkKTaQ33GZ/3iFhSytgy9B
         cbZg==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: livecd-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org

commit d0d4f29cdd0a0e6dd1170965decb282ef5511746
Author: Frederick Grose <fgrose-agl9EP5VjmEgsBAKwltoeQ@public.gmane.org>
Date:   Wed Aug 29 21:02:07 2012 -0400

    Don't truncate the overlay file on a reset.

diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh
b/modules.d/90dmsquash-live/dmsquash-live-root.sh
index f8bfca6..62340a5 100755
--- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
+++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
@@ -98,7 +98,7 @@ do_live_overlay() {
         if [ -f /run/initramfs/overlayfs$pathspec -a -w
/run/initramfs/overlayfs$pathspec ]; then
             losetup $OVERLAY_LOOPDEV /run/initramfs/overlayfs$pathspec
             if [ -n "$reset_overlay" ]; then
-                dd if=/dev/zero of=$OVERLAY_LOOPDEV bs=64k count=1 2>/dev/null
+                dd if=/dev/zero of=$OVERLAY_LOOPDEV bs=64k count=1
conv=notrunc 2>/dev/null
             fi
             setup="yes"
         fi
