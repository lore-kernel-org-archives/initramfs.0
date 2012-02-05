From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [Patch] s/usrmove/convertfs/ in dracut.spec
Date: Sun,  5 Feb 2012 23:17:45 +0800
Message-ID: <1328455065-2162-1-git-send-email-xiyou.wangcong@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=N7ydXJuNIQDn0Ja+5MK9py/R99FPrVXRkCl8a+RtXnY=;
        b=c9dJcarH5r5mhCx6l7Ep5mgGWvaaSa7C9Mg26NZAfHdNECCeif0eVvohRKm5oxcu/f
         vcidqXqVi+1RIPP7/Q17Pg6IiauZX41V5r5XnUDRuv1g7B3KRFmBqnPZg6Z8sPoEvPOT
         sQfGoT/rya6ZlHJUuaD/jzkVoyjZUpr4dwwhg=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

commit 2cf328ad0ae7fb5ee7de8fac5652e4cd58adca1a (renamed
usrmove to convertfs) renamed usrmove, but forgot to change
dracut.spec.

Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
diff --git a/dracut.spec b/dracut.spec
index 10556d0..50c6af7 100644
--- a/dracut.spec
+++ b/dracut.spec
@@ -232,7 +232,7 @@ rm -rf $RPM_BUILD_ROOT
 %{dracutlibdir}/modules.d/05busybox
 %{dracutlibdir}/modules.d/10i18n
 %{dracutlibdir}/modules.d/10rpmversion
-%{dracutlibdir}/modules.d/30usrmove
+%{dracutlibdir}/modules.d/30convertfs
 %{dracutlibdir}/modules.d/50plymouth
 %{dracutlibdir}/modules.d/90btrfs
 %{dracutlibdir}/modules.d/90crypt
