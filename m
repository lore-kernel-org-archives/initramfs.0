From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2 v2] add function getargnum
Date: Wed, 28 Nov 2012 16:42:49 +0800
Message-ID: <50B5CE89.5030307@redhat.com>
References: <20121126023847.GA6884@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121126023847.GA6884-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jstancek-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org



For cmdline argument with numeric value, add a new function getargnum
It will get proper value with default value as $1, min value as $2,
max value as $3, and param name as $4. valid result will be echo to stdout.
for nul or value not valid it will just echo the default value.
Note: The values should be >=0

[v1->v2]: add arg <minval>

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/99base/dracut-lib.sh |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- dracut.orig/modules.d/99base/dracut-lib.sh
+++ dracut/modules.d/99base/dracut-lib.sh
@@ -167,6 +167,27 @@ getargbool() {
     return 0
 }
 
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
+        [[ "$_b" =~ ^[0-9]+$ ]] && _b=$(($_b)) && \
+        [[ $_b -ge $_min && $_b -le $_max ]] && echo $_b && return
+    fi
+    echo $_default
+}
+
 _dogetargs() {
     debug_off
     local _o _found _key
