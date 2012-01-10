From: xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH] lsinitrd: add '-s' option to sort the initrd output by file size
Date: Tue, 10 Jan 2012 22:45:45 +0800
Message-ID: <1326206745-20801-1-git-send-email-xiyou.wangcong@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=POK5ON4LFqZ5yQJl7lUbZpjEsA8mrBAM8jlBuFqok+w=;
        b=tcD/VnxKWUC9Tv79tbimKy+0XXmj6a78bnI/1Obbi4mpGmR4mtu3RskQePaRNvVTHH
         2/dTT4uHlK4vhfN14YKPaE1/UhoBWeD0UCoPEQU6hk9zmISTlDXL52+D+VPMwgTZUI3L
         P5cfexM2COJVFjmGV+IxdT0Z7pwY8lF6c3h6Q=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This is useful to analyse which files consume the space of initrd.

Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 lsinitrd |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/lsinitrd b/lsinitrd
index 7da9f61..ad7ece9 100755
--- a/lsinitrd
+++ b/lsinitrd
@@ -19,7 +19,17 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-[[ $# -le 2 ]] || { echo "Usage: $(basename $0) [<initramfs file> [<filename>]]" ; exit 1 ; }
+[[ $# -le 2 ]] || { echo "Usage: $(basename $0) [-s] [<initramfs file> [<filename>]]" ; exit 1 ; }
+
+sorted=0
+while getopts "s" opt; do
+    case $opt in
+        s)  sorted=1;;
+        \?) exit 1;;
+    esac
+done
+shift $((OPTIND-1))
+
 image="${1:-/boot/initramfs-$(uname -r).img}"
 [[ -f "$image" ]]    || { echo "$image does not exist" ; exit 1 ; }
 
@@ -45,5 +55,9 @@ echo "$image: $(du -h $image | awk '{print $1}')"
 echo "========================================================================"
 $CAT "$image" | cpio --extract --verbose --quiet --to-stdout 'lib/dracut/dracut-*' 2>/dev/null
 echo "========================================================================"
-$CAT "$image" | cpio --extract --verbose --quiet --list
+if [ "$sorted" -eq 1 ]; then
+    $CAT "$image" | cpio --extract --verbose --quiet --list | sort -n -k5
+else
+    $CAT "$image" | cpio --extract --verbose --quiet --list
+fi
 echo "========================================================================"
-- 
1.7.7.5
