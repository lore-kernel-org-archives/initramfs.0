From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [Patch v2 2/2] let user specify action after systemd start dracut-emergency
Date: Wed, 29 May 2013 16:38:32 +0800
Message-ID: <dc98d3640cb7f265d9a84a11b87e494635485e8d.1369816679.git.bhe@redhat.com>
References: <078c160e62c2c750efe71fc8a05dd7c5de71bde3.1369816679.git.bhe@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <078c160e62c2c750efe71fc8a05dd7c5de71bde3.1369816679.git.bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
In-Reply-To: <078c160e62c2c750efe71fc8a05dd7c5de71bde3.1369816679.git.bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
References: <078c160e62c2c750efe71fc8a05dd7c5de71bde3.1369816679.git.bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

If failed to mount /sysroot, triggering OnFailure= dependencies
of initrd-xxx.service, then dracut-emergency will be started by
systemd and enter into emergency shell.

Here add a judgement in dracut-emergency. If user specify
"action_on_fail=continue", continue though mount root failed.
Otherwise enter into interactive shell.

v1-v2->
      action_on_fail function can't be used directly here, discard
      it. Instead add a judgement to handle this.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/98systemd/dracut-emergency.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/modules.d/98systemd/dracut-emergency.sh b/modules.d/98systemd/dracut-emergency.sh
index 8ab045e..51e1f80 100755
--- a/modules.d/98systemd/dracut-emergency.sh
+++ b/modules.d/98systemd/dracut-emergency.sh
@@ -30,7 +30,12 @@ if getargbool 1 rd.shell -d -y rdshell || getarg rd.break -d rdbreak; then
     echo
     [ -f /etc/profile ] && . /etc/profile
     [ -z "$PS1" ] && export PS1="$_name:\${PWD}# "
-    exec sh -i -l
+    if [ "$(getarg action_on_fail=)" = "continue" ]; then
+        echo "Systemd is starting dracut emergency"
+        echo "NoT dropping to emergency shell, because 'action_on_fail=continue' was set on kernel command line"
+    else
+        exec sh -i -l
+    fi
 else
     warn "$action has failed. To debug this issue add \"rd.shell rd.debug\" to the kernel command line."
     exit 1
-- 
1.7.1
