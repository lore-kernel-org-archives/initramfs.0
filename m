From: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Debian/Ubuntu patches
Date: Tue, 9 Nov 2010 12:11:58 +0100
Message-ID: <AANLkTi=EkL7ivKKj6ck3w6RuOOq++cGwtP_pX0HHhVWu@mail.gmail.com>
References: <AANLkTikEPsCQzMSJbhwuO95Br+7aYJPw9zbVRd4Y8vOC@mail.gmail.com>
	<4CD9102B.7030702@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=ncGa/h8CdKDJRw8+Khticvux0hqAwxWt4IYWGYjEFAc=;
        b=StzszRCDHlQ67h9t2yh0xmgLr73eTIYvK5uQkWsb6b4Eah5la9mN1Rn8ysO6YW5bHy
         n+7dtkmSzkAt03HY1m6XzrZk//wKokJle+LX6iyJkFaiWiwTD9CM8d6V31Ak8xHGiiAG
         up9qwHowZyXEe5UeD2l9hF7lCKjJhuYcSrQ24=
In-Reply-To: <4CD9102B.7030702-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

2010/11/9 Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>:
> Hi Jon,
>
> On 11/08/2010 07:50 PM, Jon Ander Hernandez wrote:
>>
>> Hello,
>>
>> I post the patches as I promised :-)
>
> I repeat Maximilian's comment: Please post patches inline.

Ops I'm sorry, I readed the mailing list's guidelines, and I thought
that a patch (inlined) was also considered an attachment.



- When a new kernel is installed or uninstalled dracut based initramfs
is not automatically created/deleted. Ubuntu's kernel package's post
script executes update-initramfs directly, and the update-initramfs
trigger is never fired.
Another solution is to install a postinst and a postrm script under
/etc/kernel/{postrm.d,prerm.d}.

diff -urN dracut/debian/dracut.install dracut-007/debian/dracut.install
--- dracut/debian/dracut.install	2010-08-09 16:13:51.000000000 +0200
+++ dracut-007/debian/dracut.install	2010-10-21 02:49:45.714564995 +0200
@@ -4,6 +4,8 @@
 dracut-gencmdline	usr/sbin
 dracut-functions	usr/share/dracut
 dracut.conf		etc
+dracut-postinst.d	etc/kernel/postinst.d
+dracut-prerm.d		etc/kernel/prerm.d
 modules.d/00dash		usr/share/dracut/modules.d
 modules.d/01fips		usr/share/dracut/modules.d
 modules.d/60xen			usr/share/dracut/modules.d
diff -urN dracut/dracut-postinst.d dracut-007/dracut-postinst.d
--- dracut/dracut-postinst.d	1970-01-01 01:00:00.000000000 +0100
+++ dracut-007/dracut-postinst.d	2010-10-21 02:49:45.714564995 +0200
@@ -0,0 +1,4 @@
+#!/bin/bash
+
+version=$1
+dracut-update-initramfs -c -k ${version}
diff -urN dracut/dracut-prerm.d dracut-007/dracut-prerm.d
--- dracut/dracut-prerm.d	1970-01-01 01:00:00.000000000 +0100
+++ dracut-007/dracut-prerm.d	2010-10-21 02:49:45.714564995 +0200
@@ -0,0 +1,4 @@
+#!/bin/bash
+
+version=$1
+dracut-update-initramfs -d -k ${version}


- Postinst script can be executed when installing first time dracut,
and when we are upgrading Dracut. Check if it should create a new
initramfs or if it should upgrade it.

diff -urN dracut/debian/dracut.postinst dracut-007/debian/dracut.postinst
--- dracut/debian/dracut.postinst	2010-08-09 16:13:51.000000000 +0200
+++ dracut-007/debian/dracut.postinst	2010-10-21 02:49:45.714564995 +0200
@@ -2,7 +2,11 @@

 set -e

-# Regenerate initramfs when we're `installed`
-DPKG_MAINTSCRIPT_PACKAGE='' dracut-update-initramfs -u
+if [ -f /boot/dracut.img-`uname -r` ]; then
+    # Regenerate initramfs when we're `installed`
+    DPKG_MAINTSCRIPT_PACKAGE='' dracut-update-initramfs -t -u
+else
+    dracut-update-initramfs -c -k `uname -r`
+fi

 #DEBHELPER#


- Add xsltproc and docbook-xsl as dependencies to the source package,
since they are required for building the man files.

diff -urN dracut/debian/control dracut-007/debian/control
--- dracut/debian/control	2010-08-09 16:13:51.000000000 +0200
+++ dracut-007/debian/control	2010-10-21 19:50:22.123359964 +0200
@@ -2,7 +2,7 @@
 Section: utils
 Priority: optional
 Maintainer: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
-Build-Depends: debhelper (>= 5.0), cdbs
+Build-Depends: debhelper (>= 5.0), cdbs, xsltproc, docbook-xsl
 Standards-Version: 3.8.4
 Vcs-Browser: http://dracut.git.sourceforge.net/git/gitweb-index.cgi
 Vcs-Git: git://dracut.git.sourceforge.net/gitroot/dracut/dracut
@@ -11,7 +11,7 @@
 Architecture: all
 Recommends: cryptsetup, dmsetup, dmraid, lvm2, mdadm
 Suggests: dracut-network
-Depends: cpio, module-init-tools, udev, ${misc:Depends}
+Depends: cpio, module-init-tools, udev, bridge-utils, ${misc:Depends}
 Provides: linux-initramfs-tool
 Description: A new initramfs infrastructure
  Unlike existing initramfs's, this is an attempt at having as little as


- Create the man files when building the package. Make
dpkg-buildpackage execute make all, instead of just make.
The override_dh_auto_test line, prevents dpkg-buildpackage from
executing make test.

diff -urN dracut/debian/rules dracut-007/debian/rules
--- dracut/debian/rules	2010-08-09 16:13:51.000000000 +0200
+++ dracut-007/debian/rules	2010-10-21 02:49:45.714564995 +0200
@@ -1,3 +1,10 @@
 #!/usr/bin/make -f

-include /usr/share/cdbs/1/rules/debhelper.mk
+%:
+	dh $@
+
+override_dh_auto_build:
+	dh_auto_build -- all
+
+override_dh_auto_test:
+


- rpc.idmapd requires rpc_pipefs to be mounted. On Fedora when the
sunrpc module is loaded, modprobe mounts the rpc_pipefs, while this is
not the case on Debian/Ubuntu.

diff -urN dracut/modules.d/95nfs/nfsroot dracut-007/modules.d/95nfs/nfsroot
--- dracut/modules.d/95nfs/nfsroot	2010-08-09 16:13:51.000000000 +0200
+++ dracut-007/modules.d/95nfs/nfsroot	2010-10-21 22:21:12.682081301 +0200
@@ -88,6 +88,9 @@
 [ -x /sbin/rpcbind ] && [ -z "$(pidof rpcbind)" ] && rpcbind

 if [ "$nfs" = "nfs4" ]; then
+    [ ! -d /var/lib/nfs/rpc_pipefs/nfs ] && \
+        mount -t rpc_pipefs rpc_pipefs /var/lib/nfs/rpc_pipefs
+
     # Start rpc.statd as mount won't let us use locks on a NFSv4
     # filesystem without talking to it. NFSv4 does locks internally,
     # rpc.lockd isn't needed


> Personal comment on the debian/* stuff: It's horribly outdated. Due do
> workload and private reasons I haven't been able to work on them for months.
>
> As for these patches, they look sensible. But question: have you tried them
> on debian testing/unstable?

I have not tried them lately, just in Ubuntu 10.04 and Ubuntu 10.10.


Regards,

Jon Ander.
