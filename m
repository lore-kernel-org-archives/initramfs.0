From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [Patch] lsinitrd: do not display "test" on terminal
Date: Mon, 30 Jan 2012 14:27:26 +0800
Message-ID: <1327904846-11897-1-git-send-email-xiyou.wangcong@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=dNcG9u1vCx6IkEjHA0zmxi264YkP8ymPIk72cXabM5w=;
        b=XuEGHXwLyAeEFWYOms1KK45wNbL4MlMw+aoTkQpPbTGaKEdXLZSRPhgWpEqwPAAX0m
         6ZX+08Dg079kpYYIRkpSZXQY6Es+RUKDwYUBiFhojMk+eiN39RWQGIML6pZBKspuiSOP
         rTPbtuLFzwtGjoLZYg3gUgJCSVWnh6ffeCISQ=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

`echo "test"|xz|xz -dc --single-stream` will display "test" on terminal,
redirect it to /dev/null.

Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
diff --git a/lsinitrd b/lsinitrd
index 1d953b7..fb3769c 100755
--- a/lsinitrd
+++ b/lsinitrd
@@ -36,7 +36,7 @@ image="${1:-/boot/initramfs-$(uname -r).img}"
 CAT=zcat
 FILE_T=$(file "$image")
 
-if echo "test"|xz|xz -dc --single-stream; then
+if echo "test"|xz|xz -dc --single-stream >/dev/null; then
     XZ_SINGLE_STREAM="--single-stream"
 fi
 
