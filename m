From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 1/2] dracut-functions.sh: support for alternative udev dirs - udevaltdirs
Date: Sun, 16 Dec 2012 20:05:19 +0100
Message-ID: <1355684720-25274-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

It is required for Gentoo which moves udev from / to /usr and supports
both /lib/udev and /usr/lib/udev for compatibility with other packages.
---
 dracut-functions.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/dracut-functions.sh b/dracut-functions.sh
index f1c797c..4a9ebbb 100755
--- a/dracut-functions.sh
+++ b/dracut-functions.sh
@@ -896,12 +896,18 @@ inst_rule_group_owner() {
 # create a function to install them to make life simpler.
 inst_rules() {
     local _target=/etc/udev/rules.d _rule _found
+    local _rules_dirs=( "$udevdir/rules.d" "/etc/udev/rules.d" )
+    local _d
+
+    for _d in $udevaltdirs; do
+        _rules_dirs+=( "$_d/rules.d" )
+    done
 
     inst_dir "${udevdir}/rules.d"
     inst_dir "$_target"
     for _rule in "$@"; do
         if [ "${rule#/}" = "$rule" ]; then
-            for r in ${udevdir}/rules.d /etc/udev/rules.d; do
+            for r in "${_rules_dirs[@]}"; do
                 if [[ -f $r/$_rule ]]; then
                     _found="$r/$_rule"
                     inst_rule_programs "$_found"
-- 
1.8.0.2
