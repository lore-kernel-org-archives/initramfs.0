From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] let some modules to respect $mount_needs
Date: Wed, 25 Jan 2012 09:04:17 +0800
Message-ID: <1327453457-9816-1-git-send-email-xiyou.wangcong@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=HMxbpwJKfbwcXTi9Jfh/HnyxBlw6Zw+kjzAJmKbhLl8=;
        b=ZHGGtkSZ/NnmmKJUFQ7JQiZP7u35Ex3aCtP/UG6w66C0mOBfG2x7+pG6P5IbIoKrSZ
         2VISphQW8vGjHFLSoyQxEGfkiUXUG0nikSunnfO6Z2wdqIgrGX9VaOxT9IYfh2P6z/gu
         Wc49WquSq3Clvk+VVR64FUOEeEjI5QQ3N50aY=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
 modules.d/95iscsi/module-setup.sh      |    2 +-
 modules.d/95nbd/module-setup.sh        |    2 +-
 modules.d/95ssh-client/module-setup.sh |    1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/modules.d/95iscsi/module-setup.sh b/modules.d/95iscsi/module-setup.sh
index 5738941..d645dba 100755
--- a/modules.d/95iscsi/module-setup.sh
+++ b/modules.d/95iscsi/module-setup.sh
@@ -23,7 +23,7 @@ check() {
         [[ -d iscsi_session ]]
     )
 
-    [[ $hostonly ]] && {
+    [[ $hostonly ]] || [[ $mount_needs ]] && {
         _rootdev=$(find_root_block_device)
         if [[ $_rootdev ]]; then
             # root lives on a block device, so we can be more precise about
diff --git a/modules.d/95nbd/module-setup.sh b/modules.d/95nbd/module-setup.sh
index 793687d..a6f812f 100755
--- a/modules.d/95nbd/module-setup.sh
+++ b/modules.d/95nbd/module-setup.sh
@@ -9,7 +9,7 @@ check() {
 
     # if an nbd device is not somewhere in the chain of devices root is
     # mounted on, fail the hostonly check.
-    [[ $hostonly ]] && {
+    [[ $hostonly ]] || [[ $mount_needs ]] && {
         is_nbd() { [[ -b /dev/block/$1 && $1 == 43:* ]] ;}
         . $dracutfunctions
 
diff --git a/modules.d/95ssh-client/module-setup.sh b/modules.d/95ssh-client/module-setup.sh
index 0ffc298..3b84900 100644
--- a/modules.d/95ssh-client/module-setup.sh
+++ b/modules.d/95ssh-client/module-setup.sh
@@ -8,6 +8,7 @@ check() {
     # If our prerequisites are not met, fail.
     type -P ssh >/dev/null || return 1
     type -P scp >/dev/null || return 1
+    [[ $mount_needs ]] && return 1
     if [[ $sshkey ]]; then
         [ ! -f $sshkey ] && {
             derror "sshkey is not found!"
-- 
1.7.7.5
