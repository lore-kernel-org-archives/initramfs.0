From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 1/2] dracut-functions.sh: support for alternative udev dirs - udevaltdirs
Date: Wed, 23 Jan 2013 19:37:18 +0100
Message-ID: <1358966239-19496-1-git-send-email-aidecoe@aidecoe.name>
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

Credits go to Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>.
---
 dracut-functions.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/dracut-functions.sh b/dracut-functions.sh
index e23db76..812ea2b 100755
--- a/dracut-functions.sh
+++ b/dracut-functions.sh
@@ -941,6 +941,15 @@ inst_rules() {
     inst_dir "$_target"
     for _rule in "$@"; do
         if [ "${_rule#/}" = "$_rule" ]; then
+            for r in ${udevaltdirs}; do
+                [[ "$r" = "${udevdir}" ]] && continue
+                if [[ -f $r/rules.d/$_rule ]]; then
+                    _found="$r/rules.d/$_rule"
+                    inst_rule_programs "$_found"
+                    inst_rule_group_owner "$_found"
+                    inst_simple "$_found" "${udevdir}/rules.d/${_found##*/}"
+                fi
+            done
             for r in ${udevdir}/rules.d /etc/udev/rules.d; do
                 if [[ -f $r/$_rule ]]; then
                     _found="$r/$_rule"
-- 
1.8.1.1
