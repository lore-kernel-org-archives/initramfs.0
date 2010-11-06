From: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] 95rootfs-block: fix missing root when label contains slash
Date: Sun,  7 Nov 2010 00:46:53 +0300
Message-ID: <1289080013-3525-1-git-send-email-arvidjaar@gmail.com>
References: <1288963916-3609-1-git-send-email-arvidjaar@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references:to;
        bh=oCKaY7Y+7iIrmXTPjrHrVyCLWUxBfSZx6O9I8O9oteE=;
        b=nVDNvG0kDyF71XX4v5AHTZqJHjM3l4CJwiKJrhniLuwIKQDyoEclKSEI7guMC5glqw
         MXhWlum7gSsGPzDWsyOR8tByNehIIscVdVWuHQEPInb9N3Vf3PtIyceMCXY6aGTrDDzN
         7Uuh1MfRCmQT3KuXIZi+Sfz4YfaJNB08lWOdg=
In-Reply-To: <1288963916-3609-1-git-send-email-arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

v2:
- fix sed expression
- use printf instead of echo because echo eats '\' as well

Signed-off-by: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
 modules.d/95rootfs-block/mount-root.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/modules.d/95rootfs-block/mount-root.sh b/modules.d/95rootfs-block/mount-root.sh
index ff64209..9065bed 100755
--- a/modules.d/95rootfs-block/mount-root.sh
+++ b/modules.d/95rootfs-block/mount-root.sh
@@ -106,7 +106,9 @@ if [ -n "$root" -a -z "${root%%block:*}" ]; then
             done
     fi
 
-    echo ${root#block:} "$NEWROOT" "$rootfs" ${rflags},${rootopts} 1 1 > /etc/fstab
+    # backslashes are treated as escape character in fstab
+    esc_root=$(echo ${root#block:} | sed 's,\\,\\\\,g')
+    printf "%s $NEWROOT $rootfs ${rflags},${rootopts} 1 1\n" "$esc_root" > /etc/fstab
 
     if [ -z "$fastboot" -a "$READONLY" != "yes" ]; then
         info "Checking filesystems"
-- 
tg: (1c29003..) upstream/rootdev (depends on: master)
