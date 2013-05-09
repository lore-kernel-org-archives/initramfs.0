From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [Patch] 01fips/module-setup.sh: add libssl.so.10 to make kdump work with fips mode
Date: Thu,  9 May 2013 16:38:53 +0800
Message-ID: <bccc4bdfbdbdb14122cf83819a7ba16334348acc.1368088634.git.bhe@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

FIPS can work well in 1st kernel, but failed in kdump kernel. the
libssl.so.10 and related hmac file are needed. Now add it and it
works.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/01fips/module-setup.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/01fips/module-setup.sh b/modules.d/01fips/module-setup.sh
index a7f5be8..6013318 100755
--- a/modules.d/01fips/module-setup.sh
+++ b/modules.d/01fips/module-setup.sh
@@ -38,7 +38,7 @@ install() {
 
     inst_libdir_file libsoftokn3.so libsoftokn3.so \
         libsoftokn3.chk libfreebl3.so libfreebl3.chk \
-        libssl.so 'hmaccalc/sha512hmac.hmac'
+        libssl.so 'hmaccalc/sha512hmac.hmac' libssl.so.10
 
     dracut_install -o prelink
 }
-- 
1.7.1
