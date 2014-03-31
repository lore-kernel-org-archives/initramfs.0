From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: [PATCH] modsign: do not hardcode path to keyctl
Date: Mon, 31 Mar 2014 17:56:13 +0400
Message-ID: <E1WUcqK-0008KG-Ty@secretive.ru>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Message-Id:To:Subject:Date:From; bh=r+SI1W2Y0VUKSEf3PGnwoMFtYQbXAXJJhBNbTsOdVzc=;
	b=cgn0gwUcegREVURFuPfn5c6JEECuxkSF0tnuQA1aYFjQRce1NvnJT4xND3fkoCPGpOuMcjBuYOIK347/Sr629EZuNbnvm+u39o3L3QFB1e7axTDhJES21m0gW8clGd6sHmg7aPS+vBJuOJTXOpfUIEnyuKzz0E17x/TnPN7rDXQ=;
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

https://bugs.gentoo.org/show_bug.cgi?id=506094
---
 modules.d/03modsign/module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/03modsign/module-setup.sh b/modules.d/03modsign/module-setup.sh
index 09285d3..cc0e241 100755
--- a/modules.d/03modsign/module-setup.sh
+++ b/modules.d/03modsign/module-setup.sh
@@ -29,7 +29,7 @@ depends() {
 # called by dracut
 install() {
     inst_dir /lib/modules/keys
-    inst_binary /usr/bin/keyctl
+    inst_binary keyctl
 
     inst_hook pre-trigger 01 "$moddir/load-modsign-keys.sh"
 
-- 
1.8.3.2
