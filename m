From: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] dracut: Add drivers/tty/serial on arm
Date: Thu, 12 May 2016 17:28:22 +0200
Message-ID: <1463066902-11767-2-git-send-email-kwizart@gmail.com>
References: <1463066902-11767-1-git-send-email-kwizart@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=joddqWejsqy7d2xgx1G4t5B+HJIviaN1O3VMMDOPC+M=;
        b=WiHnkhQoxk03WF2FBo/oVvKeGgYF1mE8nmZdsTaKfHaeBRhHFNOi79hQKFw58/hNDg
         uhMBkwd11rOoadFocyPsxOUWEbE+inb/Ru7gQlTY3aGs/PTZXM5Y+9oyl8gZs2llndUM
         W+IwcwHUDWBaG6gKdnqNaNlKKJK8TZCibt08rJoUXonBsA8HMzzJHr+Kvs0oT7v+/KFN
         Un25TypMUU0NVbOcinNNycswCMKFk8sr0I4cjmH1c19ExCuZVzEVUU9DhxKQgKwpotE7
         EhOpYfxHzu9D1CU4I/dEf/VUUSq5AtRTCLBf75ZptAtx1IQaSm60ILLhBvYPVQ4NKBZP
         iC7g==
In-Reply-To: <1463066902-11767-1-git-send-email-kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This is needed when serial drivers are compiled as module on arm
Current candidates are 8250_omap or msn_serial

Signed-off-by: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 modules.d/90kernel-modules/module-setup.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
index 7904c02..215f468 100755
--- a/modules.d/90kernel-modules/module-setup.sh
+++ b/modules.d/90kernel-modules/module-setup.sh
@@ -30,6 +30,7 @@ installkernel() {
                 "=drivers/i2c/busses" \
                 "=drivers/regulator" \
                 "=drivers/rtc" \
+                "=drivers/tty/serial" \
                 "=drivers/usb/host" \
                 "=drivers/usb/phy" \
                 ${NULL}
-- 
2.4.11
