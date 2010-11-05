From: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] 95rootfs-block: fix missing root when label contains slash
Date: Fri,  5 Nov 2010 16:31:56 +0300
Message-ID: <1288963916-3609-1-git-send-email-arvidjaar@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:to;
        bh=qoYuhBA077fcSIu9b/6n0vgWW1USIydPut1qdtznPx8=;
        b=w2KZaj8b/45mJow46Airrot4CiYHklJqBBMJeOVZufD2bn0gqqg6GgB9udMt0YALkS
         pTrbPyHCZ9Wfk9Y00Zs0mP57B4/xOVfKaQMUsE5ukRV+zrfi4AnCQpGzbSnD9+ch/dvb
         tkDXwKirMNtl7HGuclliv/A0N/EFv5qFQuACE=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

It is not clearly documented, but apparently fsck
(or, probably, getmntent) is using backslash as
escape character.

Label containing slash is converted to \x2f but '\'
is eaten by fsck later. Escape '\' before writing
into fstab.

Signed-off-by: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
 modules.d/95rootfs-block/mount-root.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/modules.d/95rootfs-block/mount-root.sh b/modules.d/95rootfs-block/mount-root.sh
index ff64209..493b54b 100755
--- a/modules.d/95rootfs-block/mount-root.sh
+++ b/modules.d/95rootfs-block/mount-root.sh
@@ -106,7 +106,9 @@ if [ -n "$root" -a -z "${root%%block:*}" ]; then
             done
     fi
 
-    echo ${root#block:} "$NEWROOT" "$rootfs" ${rflags},${rootopts} 1 1 > /etc/fstab
+    # backslashes are treated as escape character in fstab
+    esc_root=$(echo ${root#block:} | sed ',\\,\\\\,g')
+    echo "$esc_root" "$NEWROOT" "$rootfs" ${rflags},${rootopts} 1 1 > /etc/fstab
 
     if [ -z "$fastboot" -a "$READONLY" != "yes" ]; then
         info "Checking filesystems"
-- 
tg: (921f4b5..) upstream/rootdev (depends on: master)
