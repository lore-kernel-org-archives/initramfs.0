From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] emergency_shell: Use '\W' in $PS1 variable to show current working directory.
Date: Tue, 12 Mar 2013 13:01:43 +0800
Message-ID: <1363064503-14783-1-git-send-email-chaowang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/98systemd/dracut-emergency.sh | 2 +-
 modules.d/99base/dracut-lib.sh          | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/modules.d/98systemd/dracut-emergency.sh b/modules.d/98systemd/dracut-emergency.sh
index a0a4b12..af8daf2 100755
--- a/modules.d/98systemd/dracut-emergency.sh
+++ b/modules.d/98systemd/dracut-emergency.sh
@@ -29,7 +29,7 @@ if getargbool 1 rd.shell -d -y rdshell || getarg rd.break -d rdbreak; then
     echo
     echo
     [ -f /etc/profile ] && . /etc/profile
-    [ -z "$PS1" ] && export PS1="$_name:\${PWD}# "
+    [ -z "$PS1" ] && export PS1="$_name:\W# "
     exec sh -i -l
 else
     warn "$action has failed. To debug this issue add \"rd.shell rd.debug\" to the kernel command line."
diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index d2c803a..e96411e 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -906,7 +906,7 @@ _emergency_shell()
     local _name="$1"
     if [ -n "$DRACUT_SYSTEMD" ]; then
         > /.console_lock
-        echo "PS1=\"$_name:\${PWD}# \"" >/etc/profile
+        echo "PS1=\"$_name:\W# \"" >/etc/profile
         systemctl start dracut-emergency.service
         rm -f /etc/profile
         rm -f /.console_lock
@@ -924,7 +924,7 @@ _emergency_shell()
         echo
         echo 'Dropping to debug shell.'
         echo
-        export PS1="$_name:\${PWD}# "
+        export PS1="$_name:\W# "
         [ -e /.profile ] || >/.profile
 
         _ctty="$(RD_DEBUG= getarg rd.ctty=)" && _ctty="/dev/${_ctty##*/}"
-- 
1.8.1.4
