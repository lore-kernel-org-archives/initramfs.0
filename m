From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] fix _getcmdline arg-duplicating bug with /etc/cmdline*
Date: Tue,  1 May 2012 14:08:33 -0400
Message-ID: <1335895714-21699-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

If you unset CMDLINE to make _getcmdline re-read /etc/cmdline and
/etc/cmdline.d/*, CMDLINE_ETC and CMDLINE_ETC_D would keep their
contents.

This is a serious problem if you have (e.g.) "ip=eth0:dhcp" in
/etc/cmdline.d/net.conf, because getargs ip= will return
"ip=eth0:dhcp ip=eth0:dhcp" and then parse-ip-opts.sh will die() because
you have two configurations for eth0.
---
 modules.d/99base/dracut-lib.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index a6b8d1a..ddb6954 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -48,6 +48,7 @@ _getcmdline() {
     local _i
     unset _line
     if [ -z "$CMDLINE" ]; then
+        unset CMDLINE_ETC CMDLINE_ETC_D
         if [ -e /etc/cmdline ]; then
             while read -r _line; do
                 CMDLINE_ETC="$CMDLINE_ETC $_line";
-- 
1.7.7.6
