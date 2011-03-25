From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 7/9] dracut-logger: /dev/log is socket, not character device
Date: Fri, 25 Mar 2011 15:56:50 +0100
Message-ID: <1301065012-16356-7-git-send-email-aidecoe@aidecoe.name>
References: <1301065012-16356-1-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-2-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-3-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-4-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-5-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-6-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1301065012-16356-6-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

Fixed typo in error message by the way.
---
 dracut-logger |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/dracut-logger b/dracut-logger
index 7bd2a7c..3bcce83 100755
--- a/dracut-logger
+++ b/dracut-logger
@@ -137,12 +137,12 @@ dlog_init() {
     fi
 
     if [ $sysloglvl -gt 0 ]; then
-        if ! [ -c /dev/log -a -w /dev/log ] || ! command -v logger >/dev/null
+        if ! [ -S /dev/log -a -w /dev/log ] || ! command -v logger >/dev/null
         then
             # We cannot log to syslog, so turn this facility off.
             sysloglvl=0
             ret=1
-            errmsg="No '/dev/log' or 'logger' not included for syslog logging"
+            errmsg="No '/dev/log' or 'logger' included for syslog logging"
         fi
     fi
 
-- 
1.7.4.1
