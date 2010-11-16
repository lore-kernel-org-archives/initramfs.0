From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, master, updated. 7a8a33b6cdcb7ae614f9fab4816d9b86b30af445
Date: Tue, 16 Nov 2010 09:30:24 +0000
Message-ID: <E1PIHs7-0007Lx-Pa@sfp-scmshell-3.v30.ch3.sourceforge.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  7a8a33b6cdcb7ae614f9fab4816d9b86b30af445 (commit)
      from  325d4913601b67077f45c5826dfebd507ba9ed76 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit 7a8a33b6cdcb7ae614f9fab4816d9b86b30af445
Author: Amadeusz =C5=BBo=C5=82nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Date:   Mon Nov 15 17:34:36 2010 +0100

    dracut-lib.sh: splitsep fix

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-l=
ib.sh
index f0c030b..37659fe 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -183,10 +183,10 @@ splitsep() {
     local tmp
=20
     while [ -n "$str" -a -n "$*" ]; do
-        tmp=3D"${str%%:*}"
+        tmp=3D"${str%%$sep*}"
         eval "$1=3D${tmp}"
         str=3D"${str#$tmp}"
-        str=3D"${str#:}"
+        str=3D"${str#$sep}"
         shift
     done
=20
-----------------------------------------------------------------------

Summary of changes:
 modules.d/99base/dracut-lib.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


--=20
dracut - Initramfs generator using udev
