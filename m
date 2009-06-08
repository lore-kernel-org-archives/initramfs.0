From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH 10/11] NBD: fix parsing of Debian-style nbdroot config
Date: Mon,  8 Jun 2009 00:40:23 -0400
Message-ID: <61752d529af14fdb428bf9d276d871d235d39c01.1244435634.git.dave@thedillows.org>
References: <cover.1244435634.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1244435634.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
In-Reply-To: <cover.1244435634.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
References: <cover.1244435634.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>

---
 modules.d/95nbd/parse-nbdroot.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/95nbd/parse-nbdroot.sh b/modules.d/95nbd/parse-nbdroot.sh
index 84d1c23..ba40207 100755
--- a/modules.d/95nbd/parse-nbdroot.sh
+++ b/modules.d/95nbd/parse-nbdroot.sh
@@ -34,7 +34,7 @@ case "$root" in
     nbd:*,*)
 	if check_occurances "$root" ',' 1 && check_occurances "$root" ':' 1;
 	then
-	    root=${root%*,}:${root#*,}
+	    root=${root%,*}:${root#*,}
 	fi
 	;;
 esac
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
