From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 26/42] dracut.usage.asc: Remove distro specific help from manpage
Date: Thu, 11 Dec 2014 15:46:17 +0100
Message-ID: <1418309193-11208-27-git-send-email-trenn@suse.de>
References: <1418309193-11208-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418309193-11208-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 dracut.usage.asc | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/dracut.usage.asc b/dracut.usage.asc
index 9e788c1..b4a8663 100644
--- a/dracut.usage.asc
+++ b/dracut.usage.asc
@@ -246,23 +246,6 @@ specified multiple times.
 If your root partition is on a network drive, you have to have the network
 dracut modules installed to create a network aware initramfs image.
 
-On a Red Hat Enterprise Linux or Fedora system, this means, you have to install
-the _dracut-network_ rpm package:
-
-
-----
-# yum install dracut-network
-----
-
-The resulting initramfs image can be served by a boot manager residing on your
-local hard drive or it can be served by a PXE/TFTP server.
-
-How to setup your PXE/TFTP server can be found in the
-http://docs.redhat.com/docs/en-US/Red_Hat_Enterprise_Linux/6/html/Storage_Administration_Guide/[Red
-Hat Enterprise Linux 6 Storage Administration Guide]
-or http://docs.redhat.com/docs/en-US/Red_Hat_Enterprise_Linux/6/html/Storage_Administration_Guide/[Red
-Hat Enterprise Linux 7 Storage Administration Guide].
-
 If you specify ip=dhcp on the kernel command line, then dracut asks a dhcp
 server about the ip adress for the machine. The dhcp server can also serve an
 additional root-path, which will set the root device for dracut. With this
@@ -302,7 +285,7 @@ This will reduce the size of the initramfs image significantly.
 If the boot process does not succeed, you have several options to debug the
 situation. Some of the basic operations are covered here. For more information
 you should also visit:
-http://fedoraproject.org/wiki/How_to_debug_Dracut_problems
+https://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html
 
 
 [[identifying-your-problem-area]]
-- 
1.8.5.2
