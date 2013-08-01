From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] 95terminfo: install vt102
Date: Thu, 1 Aug 2013 18:54:55 +0800
Message-ID: <20130801105455.GA4121@dhcp16-109.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

systemd uses vt102 as default term for tty:

commit acda6a0
Author: Lennart Poettering <lennart-mdGvqq1h2p+GdvJs77BJ7Q@public.gmane.org>
Date:   Sun Apr 22 02:45:39 2012 +0200

    default to v102 everywhere, instead of vt100, to synchronize with agetty

Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/95terminfo/module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/95terminfo/module-setup.sh b/modules.d/95terminfo/module-setup.sh
index ecd4395..4656cd3 100755
--- a/modules.d/95terminfo/module-setup.sh
+++ b/modules.d/95terminfo/module-setup.sh
@@ -10,7 +10,7 @@ install() {
     done
 
     if [ -d ${_terminfodir} ]; then
-        for i in "l/linux" "v/vt100" "v/vt220"; do
+        for i in "l/linux" "v/vt100" "v/vt102" "v/vt220"; do
             inst_dir "$_terminfodir/${i%/*}"
             cp --reflink=auto --sparse=auto -prfL -t "${initdir}/${_terminfodir}/${i%/*}" "$_terminfodir/$i"
         done
-- 
1.8.3.1
