From: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [dracut GIT] branch, master, updated. 0afae1c7cea9487a2a043d9223ef38543f7c8bba
Date: Wed, 16 Mar 2011 20:27:29 GMT
Message-ID: <201103162027.p2GKRTit020722@hera.kernel.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  0afae1c7cea9487a2a043d9223ef38543f7c8bba (commit)
       via  e7b1b342bf36a9c4e5dbbce3a725085757c26173 (commit)
       via  f709fa439bf7e2cade1ce78a977637e6aa894d53 (commit)
      from  510ef3af84cf84c63872cf21630570e62b9dfae6 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit 0afae1c7cea9487a2a043d9223ef38543f7c8bba
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Mar 16 21:24:57 2011 +0100

    base/init: for udev > 166 we will create and use /dev/.run/udev/rules.d
    
    See:
    http://git.kernel.org/?p=linux/hotplug/udev.git;a=commitdiff;h=e68b4c2857942257268134cf7028b80f5a6a8103;hp=98ab6a377285d5943563cfa397e8b350e43878ec

diff --git a/modules.d/99base/init b/modules.d/99base/init
index a3ac005..4177187 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -114,7 +114,7 @@ mount -t tmpfs -o mode=0755,nodev,noexec,nosuid tmpfs /dev/.run >/dev/null 2>&1
 mkdir -m 0755 /dev/.run/initramfs
 
 UDEVVERSION=$(udevadm --version)
-if [ $UDEVVERSION -ge 999 ]; then
+if [ $UDEVVERSION -gt 166 ]; then
     # newer versions of udev use /dev/.run/udev/rules.d
     mkdir -m 0755 /dev/.run/udev /dev/.run/udev/rules.d  
     export UDEVRULESD=/dev/.run/udev/rules.d
commit e7b1b342bf36a9c4e5dbbce3a725085757c26173
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Mar 16 21:17:26 2011 +0100

    dracut: add "--check=crc32" to xz compression
    
    As mentioned in kernel/Documentation/xz.txt:
    
    ...
    Notes on compression options
    
      Since the XZ Embedded supports only streams with no integrity check
      or CRC32, make sure that you don't use some other integrity check
      type when encoding files that are supposed to be decoded by the
      kernel. With liblzma, you need to use either LZMA_CHECK_NONE or
      LZMA_CHECK_CRC32 when encoding. With the xz command line tool, use
      --check=none or --check=crc32.
    
      Using CRC32 is strongly recommended unless there is some other layer
      which will verify the integrity of the uncompressed data anyway.
    ...

diff --git a/dracut b/dracut
index 2ae7f8c..10e86d0 100755
--- a/dracut
+++ b/dracut
@@ -214,7 +214,7 @@ while (($# > 0)); do
         -i|--include)  push include_src "$2"; push include_target "$3"; shift 2;;
         --bzip2)       [[ $compress != cat ]] && compress="bzip2 -9";;
         --lzma)        [[ $compress != cat ]] && compress="lzma -9";;
-        --xz)          [[ $compress != cat ]] && compress="xz -9";;
+        --xz)          [[ $compress != cat ]] && compress="xz --check=crc32";;
         --no-compress) compress="cat";;
         --gzip)        if [[ $compress != cat ]]; then
             type pigz > /dev/null 2>&1 && compress="pigz -9" || \
commit f709fa439bf7e2cade1ce78a977637e6aa894d53
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Mar 16 13:56:20 2011 +0100

    Install dracut-logger and add it to the spec file

diff --git a/Makefile b/Makefile
index 811bb18..1733c23 100644
--- a/Makefile
+++ b/Makefile
@@ -49,6 +49,7 @@ endif
 	install -m 0644 dracut.conf $(DESTDIR)$(sysconfdir)/dracut.conf
 	mkdir -p $(DESTDIR)$(sysconfdir)/dracut.conf.d
 	install -m 0755 dracut-functions $(DESTDIR)$(pkglibdir)/dracut-functions
+	install -m 0755 dracut-logger $(DESTDIR)$(pkglibdir)/dracut-logger
 	cp -arx modules.d $(DESTDIR)$(pkglibdir)
 	install -m 0644 dracut.8 $(DESTDIR)$(mandir)/man8
 	install -m 0644 dracut-catimages.8 $(DESTDIR)$(mandir)/man8
diff --git a/dracut.spec b/dracut.spec
index f3e2061..9af4418 100644
--- a/dracut.spec
+++ b/dracut.spec
@@ -222,6 +222,7 @@ rm -rf $RPM_BUILD_ROOT
 %dir %{_datadir}/dracut
 %dir %{_datadir}/dracut/modules.d
 %{_datadir}/dracut/dracut-functions
+%{_datadir}/dracut/dracut-logger
 %config(noreplace) /etc/dracut.conf
 %if 0%{?fedora} || 0%{?suse_version}
 %config(noreplace) /etc/dracut.conf.d/01-dist.conf
-----------------------------------------------------------------------

Summary of changes:
 Makefile              |    1 +
 dracut                |    2 +-
 dracut.spec           |    1 +
 modules.d/99base/init |    2 +-
 4 files changed, 4 insertions(+), 2 deletions(-)


-- 
dracut - Initramfs generator using udev
