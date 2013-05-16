From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [PATCH] dracut systemd cmdline service fix
Date: Thu, 16 May 2013 13:15:17 +0800
Message-ID: <51946b65.1SfwJA0QAkY6Gb83%dyoung@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, -c@redhat.com, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


Kdump test failed since below commits 
dbfaae0e34507d2d1f3c186ffe26af3e8028b9f8

Fedora bug is here:
https://bugzilla.redhat.com/show_bug.cgi?id=963159

The reason is the hooks afterwards need NEWROOT env which
is set in dracut-cmdline.sh.

In this case there's no files under /etc/cmdline.d/ and
/lib/dracut/hooks/cmdline/. Conditions checking failed, so
the cmdline service failed to startup.

Fix this issue by remove the Conditions thus cmdline service
always run if /etc/initrd-release exists.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/98systemd/dracut-cmdline.service |    5 -----
 1 file changed, 5 deletions(-)

--- dracut.orig/modules.d/98systemd/dracut-cmdline.service
+++ dracut/modules.d/98systemd/dracut-cmdline.service
@@ -16,11 +16,6 @@ Before=systemd-vconsole-setup.service
 After=systemd-journald.socket
 Wants=systemd-journald.socket
 ConditionPathExists=/etc/initrd-release
-ConditionPathExistsGlob=|/etc/cmdline.d/*.conf
-ConditionDirectoryNotEmpty=|/lib/dracut/hooks/cmdline
-ConditionKernelCommandLine=|rd.break=cmdline
-ConditionKernelCommandLine=|resume
-ConditionKernelCommandLine=|noresume
 
 [Service]
 Type=oneshot
