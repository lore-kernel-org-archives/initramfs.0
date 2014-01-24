From: Stig Telfer <stelfer-WVYJKLFxKCc@public.gmane.org>
Subject: [PATCHv2] dracut-lib.sh: bugfix for pidof function
Date: Fri, 24 Jan 2014 15:48:32 +0000
Message-ID: <E86DFAF410366A40AD1683994061D9D608FE12@CFWEX01.americas.cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

In follow-up, the patch requires a second mod: kernel tasks have a /proc/.../exe that links to nothing and derails the for loop:

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 85f7cdf..05fb1e4 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -967,9 +967,9 @@ if ! command -v pidof >/dev/null 2>/dev/null; then
         [ -z "$_cmd" ] && return 1
         _exe=$(type -P "$1")
         for i in /proc/*/exe; do
-            [ -e "$i" ] || return 1
+            [ -e "$i" ] || continue
             if [ -n "$_exe" ]; then
-                [ "$i" -ef "$_cmd" ] || continue
+                [ "$i" -ef "$_exe" ] || continue
             else
                 _rl=$(readlink -f "$i");
                 [ "${_rl%/$_cmd}" != "$_rl" ] || continue
