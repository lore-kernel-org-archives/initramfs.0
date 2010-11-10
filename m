From: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Debian/Ubuntu patches
Date: Wed, 10 Nov 2010 17:21:41 +0100
Message-ID: <AANLkTi=Mc4qBA7yhExb2VCCGyMNCXq+k9BZ=JhZpN4GE@mail.gmail.com>
References: <AANLkTikEPsCQzMSJbhwuO95Br+7aYJPw9zbVRd4Y8vOC@mail.gmail.com>
	<4CD9102B.7030702@bfh.ch>
	<AANLkTi=EkL7ivKKj6ck3w6RuOOq++cGwtP_pX0HHhVWu@mail.gmail.com>
	<20101109125820.GO19612@vostochny.stro.at>
	<AANLkTinfZNiQ14XD3OAC8WasnGXi6bcD9WJipvKS0f1S@mail.gmail.com>
	<20101109140028.GP19612@vostochny.stro.at>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=qWspGWlTHV4IBCpC9QYVb4gaS5/YLPwb8wVrFSjFccg=;
        b=rd0s6XfO//Qtl95UQASKcH4X3ZWFPoKjlv0Tt1FbvL43ie7TRPiPR4rNgoL97KOeyY
         7O0hNwYWuhJr3x4oYGvkOq9OSVKKJemmkrxnlXWnr/URy55+KvPqyjWQOa7LUQTmNqMX
         VdtD7AmpVnKJ0EROhC3Dn+4as3AP/1Nm7JTd4=
In-Reply-To: <20101109140028.GP19612-VJknIhvjf2Ov8OlOgJ4AIV6hYfS7NtTn@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

By now an upgraded version of the patches as a single patch :

diff -urN dracut-007//debian/compat dracut/debian/compat
--- dracut-007//debian/compat	2010-08-09 16:13:51.000000000 +0200
+++ dracut/debian/compat	2010-11-09 20:49:29.324392489 +0100
@@ -1 +1 @@
-5
+7
diff -urN dracut-007//debian/control dracut/debian/control
--- dracut-007//debian/control	2010-08-09 16:13:51.000000000 +0200
+++ dracut/debian/control	2010-11-09 20:50:15.364391392 +0100
@@ -2,7 +2,7 @@
 Section: utils
 Priority: optional
 Maintainer: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
-Build-Depends: debhelper (>= 5.0), cdbs
+Build-Depends: debhelper (>= 7.0), xsltproc, docbook-xsl
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
diff -urN dracut-007//debian/dracut.install dracut/debian/dracut.install
--- dracut-007//debian/dracut.install	2010-08-09 16:13:51.000000000 +0200
+++ dracut/debian/dracut.install	2010-11-09 22:39:59.894391387 +0100
@@ -4,6 +4,8 @@
 dracut-gencmdline	usr/sbin
 dracut-functions	usr/share/dracut
 dracut.conf		etc
+debian/dracut-kernel-postinst	etc/kernel/postinst.d
+debian/dracut-kernel-postrm	etc/kernel/postrm.d
 modules.d/00dash		usr/share/dracut/modules.d
 modules.d/01fips		usr/share/dracut/modules.d
 modules.d/60xen			usr/share/dracut/modules.d
diff -urN dracut-007//debian/dracut-kernel-postinst
dracut/debian/dracut-kernel-postinst
--- dracut-007//debian/dracut-kernel-postinst	1970-01-01
01:00:00.000000000 +0100
+++ dracut/debian/dracut-kernel-postinst	2010-11-09 22:25:44.294391387 +0100
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+version="$1"
+bootopt=""
+
+# passing the kernel version is required
+[ -z "${version}" ] && exit 0
+
+# kernel-package passes an extra arg
+if [ -n "$2" ]; then
+	if [ -n "${KERNEL_PACKAGE_VERSION}" ]; then
+		# exit if custom kernel does not need an initramfs
+		[ "$INITRD" = 'No' ] && exit 0
+		bootdir=$(dirname "$2")
+		bootopt="-b ${bootdir}"
+	fi
+fi
+
+# avoid running multiple times
+if [ -n "$DEB_MAINT_PARAMS" ]; then
+	eval set -- "$DEB_MAINT_PARAMS"
+	if [ -z "$1" ] || [ "$1" != "configure" ]; then
+		exit 0
+	fi
+fi
+
+# we're good - create initramfs.  update runs do_bootloader
+dracut-update-initramfs -c -t -k "${version}" ${bootopt} >&2
diff -urN dracut-007//debian/dracut-kernel-postrm
dracut/debian/dracut-kernel-postrm
--- dracut-007//debian/dracut-kernel-postrm	1970-01-01 01:00:00.000000000 +0100
+++ dracut/debian/dracut-kernel-postrm	2010-11-09 22:25:57.804391387 +0100
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+version="$1"
+bootopt=""
+
+# passing the kernel version is required
+[ -z "${version}" ] && exit 0
+
+# kernel-package passes an extra arg
+if [ -n "$2" ]; then
+	if [ -n "${KERNEL_PACKAGE_VERSION}" ]; then
+		bootdir=$(dirname "$2")
+		bootopt="-b ${bootdir}"
+	fi
+fi
+
+# avoid running multiple times
+if [ -n "$DEB_MAINT_PARAMS" ]; then
+	eval set -- "$DEB_MAINT_PARAMS"
+	if [ -z "$1" ] || [ "$1" != "remove" ]; then
+		exit 0
+	fi
+fi
+
+# delete initramfs
+dracut-update-initramfs -d -t -k "${version}" ${bootopt} >&2
diff -urN dracut-007//debian/rules dracut/debian/rules
--- dracut-007//debian/rules	2010-08-09 16:13:51.000000000 +0200
+++ dracut/debian/rules	2010-11-09 20:49:13.044391518 +0100
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
