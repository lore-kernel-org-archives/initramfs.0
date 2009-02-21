From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/5] We now support mounting the rootfs rw.
Date: Sat, 21 Feb 2009 08:24:30 -0800 (PST)
Message-ID: <388b1cc8f3a892735cf3603f3c889b41330e8969.1235233199.git.victor.lowther@gmail.com>
References: <68c572a7f9fd38b23b15f8f022be29026f0d9485.1235233199.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=nPluEm3i5IbRsSWywjiIoCT07xKJKPfwaF2pKohDIv0=;
        b=UDRd9ZxX/gkduaiLaQsSQ3psa4hQlVn0Mm0S4iO4SLyQ/BlLwJF1FXHcSCdRj+Nls5
         mvhwLM7W7KUMV/GNCYrmzcPUEwtJcKHQNZFqN3+0Vaqn5Ln6mYYiXln9TNqVtOlunVpK
         TGyCADgbDqUc+phhn4AYmru2DRs44h/WH9Ypg=
In-Reply-To: <68c572a7f9fd38b23b15f8f022be29026f0d9485.1235233199.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 init |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/init b/init
index ee1123c..7b0c61b 100755
--- a/init
+++ b/init
@@ -79,9 +79,10 @@ udevadm settle --timeout=30
 source_all pre-mount
 
 echo "Trying to mount rootfs $root"
+rwopt="$(getarg rw)" || rwopt="ro"
 [ -e "$root" ] || emergency_shell
 ln -s "$root" /dev/root    
-mount -o ro /dev/root $NEWROOT || emergency_shell
+mount -o $rwopt /dev/root $NEWROOT || emergency_shell
 
 INIT=$(getarg init)
 [ "$INIT" ] || {
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
