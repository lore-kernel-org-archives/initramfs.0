From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 6/5] cryptsetup does not like running in a while read loop.
Date: Sun, 22 Feb 2009 00:22:36 -0600
Message-ID: <1235283756.5184.1.camel@sentry-no.fnordovax.org>
References: <68c572a7f9fd38b23b15f8f022be29026f0d9485.1235233199.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:in-reply-to
         :references:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=TOxMKy4GMApTyLEyx/rt0A7iEEzGvHgF7ziRRnAKcvg=;
        b=qMqw4I1QLes59Y0ZWWHGXii00OosGe+8Yh1RXtnyQ6poHIMknVCK+pZNYVqjIcSuhf
         JyR7pvcQ/5lHS8MP3qMbXlSNqcgrek+aZJURxb0JU2Z0/LqmJHTc4mXP/xbOwf00j9RB
         pGraGDyHuaFU+ARMPM383vJpF9CH3uBYnHj2M=
In-Reply-To: <68c572a7f9fd38b23b15f8f022be29026f0d9485.1235233199.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Add some additional manglage to ensure that stdin/stdout is always pointing 
the right thing.  A more elegant way of doing this would be much appreciated

---
 hooks/cryptroot.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/hooks/cryptroot.sh b/hooks/cryptroot.sh
index 739f5d3..4a4abb3 100755
--- a/hooks/cryptroot.sh
+++ b/hooks/cryptroot.sh
@@ -2,7 +2,9 @@
 [ -s /cryptroot ] && { 
     udevadm control --stop_exec_queue
     while read cryptopts; do
-       /sbin/cryptsetup luksOpen $cryptopts
+       (   exec >/dev/console 2>&1 </dev/console
+           /sbin/cryptsetup luksOpen $cryptopts || emergency_shell
+       )
     done </cryptroot
     >/cryptroot
     udevadm control --start_exec_queue


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
