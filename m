From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: [PATCH] usrmount: always install
Date: Thu, 21 Nov 2013 20:33:38 +0400
Message-ID: <E1VjXM1-00015c-6l@secretive.ru>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Message-Id:To:Subject:Date:From; bh=NHaQgxfbucTrWNSyqyrEIQYkoFg1wJQHFhmTW/ikUgQ=;
	b=XN1eJoZQuyMA6IcmnDD7UtsGpGoihaxWcH6SV7TFjgIghQViwUFYpqq3hd8Ih1mxuea2922zqrj23quJsD4HU36cWBOOrAc9+VFLNH+S4254etzF1RDcy9DmDudnZphWr7soYKDHLKh/RnOhHqLvhP/fAJgFAVX/4L94uGjjkNA=;
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

/usr should be mounted by initramfs even if /sbin/init lives in /
---
 modules.d/98usrmount/module-setup.sh | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/modules.d/98usrmount/module-setup.sh b/modules.d/98usrmount/module-setup.sh
index d8a0ec2..31a6229 100755
--- a/modules.d/98usrmount/module-setup.sh
+++ b/modules.d/98usrmount/module-setup.sh
@@ -4,10 +4,7 @@
 
 # called by dracut
 check() {
-    local _init
     [[ $mount_needs ]] && return 1
-    _init=$(readlink -f /sbin/init)
-    [[ "$_init" == "${_init##/usr}" ]] && return 255
     return 0
 }
 
-- 
1.8.3.2
