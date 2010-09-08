From: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH] 98syslog: try to dynamically check for rsyslog moddir
Date: Wed, 08 Sep 2010 18:52:13 +0400
Message-ID: <20100908145213.31091.74875.stgit@cooker>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Cc:From:To:Subject; bh=QX54AsZ3xChqDnXTVSqRHJBllz73uLRp0bDtcaNbEkQ=;
	b=1RwZx2F/NpCrZYRPJwzX5RmV4K0q0LAVqLNDLAIA2XswzjicRumVnE88LjeydJ5KRqz/AcUJidXCCxNakAdw1kRBqWIliExVzuEO7h/3MDXPL5Fo3ztsaoeIqE5tACjF;
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: rsyslog-4gKAAF5ltrKNkp5+ER1W/AC/G2K4zDHf@public.gmane.org, tpg-4qZELD6Fgxhg9hUCZPvPmw@public.gmane.org

Thomas pointed out that default module path may not be correct
(Mandriva installs modules under architecture dependent path).
Unfortunately rsyslog does not seem to offer any way to query for
default configuration values. Here is rather hack - try to load
non-existing module and fetch path from error message.

Example of error message from version 4.6.4:

rsyslogd: could not load module '/lib64/rsyslog/_No_sUcH_MOduLe.so', dlopen: /lib64/rsyslog/_No_sUcH_MOduLe.so: cannot open shared object file: No such file or directory

Signed-off-by: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>

---

 modules.d/98syslog/install |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/modules.d/98syslog/install b/modules.d/98syslog/install
index 1fd1b6f..e3d02bf 100755
--- a/modules.d/98syslog/install
+++ b/modules.d/98syslog/install
@@ -1,6 +1,21 @@
 #!/bin/sh
 if type -P rsyslogd >/dev/null; then
-	installs="rsyslogd /lib/rsyslog/lmnet.so /lib/rsyslog/imklog.so /lib/rsyslog/imuxsock.so"
+	# module path can be changed during build and currently rsyslog
+	# does not provide any means to query for it. Use hack - try to
+	# load non-existent module and look at error message
+	R_CONF=/tmp/dracut.rsyslog.conf.$$
+	R_ERR=/tmp/dracut.rsyslog.err.$$
+	R_MODDIR=
+	echo '$ModLoad _No_sUcH_MOduLe' > $R_CONF
+	if [ -s $R_CONF ]; then
+		rsyslogd -N 1 -f $R_CONF 2> $R_ERR > /dev/null
+		R_MODDIR=$(grep ' could not load module .*_No_sUcH_MOduLe' $R_ERR)
+		R_MODDIR=${R_MODDIR#*could not load module \'}
+		R_MODDIR=${R_MODDIR%\', *}
+		R_MODDIR=${R_MODDIR%/*}
+	fi
+	[ -n "$R_MODDIR" ] || R_MODDIR=/lib/rsyslog
+	installs="rsyslogd $R_MODDIR/lmnet.so $R_MODDIR/imklog.so $R_MODDIR/imuxsock.so"
 elif type -P syslogd >/dev/null; then
     installs="syslogd"
 elif type -P syslog-ng >/dev/null; then
