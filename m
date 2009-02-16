From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 28/50] Remove dependency on plymouth for getroot, pass 1.
Date: Mon, 16 Feb 2009 14:06:41 -0500
Message-ID: <200902161906.n1GJ6fND028269@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=8cc53c16a0f7860a6b87c99c1504288225fb904b
Commit:     8cc53c16a0f7860a6b87c99c1504288225fb904b
Parent:     2c6fc388b0fc46e070b7f738bc906c42883034f5
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:42:38 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:41 2009 -0500

    [PATCH 28/50] Remove dependency on plymouth for getroot, pass 1.
---
 dracut                |    2 +-
 init                  |   13 +++++++++++--
 rules.d/63-luks.rules |    3 +--
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/dracut b/dracut
index 56695c1..630b78b 100755
--- a/dracut
+++ b/dracut
@@ -41,7 +41,7 @@ initdir=$(mktemp -d -t initramfs.XXXXXX)
 trap 'rm -rf "$initdir"' 0 # clean up after ourselves no matter how we die.
 
 # executables that we have to have
-exe="/bin/bash /bin/mount /bin/mknod /bin/mkdir /sbin/modprobe /sbin/udevd /sbin/udevadm /sbin/nash /sbin/pidof /bin/sleep /usr/sbin/chroot"
+exe="/bin/bash /bin/mount /bin/mknod /bin/mkdir /sbin/modprobe /sbin/udevd /sbin/udevadm /sbin/nash /sbin/pidof /bin/sleep /usr/sbin/chroot /bin/echo"
 lvmexe="/sbin/lvm"
 cryptexe="/sbin/cryptsetup"
 # and some things that are nice for debugging
diff --git a/init b/init
index 10a789b..ea06687 100755
--- a/init
+++ b/init
@@ -74,8 +74,17 @@ esac
 tries=0
 plymouth --update "Waiting up to 30 seconds for $root to become available"
 until [[ -e $root ]]; do
-  sleep 1
-  ((tries++ > 30)) && emergency_shell
+    [[ -f /cryptroot ]] && {
+	tries=27
+	cryptopts=$(< /cryptroot)
+	if [ -x /bin/plymouth ] && plymouth --ping; then
+	    /bin/plymouth ask-for-password \
+		--command "/sbin/cryptsetup luksOpen $cryptopts" && break
+	else
+	    /sbin/cryptsetup luksOpen $cryptopts && break
+	fi
+    sleep 1
+    ((tries++ > 30)) && emergency_shell
 done
 plymouth --update "Mounting rootfs after $tries seconds"
 ln -s "$root" /dev/root    
diff --git a/rules.d/63-luks.rules b/rules.d/63-luks.rules
index 5d8297b..ab907e9 100644
--- a/rules.d/63-luks.rules
+++ b/rules.d/63-luks.rules
@@ -8,7 +8,6 @@ SUBSYSTEM!="block", GOTO="luks_end"
 ACTION!="add|change", GOTO="luks_end"
 
 KERNEL!="sr*", IMPORT{program}="vol_id --export $tempnode"
-ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="/bin/plymouth ask-for-password --command '/sbin/cryptsetup luksOpen $env{DEVNAME} luks-$env{ID_FS_UUID}"
-
+ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="/echoer /cryptroot $env{DEVNAME} luks-$env{ID_FS_UUID}"
 
 LABEL="luks_end"
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
