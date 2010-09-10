From: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] Be sure and get the right architecture for rsylogd modules.
Date: Fri, 10 Sep 2010 11:32:24 -0400
Message-ID: <1284132744-6659-1-git-send-email-pjones@redhat.com>
References: <4C8A4B91.20905@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C8A4B91.20905-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

I've tested this locally on 64-bit with:

dracut -a syslog -f -v foo.img `uname -r`

And I see this in the output:

I: *** Sourcing module syslog
I: Installing /sbin/rsyslogd
I: Installing /lib64/rsyslog/lmnet.so
I: Installing /lib64/rsyslog/imklog.so
I: Installing /lib64/rsyslog/imuxsock.so
I: Installing /usr/share/dracut/modules.d/98syslog/parse-syslog-opts.sh
I: Installing /usr/share/dracut/modules.d/98syslog/syslog-genrules.sh
I: Installing /usr/share/dracut/modules.d/98syslog/syslog-cleanup.sh
I: Installing /usr/share/dracut/modules.d/98syslog/rsyslogd-start.sh
I: Installing /usr/share/dracut/modules.d/98syslog/rsyslogd-stop.sh
I: Installing /usr/share/dracut/modules.d/98syslog/rsyslog.conf
---
 modules.d/98syslog/install |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/98syslog/install b/modules.d/98syslog/install
index ed5958e..dfaddf3 100755
--- a/modules.d/98syslog/install
+++ b/modules.d/98syslog/install
@@ -3,7 +3,7 @@
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 
 if type -P rsyslogd >/dev/null; then
-    installs="rsyslogd /lib/rsyslog/lmnet.so /lib/rsyslog/imklog.so /lib/rsyslog/imuxsock.so"
+    installs="rsyslogd /lib*/rsyslog/lmnet.so /lib*/rsyslog/imklog.so /lib*/rsyslog/imuxsock.so"
 elif type -P syslogd >/dev/null; then
     installs="syslogd"
 elif type -P syslog-ng >/dev/null; then
-- 
1.7.2.3
