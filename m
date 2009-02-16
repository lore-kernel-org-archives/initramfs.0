From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 19/50] The function keyword is deprecated.  Get rid of it.
Date: Mon, 16 Feb 2009 14:06:23 -0500
Message-ID: <200902161906.n1GJ6Nd6028009@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=6b24de99d9b9a78496d4aca9e5d55de45bcd8341
Commit:     6b24de99d9b9a78496d4aca9e5d55de45bcd8341
Parent:     95994c57c572c4442f911560fe5cbedead2df56e
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:42:15 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:41 2009 -0500

    [PATCH 19/50] The function keyword is deprecated.  Get rid of it.
---
 dracut-functions |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 8f12021..7f9dfcd 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -24,13 +24,13 @@
 #
 #
 
-function set_verbose() {
+set_verbose() {
     foo=""
 }
 
 IF_RTLD=""
 IF_dynamic=""
-function get_dso_deps() {
+get_dso_deps() {
     local bin="$1" ; shift
 
     declare -a FILES
@@ -96,7 +96,7 @@ EOF
     echo "${FILES[@]}"
 }
 
-function inst() {
+inst() {
     if [ "$#" != "2" -a "$#" != "3" ];then
         echo "usage: inst <file> <root> [<destination file>]"
         return 1
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
