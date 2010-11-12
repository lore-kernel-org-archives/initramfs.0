From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, master, updated. 325d4913601b67077f45c5826dfebd507ba9ed76
Date: Fri, 12 Nov 2010 13:28:13 +0000
Message-ID: <E1PGtfy-0004Im-Tw@sfp-scmshell-1.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  325d4913601b67077f45c5826dfebd507ba9ed76 (commit)
      from  91f4d45f93f067ac3de3d38c62bed84e5075932d (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit 325d4913601b67077f45c5826dfebd507ba9ed76
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Fri Nov 12 14:27:36 2010 +0100

    dracut.spec: remove uswsusp and added busybox module

diff --git a/dracut.spec b/dracut.spec
index 4313238..6a9a462 100644
--- a/dracut.spec
+++ b/dracut.spec
@@ -221,6 +221,7 @@ rm -rf $RPM_BUILD_ROOT
 %{_mandir}/man5/dracut.conf.5*
 %{_datadir}/dracut/modules.d/00bootchart
 %{_datadir}/dracut/modules.d/00dash
+%{_datadir}/dracut/modules.d/05busybox
 %{_datadir}/dracut/modules.d/10i18n
 %{_datadir}/dracut/modules.d/10rpmversion
 %{_datadir}/dracut/modules.d/50plymouth
@@ -243,7 +244,6 @@ rm -rf $RPM_BUILD_ROOT
 %{_datadir}/dracut/modules.d/95zfcp
 %{_datadir}/dracut/modules.d/95terminfo
 %{_datadir}/dracut/modules.d/95udev-rules
-%{_datadir}/dracut/modules.d/95uswsusp
 %{_datadir}/dracut/modules.d/96insmodpost
 %{_datadir}/dracut/modules.d/98selinux
 %{_datadir}/dracut/modules.d/98syslog
-----------------------------------------------------------------------

Summary of changes:
 dracut.spec |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


-- 
dracut - Initramfs generator using udev
