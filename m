From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH] debian: update standarts version
Date: Fri, 26 Feb 2010 15:39:34 +0100
Message-ID: <1267195175-15554-6-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 debian/control |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/debian/control b/debian/control
index 97d9594..47acf57 100644
--- a/debian/control
+++ b/debian/control
@@ -3,7 +3,7 @@ Section: utils
 Priority: optional
 Maintainer: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
 Build-Depends: debhelper (>= 5.0), cdbs
-Standards-Version: 3.8.3
+Standards-Version: 3.8.4
 Vcs-Browser: http://dracut.git.sourceforge.net/git/gitweb-index.cgi
 Vcs-Git: git://dracut.git.sourceforge.net/gitroot/dracut/dracut
 
-- 
1.7.0
