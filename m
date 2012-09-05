From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] dracut: Override rd.md settings if rd.md.uuid is provided
Date: Wed, 5 Sep 2012 17:20:48 -0400
Message-ID: <20120905212047.GE19749@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>


Currently anaconda provides rd.md=0 on kernel's command line as a boot
time optimization if root is not on md device. But this leads to kdump
failure. We copy the command line from first kernel and if dump target
is on md device, it fails as we never try to assemble md devices as
rd.md=0.

We have already set rd.md.uuid though in /etc/cmdlind.d/ dir providing
dracut the info about what md devices to assemble. So this patch overrides
rd.md settings if rd.md.uuid is provided.

This is a stop gap measure to get kdump working on software raid
devices. Harald seems to have bigger cleanup plans for rd.md. Once
that happens, this patch will not be needed and things should
automatically be fixed.

Signed-off-by: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 lib/dracut/modules.d/90mdraid/parse-md.sh |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: /lib/dracut/modules.d/90mdraid/parse-md.sh
===================================================================
--- .orig/lib/dracut/modules.d/90mdraid/parse-md.sh	2012-04-05 07:54:38.000000000 -0400
+++ /lib/dracut/modules.d/90mdraid/parse-md.sh	2012-09-05 11:02:49.493000153 -0400
@@ -1,7 +1,12 @@
 #!/bin/sh
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
 # ex: ts=8 sw=4 sts=4 et filetype=sh
-if ! getargbool 1 rd.md -n rd_NO_MD; then
+MD_UUID=$(getargs rd.md.uuid rd_MD_UUID=)
+
+# If rd.md.uuid or rd_MD_UUID is specified, override rd.md settings.
+[ -n "$MD_UUID" ] && override_rd_md=1
+
+if [ ! $(getargbool 1 rd.md -n rd_NO_MD) ] && [ -z "$overide_rd_md" ]; then
     info "rd.md=0: removing MD RAID activation"
     udevproperty rd_NO_MD=1
 else
