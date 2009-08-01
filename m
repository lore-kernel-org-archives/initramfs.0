From: "Sergey Fionov" <fionov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Fix full pathname condition in find_library
Date: Sat, 01 Aug 2009 11:52:16 +0400
Message-ID: <op.uxy35cntfzkdih@etgc>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:content-type:to:subject:date
         :mime-version:content-transfer-encoding:from:message-id:user-agent;
        bh=OpkqIzfsCJuP2/UvxSR4uaSh2I2PE9ZLxGRLy89yFa8=;
        b=gOtDzN9WhFo+BJ37TFeuwPfXmEztc+taBMKr9iNO4R1BJ97KD7aZAXhj6cuC94A/Yp
         RKmyZZab6YDL8+OUg+djcX4dvFNpd2/t4rIOY+C7nMLtTyMfd1W2tG8svIDzyBLM0sq3
         HfPVHuq1f98k3HC+pFOhZhLUSKX/d8bXi2ygo=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello,

Now a fact that the path is full is checked by
[[ -x $1 ]]

But if the working directory is /bin or a directory with a file named  
"mount",
this condition will be met for "inst mount", and "mount" will not be copied
into initrd at all.

diff --git a/dracut-functions b/dracut-functions
index d4caacf..1078bfd 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -83,7 +83,7 @@ inst_library() {
  # search in the usual places to find the binary.
  find_binary() {
      local binpath="/bin /sbin /usr/bin /usr/sbin" p
-    [[ -x $1 ]] && { echo $1; return 0; }
+    [[ -z ${1##/*} && -x $1 ]] && { echo $1; return 0; }
      for p in $binpath; do
         [[ -x $p/$1 ]] && { echo "$p/$1"; return 0; }
      done
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
