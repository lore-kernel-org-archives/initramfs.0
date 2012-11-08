From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch RFC 0/6] network fixes for link waiting
Date: Thu, 08 Nov 2012 11:40:18 +0800
Message-ID: <20121108034018.789330224@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Here is a patch set for some network cleanup and fixes:
01-network-move-wait-for-if-function-to-net-lib.patch
02-network-add-function-linkup.patch
03-network-use-linkup-function.patch
04-network-wait-for-link-ready-before-use.patch
05-network-get-ifaces-for-udev-rule-use.patch
06-network-wait-interface-up-at-early-stage.patch

Tested kdump with a nic which delay abouth 60s while initializing.

Please help to review especially for the patch 3/6 which replace some ip link
up with a function linkup.

--
Thanks a lot
Dave
