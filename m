From: Christian Heinz <christian.ch.heinz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] dracut: create ldconfig aux cache directory on the initrd
Date: Tue,  7 Dec 2010 02:44:19 +0100
Message-ID: <1291686260-32371-1-git-send-email-christian.ch.heinz@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=qO6RVN3MsLfF2Eqz5TTwMaEdgI2QncnbNRwS1/zsacY=;
        b=g7K2siwR6oWS5SSt7/DX/Eyw8AOYy9KZ3HwRhfunM/+MxzjAgLGj414D8fFFrCH8bs
         cy+PW5Bx7DRIzLPlCNlMJUAyoS5tQOqHgMeveNu8dTCJ992c8NjoH1uyZQV/Ga4cAtYz
         3RLY6eWFdb7bvSHjw/uBDvFKbP4wl8hc2EVSk=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Christian Heinz <christian.ch.heinz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This will allow ldconfig to create its auxiliary cache file in order to
prevent `ldconfig -r' from failing completely when dracut is run as
non-root. Applies to glibc/ldconfig versions released before Nov 22,
2010.
---
 dracut |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/dracut b/dracut
index 303d817..5cdd313 100755
--- a/dracut
+++ b/dracut
@@ -350,6 +350,7 @@ unset item
 
 # make sure that library links are correct and up to date
 cp -ar /etc/ld.so.conf* "$initdir"/etc
+mkdir -p "$initdir/var/cache/ldconfig"
 ldconfig -r "$initdir" || [[ $UID != "0" ]] && \
     dinfo "ldconfig might need uid=0 (root) for chroot()"
 
-- 
1.7.3.3
