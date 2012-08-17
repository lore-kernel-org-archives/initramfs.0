From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch 0/3] add --device option
Date: Fri, 17 Aug 2012 20:35:19 +0800
Message-ID: <20120817123519.082687047@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is the update patch series for --device option.
1/3: wait host devs in base module
2/3: Add for_each_host_dev for device only checking
3/3: Add a dracut option --device to bring up a device in initramfs
---
 dracut-functions.sh                     |   15 +++++++++++++++
 dracut.8.asc                            |    3 +++
 dracut.sh                               |   22 ++++++++++++++++++++++
 modules.d/90lvm/module-setup.sh         |    2 +-
 modules.d/90multipath/module-setup.sh   |    2 +-
 modules.d/95fstab-sys/module-setup.sh   |    1 -
 modules.d/95fstab-sys/wait-mount-dev.sh |   22 ----------------------
 modules.d/95iscsi/module-setup.sh       |    2 +-
 modules.d/99base/module-setup.sh        |    1 +
 modules.d/99base/wait-host-devs.sh      |   20 ++++++++++++++++++++
 10 files changed, 64 insertions(+), 26 deletions(-)
