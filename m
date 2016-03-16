From: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V5 dracut 0/3] Install kernel module for active watchdog
Date: Wed, 16 Mar 2016 09:09:08 +0530
Message-ID: <cover.1458099200.git.panand@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Changes since V4:
-- Renamed 04watchdog.conf to 00watchdog.conf
Changes since V3:
-- Incorporated changes suggested by Harald for V2 patches

Changes since V2:
-- Added one more patch to update rd.driver.pre with watchdog module name,
so that they are loaded into kernel as early as possible.
-- Removed creation of tmp/active-watchdogs. modinfo will be helpful for
kexec-tools.
-- Now we add modules for active watchdog in hostonly mode and modules for
all watchdog in no-hostonly mode.

Changes since RFC:
-- Added one more patch to take care that dracut does not add watchdog
hooks when systemd module is included. In that case systemd daemon will
manage watchdog for kicking.
-- Removed --nowdt argument. User can use -o or --omit when wathdog module
is not needed. Thanks Harald for this suggestion.
-- Now I also do not check for "hostonly" to add modules for active
watchdog. It seems reasonable to add kernel watchdog modules whenever,
dracut watchdog module has been added.



Pratyush Anand (3):
  watchdog: Do not add hooks if systemd module is included
  watchdog: install module for active watchdog
  watchdog: ensure that module is loaded as early as possible

Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

 modules.d/04watchdog/module-setup.sh | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

-- 
2.5.0
