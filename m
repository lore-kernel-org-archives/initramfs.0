From: Pingfan Liu <piliu-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] dracut.sh: for_each_host_xx() function should indicate the empty case
Date: Mon,  4 Dec 2017 17:24:11 +0800
Message-ID: <1512379451-17727-1-git-send-email-piliu@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The caller of "for_each_host_xx func" needs to tell three cases:
func success/ fail / not be called.
E.g, in kdump case, host_devs can be empty, and we want to know it.

Signed-off-by: Pingfan Liu <piliu-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut-functions.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/dracut-functions.sh b/dracut-functions.sh
index 112b243..575bd4a 100755
--- a/dracut-functions.sh
+++ b/dracut-functions.sh
@@ -468,7 +468,8 @@ for_each_host_dev_fs()
     local _dev
     local _ret=1
 
-    [[ "${#host_fs_types[@]}" ]] || return 0
+    [[ "${#host_fs_types[@]}" ]] || return 2
+
 
     for _dev in "${!host_fs_types[@]}"; do
         $_func "$_dev" "${host_fs_types[$_dev]}" && _ret=0
@@ -527,7 +528,7 @@ for_each_host_dev_and_slaves_all()
     local _dev
     local _ret=1
 
-    [[ "${host_devs[@]}" ]] || return 0
+    [[ "${host_devs[@]}" ]] || return 2
 
     for _dev in "${host_devs[@]}"; do
         [[ -b "$_dev" ]] || continue
@@ -543,7 +544,7 @@ for_each_host_dev_and_slaves()
     local _func="$1"
     local _dev
 
-    [[ "${host_devs[@]}" ]] || return 0
+    [[ "${host_devs[@]}" ]] || return 2
 
     for _dev in "${host_devs[@]}"; do
         [[ -b "$_dev" ]] || continue
-- 
2.7.4
