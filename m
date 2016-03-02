From: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V2 dracut 0/2] Install kernel module for active watchdog
Date: Wed,  2 Mar 2016 17:36:27 +0530
Message-ID: <cover.1456919929.git.panand@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Changes since RFC:
 -- Added one more patch to take care that dracut does not add watchdog
hooks when systemd module is included. In that case systemd daemon will
manage watchdog for kicking.
 -- Removed --nowdt argument. User can use -o or --omit when wathdog module
is not needed. Thanks Harald for this suggestion.
 -- Now I also do not check for "hostonly" to add modules for active
watchdog. It seems reasonable to add kernel watchdog modules whenever,
dracut watchdog module has been added.

Pratyush Anand (2):
  watchdog: Do not add hooks if systemd module is included
  watchdog: install module for active watchdog

 modules.d/04watchdog/module-setup.sh | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

-- 
2.5.0
