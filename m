From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [Patch] dracut-functions: use braces for function
Date: Tue, 31 Jan 2012 15:11:12 +0800
Message-ID: <1327993872-25808-1-git-send-email-xiyou.wangcong@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=yYZ1tHj/ByADpofsbpu9G0bBSGvCuT6ZVmus0xKDC7A=;
        b=RSSh9PTPHXykopOcUw8XMhPrcKEwMI1ZP5hBr/vhrAZoX2rqB8KZO0hRm9JLmmhqCR
         ZVofy12PzXxsBrvquRpbHwxcEvfB/hG0esSB/tDdQhBDmhPrFoLgB60suHaVm6hSKlRA
         g8rutEbi6tZXq5firnwOjghGGE1fXQ2+t6rys=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Although parenthesis probably also works, it is normal to use
braces.

Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
diff --git a/dracut-functions b/dracut-functions
index e04b16d..97094db 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -979,7 +979,7 @@ for_each_kmod_dep() {
 # If it is, we will only look at modules that are already in memory.
 # If it is not, we will look at all kernel modules
 # This function returns the full filenames of modules that match $1
-filter_kernel_modules_by_path () (
+filter_kernel_modules_by_path () {
     local _modname _filtercmd
     if ! [[ $hostonly ]]; then
         _filtercmd='find "$srcmods/kernel/$1" "$srcmods/extra"'
@@ -1003,8 +1003,9 @@ filter_kernel_modules_by_path () (
                 ;;
         esac
     done
-)
-find_kernel_modules_by_path () (
+}
+
+find_kernel_modules_by_path () {
     if ! [[ $hostonly ]]; then
         find "$srcmods/kernel/$1" "$srcmods/extra" "$srcmods/weak-updates" \
           -name "*.ko" -o -name "*.ko.gz" -o -name "*.ko.xz" 2>/dev/null
@@ -1012,7 +1013,7 @@ find_kernel_modules_by_path () (
         cut -d " " -f 1 </proc/modules \
         | xargs modinfo -F filename -k $kernel 2>/dev/null
     fi
-)
+}
 
 filter_kernel_modules () {
     filter_kernel_modules_by_path  drivers  "$1"
