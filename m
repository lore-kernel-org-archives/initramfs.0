From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 28/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:36:47 -0800 (PST)
Message-ID: <455a08b8ff6adb841b64f47a53e14de7a6b414cd.1234137268.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=0RZYtYeyPezoqBNG1OIbb5FdUR2waUtoaPtyewUyBQo=;
        b=xxpFVQyVkFqPe2pVzIsxHMvY8PqGLe4Y9kJYT6PgqRyVNN8rsy37CKhgLVSDlx6snj
         ymiyyNEY1yiyKnmBJJtB7PNU7ajLx7zweRXlJTUZhaixLNdGbeRKmVy4GjSjpx+u+Znf
         gquDGuVxK3s2rKopiy8HSCAj08KiNjEkbhPZg=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Remove dependency on plymouth for getroot, pass 1.

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
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
