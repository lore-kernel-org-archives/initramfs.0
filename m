From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch 0/6 v3] network fixes for link waiting
Date: Wed, 12 Dec 2012 12:23:20 +0800
Message-ID: <20121212042320.618863612@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

This is the v2 patch set for some network cleanup and fixes:
01-network-move-wait-for-if-function-to-net-lib.patch
02-network-add-function-linkup.patch
03-network-use-linkup-function.patch
04-network-wait-for-link-ready-before-use.patch
05-network-get-ifaces-for-udev-rule-use.patch
06-network-wait-interface-up-at-early-stage.patch

Tested kdump with a nic which delay abouth 60s while initializing.
V2 patch updated 05 and 06 to fix some issues with bonding device.

v2->v3:
refresh based on latest mater branch
patch 3/6: fix merge conflict
patch 5/6: fix a typo:  s/-n/-z

--
Thanks
Dave
