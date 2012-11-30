From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch 0/6 v2] network fixes for link waiting
Date: Fri, 30 Nov 2012 11:20:21 +0800
Message-ID: <20121130032021.140175185@redhat.com>
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

--
Thanks a lot
Dave
