From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut:fstab-sys: Wait for devices specified using
 --mount option
Date: Tue, 15 May 2012 13:36:11 -0400
Message-ID: <20120515173611.GC24585@redhat.com>
References: <20120515172301.GB24585@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120515172301.GB24585-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, May 15, 2012 at 01:23:01PM -0400, Vivek Goyal wrote:
> dracut allows passing --mount option which mounts the specified devices.
> But it does not wait for these devices to show up and mounting will fail
> if devices do not show up by the time "mount" was called.
> 
> I am writing some patches to support kdump on iscsi target and I noticed
> that one of the initqueue script was not called as we found the root
> device and broke out of main loop.
> 
> There are two possible enancements to this patch.
> 
> - Introduce a time limited wait (rd.timeout something along the lines of
>   rd.retry). That will allow kdump to try to dump to a backup target if
>   primary targets fails to come up.
> 
> - Wait for UUID= and LABEL= to show up too. Right now kdump converts
>   UUID= and LABEL= to respective devices and passes /dev/* to dracut
>   --mount option. So I am not introducing the wait for UUID= or LABEL=
>  in this patch.
>

[Regenerated the patch on top of git repo. Should be easier to apply now]

dracut allows passing --mount option which mounts the specified devices.
But it does not wait for these devices to show up and mounting will fail
if devices do not show up by the time "mount" was called.

I am writing some patches to support kdump on iscsi target and I noticed
that one of the initqueue script was not called as we found the root
device and broke out of main loop.

There are two possible enancements to this patch.

- Introduce a time limited wait (rd.timeout something along the lines of
  rd.retry). That will allow kdump to try to dump to a backup target if
  primary targets fails to come up.

- Wait for UUID= and LABEL= to show up too. Right now kdump converts
  UUID= and LABEL= to respective devices and passes /dev/* to dracut
  --mount option. So I am not introducing the wait for UUID= or LABEL=
 in this patch.

Signed-off-by: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/95fstab-sys/module-setup.sh   |    1 +
 modules.d/95fstab-sys/wait-mount-dev.sh |   22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100644 modules.d/95fstab-sys/wait-mount-dev.sh

diff --git a/modules.d/95fstab-sys/module-setup.sh b/modules.d/95fstab-sys/module-setup.sh
index 7589d74..56dd8fc 100755
--- a/modules.d/95fstab-sys/module-setup.sh
+++ b/modules.d/95fstab-sys/module-setup.sh
@@ -13,4 +13,5 @@ depends() {
 install() {
     [ -f /etc/fstab.sys ] && inst /etc/fstab.sys
     inst_hook pre-pivot 00 "$moddir/mount-sys.sh"
+    inst_hook cmdline 00 "$moddir/wait-mount-dev.sh"
 }
diff --git a/modules.d/95fstab-sys/wait-mount-dev.sh b/modules.d/95fstab-sys/wait-mount-dev.sh
new file mode 100644
index 0000000..99fc16c
--- /dev/null
+++ b/modules.d/95fstab-sys/wait-mount-dev.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
+type det_fs >/dev/null 2>&1 || . /lib/fs-lib.sh
+
+fstab_wait_dev() {
+    local _dev _mp _fs _opts _dump _pass _rest
+    test -e "$1" || return 1
+    while read _dev _mp _fs _opts _dump _pass _rest; do
+        [ -z "${_dev%%#*}" ] && continue # Skip comment lines
+        case "$_dev" in
+        /dev/?*)
+            wait_for_dev $_dev;;
+        *) ;;
+        esac
+    done < $1
+    return 0
+}
+
+[ -f /etc/fstab ] && fstab_wait_dev /etc/fstab
-- 
1.7.7.6
