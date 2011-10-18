From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 03/10] minor changes
Date: Tue, 18 Oct 2011 20:33:19 +0200
Message-ID: <1318962806-24000-4-git-send-email-soltys@ziu.info>
References: <1318962806-24000-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1318962806-24000-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

- in 10i18n - do stty -iutf8 on non-utf8 consoles, for consistency with
  iutf8 on utf8 ones
- vim modeline in xml file

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 dracut.kernel.7.xml           |    1 +
 modules.d/10i18n/console_init |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/dracut.kernel.7.xml b/dracut.kernel.7.xml
index 8d50d94..0571031 100644
--- a/dracut.kernel.7.xml
+++ b/dracut.kernel.7.xml
@@ -1,5 +1,6 @@
 <?xml version='1.0' encoding='UTF-8'?>
 <!-- This document was created with Syntext Serna Free. --><!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML V4.5//EN" "http://www.oasis-open.org/docbook/xml/4.3/docbookx.dtd" []>
+<!-- vim: set ts=8 sts=2 sw=2 et: -->
 <refentry id="dracutkernel7">
   <refentryinfo>
     <title>dracut.kernel</title>
diff --git a/modules.d/10i18n/console_init b/modules.d/10i18n/console_init
index 110cb0a..b46046b 100755
--- a/modules.d/10i18n/console_init
+++ b/modules.d/10i18n/console_init
@@ -22,6 +22,7 @@ set_terminal() {
         stty -F ${dev} iutf8
     else
         printf '\033%%@' >&7
+        stty -F ${dev} -iutf8
     fi
 }
 
-- 
1.7.5.3
