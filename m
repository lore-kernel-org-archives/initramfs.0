From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: [PATCH] resume/module-setup.sh: filter out empty resume= options in
 cmdline()
Date: Fri, 16 May 2014 21:12:36 +0400
Message-ID: <E1WlLlY-0007GR-QD@puleglot.ru>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Message-Id:To:Subject:Date:From; bh=QOqzwTj1xRnDJUX9SzT3EH64nIMVZ3/4r8RssQalVp8=;
	b=evnXW2HTAml5h+HrdhFya9AA8jl6G2wEfq4rU4WMmr7uL+ID/gq7JaV63IL9L6TLqOG2/CeictWsOpFGLUxBIJH34pd8sJkliPCRIrbTQeAdLJhi3OH3Ms4FwYaoIgWgZjakXpBshvQl4MHTwPNchr1TP6ZwRUYjQtTRSbTXrwg=;
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

cmdline() prints empty "resume=" options for non-persistent swap
devices, for example zram. Add a check for that.

This patch also fixes printf formatting and removes unused variables.
---
 modules.d/95resume/module-setup.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/modules.d/95resume/module-setup.sh b/modules.d/95resume/module-setup.sh
index ceb7855..b1b4684 100755
--- a/modules.d/95resume/module-setup.sh
+++ b/modules.d/95resume/module-setup.sh
@@ -17,12 +17,12 @@ check() {
 
 # called by dracut
 cmdline() {
-    local _activated
-    declare -A _activated
+    local _resume
 
     for dev in "${!host_fs_types[@]}"; do
         [[ ${host_fs_types[$dev]} =~ ^(swap|swsuspend|swsupend)$ ]] || continue
-        printf "resume=%s " "$(shorten_persistent_dev "$(get_persistent_dev "$dev")")"
+        _resume=$(shorten_persistent_dev "$(get_persistent_dev "$dev")")
+        [[ -n ${_resume} ]] && printf " resume=%s" "${_resume}"
     done
 }
 
-- 
1.8.5.5
