From: Vasiliy Tolstov <v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org>
Subject: [PATCH] fix gzip compress then it not supports rsyncable option
Date: Mon, 27 Oct 2014 13:43:53 +0300
Message-ID: <1414406633-5262-1-git-send-email-v.tolstov@selfip.ru>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=selfip.ru; s=google;
        h=sender:from:to:cc:subject:date:message-id;
        bh=bT4ZU5Ei3+JKEaQ4GdWRsQmGKNxiP4X7QyT6eEsQUvQ=;
        b=QoIzLcHHXvHdmBvPCm1hj60KgVlRiKhkSW/xV5XK7fxt9FtDiJGIa/FRKKoBE8Epaq
         EDyYu5ogT2Hx93vpcaGLhJ0An5JBZo52mrAjKRA54pZPPMKX/81UBZf3VpiTpOhOoPsx
         bxQ37R7PRyJJPswqMBcC1GfwCf8KNcaoijdto=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Vasiliy Tolstov <v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org>

dracut fail to create initramfs when compressor gzip and
it not have rsyncable option

Signed-off-by: Vasiliy Tolstov <v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org>
---
 dracut.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dracut.sh b/dracut.sh
index 1c7e208..7aa1264 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -822,7 +822,7 @@ case $compress in
     bzip2) compress="bzip2 -9";;
     lzma)  compress="lzma -9 -T0";;
     xz)    compress="xz --check=crc32 --lzma2=dict=1MiB -T0";;
-    gzip)  compress="gzip -n -9 --rsyncable"; command -v pigz > /dev/null 2>&1 && compress="pigz -9 -n -T -R";;
+    gzip)  compress="gzip -n -9"; command -v gzip --help 2>&1 | grep -q rsyncable && compress="gzip -n -9 --rsyncable"; command -v pigz > /dev/null 2>&1 && compress="pigz -9 -n -T -R";;
     lzo)   compress="lzop -9";;
     lz4)   compress="lz4 -l -9";;
 esac
-- 
2.1.2
