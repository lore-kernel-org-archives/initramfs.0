From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [Patch] network: move the kill-dhclient.sh hook later
Date: Tue, 17 Apr 2012 21:25:11 +0800
Message-ID: <1334669111-17575-1-git-send-email-xiyou.wangcong@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=T44C8WzNTkACTFh8ghuQVXQN1n0BH4L/Wbg5E4quodg=;
        b=eUD9kuG30jySpXWi+7PmRUMIl8Yuh4EQGjGqmOjvd18RSujkk2l7pnUwHh5Nxi5yw7
         LnjfP8mf6Is6js6Pfh/gq7eOPVFHlh8N1RMNYemNiPPAtjvE+C2oaLByBUNrcVSdndQQ
         lNGIRlERmu7U9V/d4cOMosbtIPJ1UEo3u0PStMHO3Bj4UP4hUgpfETqXvHvYwg72X4Hv
         kSmNGQC5hCNtiYH2MqJiLMiRE41DXH5/8ubhM0gcfHvKb2ejivSLYemGJaPkTW+apupg
         W0el/2Yp5ekoJGs2NJuBAs0Y0NQ/i1AsQn3iCNH/Tohy319J5xJrtrdHgRkW1IS6HAfH
         WUhA==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

kdump module uses a pre-pivot hook too, it needs networking, so
do not kill dhclient so early. kdump hook needs to find a place
where all needed fs are mounted meanwhile networking works too.

Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
diff --git a/modules.d/40network/module-setup.sh b/modules.d/40network/module-setup.sh
index c91f164..1a7d206 100755
--- a/modules.d/40network/module-setup.sh
+++ b/modules.d/40network/module-setup.sh
@@ -85,7 +85,7 @@ install() {
     inst_hook cmdline 97 "$moddir/parse-bridge.sh"
     inst_hook cmdline 98 "$moddir/parse-ip-opts.sh"
     inst_hook cmdline 99 "$moddir/parse-ifname.sh"
-    inst_hook pre-pivot 10 "$moddir/kill-dhclient.sh"
+    inst_hook pre-pivot 98 "$moddir/kill-dhclient.sh"
 
     _arch=$(uname -m)
 
