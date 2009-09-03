From: Joe Pelkey <pelkeyj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: ls to stat patch
Date: Thu, 03 Sep 2009 02:33:41 -0400
Message-ID: <4A9F6345.4050003@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060504020106050500050007"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type;
        bh=5QTGN8fAImY4qtVMtaIpljY4nHx+mWoSh09F1WM9ftU=;
        b=MyQZHZJVdH1UGeA8Q6DhWCt0VMxBTMLjGTpmMRENsQNm81a4+Kv7PQ5z24g47ZK1jw
         V3ASb31PytsalWJzQzkrnFmyFkX+7u4VadiDSJjQPrlSdRZFJS3TSwqEs0h87mxEtXYm
         RQ+12s14O4vSoHiu+RdNdAwO98XFeuiOyVppU=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a multi-part message in MIME format.
--------------060504020106050500050007
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,
I was randomly looking through the git repository and came across
modules.d/95resume/resume.sh and its comment about not liking the use of
ls.  I modified it to use stat instead, and since stat has been in
coreutils since at least late 2005, I assume it's safe to use.

Thanks




--------------060504020106050500050007
Content-Type: text/plain;
 name="ls_to_stat.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ls_to_stat.diff"

diff -rN -U 5 dracut-001.orig/modules.d/95resume/resume.sh dracut-001/modules.d/95resume/resume.sh
--- dracut-001.orig/modules.d/95resume/resume.sh	2009-09-02 09:55:35.000000000 -0400
+++ dracut-001/modules.d/95resume/resume.sh	2009-09-03 02:29:27.000000000 -0400
@@ -1,8 +1,5 @@
 #!/bin/sh
 [ -s /.resume -a -b "$resume" ] && {
-    # parsing the output of ls is Bad, but until there is a better way...
-    ls -lH "$resume" | ( 
-	read x x x x maj min x;
-	echo "${maj%,}:$min"> /sys/power/resume)
+    stat -c '%t:%T' "$resume" > /sys/power/resume
     >/.resume
 }
diff -rN -U 5 dracut-001.orig/modules.d/99base/install dracut-001/modules.d/99base/install
--- dracut-001.orig/modules.d/99base/install	2009-09-02 09:55:35.000000000 -0400
+++ dracut-001/modules.d/99base/install	2009-09-03 02:00:35.000000000 -0400
@@ -1,8 +1,8 @@
 #!/bin/bash
 dracut_install mount mknod mkdir modprobe pidof sleep chroot \
-    sed ls flock cp mv dmesg rm ln
+    sed ls flock cp mv dmesg rm ln stat
 if [ ! -e "${initdir}/bin/sh" ]; then
     dracut_install bash
     (ln -s bash "${initdir}/bin/sh" || :)
 fi
 # install our scripts and hooks


--------------060504020106050500050007--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
