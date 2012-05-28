From: Juan RP <xtraeme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] dmsquash-live: do not hardcode path to mount(8) in
 generated hook.
Date: Mon, 28 May 2012 16:17:28 +0200
Message-ID: <20120528161728.3425f35f.xtraeme@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=cFSlGwtAkwubxT5ckm94GyIPp/vnVUyyTWgOnQuGCjI=;
        b=FdmV6Cys6+wc7Mme/PiJCAIgS/bWiqWuVqLB7w3MAeuFwYmoQ0qrJ+Riw+dbGb9WP6
         53wPeReQbegxMacAiSIm1rDXKqWi7RVqb3VVSEAfT3PPp9vaK09hxbj8m7vBHBP+BzYP
         3mYkXK+B692nEdkhoVE/+WRdnWfErZzUzZ8zelWSNbV6tTcGLTJ0LrLwyg2GTao7Ld0m
         Vo4fdTZh12thXkQPj20389RwRtelqgyETWvT1zT7R8res9MsIQTgIfLAC4XTywnC8h05
         dvmpXksyNG3ygnqX8Mfv0SUyK6wR/MmOVR8pj1zz5aYXgxi4ML/8rxfDMEwhSHkcOwQL
         Ocxg==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


In some cases (at least in mine) mount(8) is in /usr/bin/mount and
not in /bin/mount as dmsquash-live-root.sh expects. PATH is set to
/usr/bin:/usr/sbin:/sbin:/bin in that script anyway.
---
 modules.d/90dmsquash-live/dmsquash-live-root.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh b/modules.d/90dmsquash-live/dmsquash-live-root.sh
index fdbd6f5..990a55b 100755
--- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
+++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
@@ -204,7 +204,7 @@ if [ -b "$BASE_LOOPDEV" ]; then
     ln -s $BASE_LOOPDEV /run/initramfs/live-baseloop
 fi
 ln -s /dev/mapper/live-rw /dev/root
-printf '/bin/mount %s /dev/mapper/live-rw %s\n' "$ROOTFLAGS" "$NEWROOT" > $hookdir/mount/01-$$-live.sh
+printf 'mount %s /dev/mapper/live-rw %s\n' "$ROOTFLAGS" "$NEWROOT" > $hookdir/mount/01-$$-live.sh
 
 need_shutdown
 
-- 
1.7.10.2
