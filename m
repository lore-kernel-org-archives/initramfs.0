From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] inst_symlink: create parent dir if doesn't exist
Date: Mon, 26 Mar 2012 00:11:53 +0200
Message-ID: <1332713513-17889-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

If symlink is yet alone in target directory, inst_symlink will fail to
create it.  This is how to reproduce the bug:

 # mkdir /tmp/test
 # ln -s /bin/cp /tmp/test/cp
 # ./dracut -l -f -H /tmp/test.img -I /tmp/test/cp

Result:

[...]

I: *** Including modules done ***
ln: failed to create symbolic link
`/var/tmp/initramfs.Z5isVu//tmp/test/cp': No such file or directory
ln: failed to create symbolic link
`/var/tmp/initramfs.Z5isVu//tmp/test/cp': No such file or directory
I: Wrote /tmp/test.img:

[...]

Following patch creates directory for the symlink if it doesn't exist.
---
 dracut-functions.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/dracut-functions.sh b/dracut-functions.sh
index f4ccf53..adca47d 100755
--- a/dracut-functions.sh
+++ b/dracut-functions.sh
@@ -545,8 +545,11 @@ inst_symlink() {
             inst "$_realsrc"
         fi
     fi
+    set -x
+    [[ ! -e $initdir/${_target%/*} ]] && inst_dir "${_target%/*}"
     [[ -d ${_target%/*} ]] && _target=$(readlink -f ${_target%/*})/${_target##*/}
     ln -sfn $(convert_abs_rel "${_target}" "${_realsrc}") "$initdir/$_target"
+    set +x
 }
 
 # attempt to install any programs specified in a udev rule
-- 
1.7.8.5
