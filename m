From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [PATCH 1/2 V3] add function getargnum
Date: Thu, 17 Jan 2013 16:55:50 +0800
Message-ID: <20130117085724.062434676@redhat.com>
References: <20130117085549.207542806@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=patch1
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jstancek-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

For cmdline argument with numeric value, add a new function getargnum
It will get proper value with default value as $1, min value as $2,
max value as $3, and param name as $4. valid result will be echo to stdout.
for nul or value not valid it will just echo the default value.
Note: The values should be >=0

[v1->v2]: add arg <minval>
[v2->v3]: do not use bash string match =~

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/99base/dracut-lib.sh |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

--- dracut.orig/modules.d/99base/dracut-lib.sh
+++ dracut/modules.d/99base/dracut-lib.sh
@@ -167,6 +167,35 @@ getargbool() {
     return 0
 }
 
+isdigit() {
+    case "$1" in
+        *[!0-9]*|"") return 1;;
+    esac
+
+    return 0
+}
+
+# getargnum <defaultval> <minval> <maxval> <arg>
+# Will echo the arg if it's in range [minval - maxval].
+# If it's not set or it's not valid, will set it <defaultval>.
+# Note all values are required to be >= 0 here.
+# <defaultval> should be with [minval -maxval].
+getargnum() {
+    local _b
+    unset _b
+    local _default _min _max
+    _default=$1; shift
+    _min=$1; shift
+    _max=$1; shift
+    _b=$(getarg "$1")
+    [ $? -ne 0 -a -z "$_b" ] && _b=$_default
+    if [ -n "$_b" ]; then
+        isdigit "$_b" && _b=$(($_b)) && \
+        [[ $_b -ge $_min && $_b -le $_max ]] && echo $_b && return
+    fi
+    echo $_default
+}
+
 _dogetargs() {
     debug_off
     local _o _found _key
