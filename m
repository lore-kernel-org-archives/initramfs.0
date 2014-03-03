From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] Add -[-no]-hostonly-cmdline option handling for getopt
Date: Mon, 3 Mar 2014 15:22:00 +0800
Message-ID: <20140303072200.GA20357@dhcp-17-89.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

commit ab9457e introduce such new options but it missed to add these
options to getopt arguments.

Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dracut.sh b/dracut.sh
index 74640ad..79c59d5 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -349,6 +349,8 @@ rearrange_params()
         --long host-only \
         --long no-hostonly \
         --long no-host-only \
+        --long hostonly-cmdline \
+        --long no-hostonly-cmdline \
         --long persistent-policy: \
         --long fstab \
         --long help \
-- 
1.8.5.3
