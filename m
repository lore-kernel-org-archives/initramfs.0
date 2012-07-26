From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 5/7] dracut-lib: new functions: listlist and are_lists_eq
Date: Thu, 26 Jul 2012 15:05:25 +0200
Message-ID: <1343307927-17079-5-git-send-email-aidecoe@aidecoe.name>
References: <1343307927-17079-1-git-send-email-aidecoe@aidecoe.name>
 <1343307927-17079-2-git-send-email-aidecoe@aidecoe.name>
 <1343307927-17079-3-git-send-email-aidecoe@aidecoe.name>
 <1343307927-17079-4-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1343307927-17079-4-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

listlist is like strstr for lists with specified separator and
are_lists_eq uses listlist to check equality of specified lists.
---
 modules.d/99base/dracut-lib.sh |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 786661e..2eb1224 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -906,3 +906,41 @@ export_n()
         [ -n "$val" ] && eval $var=\"$val\"
     done
 }
+
+# returns OK if list1 contains all elements of list2, i.e. checks if list2 is a
+# sublist of list1.  An order and a duplication doesn't matter.
+#
+# $1 = separator
+# $2 = list1
+# $3 = list2
+# $4 = ignore values, separated by $1
+listlist() {
+    local _sep="$1"
+    local _list="${_sep}${2}${_sep}"
+    local _sublist="$3"
+    [ -n "$4" ] && local _iglist="${_sep}${4}${_sep}"
+    local IFS="$_sep"
+    local _v
+
+    [ "$_list" = "$_sublist" ] && return 0
+
+    for _v in $_sublist; do
+        if [ -n "$_v" ] && ! ( [ -n "$_iglist" ] && strstr "$_iglist" "$_v" )
+        then
+            strstr "$_list" "$_v" || return 1
+        fi
+    done
+
+    return 0
+}
+
+# returns OK if both lists contain the same values.  An order and a duplication
+# doesn't matter.
+# 
+# $1 = separator
+# $2 = list1
+# $3 = list2
+# $4 = ignore values, separated by $1
+are_lists_eq() {
+    listlist "$1" "$2" "$3" "$4" && listlist "$1" "$3" "$2" "$4"
+}
-- 
1.7.8.6
