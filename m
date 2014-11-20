From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 02/33] Update dracut manpage for GRUB Legacy and GRUB2
Date: Thu, 20 Nov 2014 15:56:37 +0100
Message-ID: <1416495428-36978-3-git-send-email-trenn@suse.de>
References: <1416495428-36978-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416495428-36978-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: hare-l3A5Bk7waGM@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Dunn <sfalken-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>

From: Shawn Dunn <sfalken-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 dracut.usage.asc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/dracut.usage.asc b/dracut.usage.asc
index 9e788c1..1a79638 100644
--- a/dracut.usage.asc
+++ b/dracut.usage.asc
@@ -99,9 +99,9 @@ raid with encryption and LVM on top), as long as you specify the correct
 filesystem LABEL or UUID on the kernel command line for your root device, dracut
 will find it and boot from it.
 
-The kernel command line usually can be configured in _/boot/grub/grub.conf_ or
-_/boot/grub2/grub.cfg_, if grub is your bootloader and it also can be edited in
-the real boot process in the grub menu.
+The kernel command line usually can be configured in _/boot/grub/grub.conf_,
+for GRUB legacy, or _/boot/grub2/grub.cfg_, for GRUB2 if grub is your
+bootloader and it also can be edited in the real boot process in the grub menu.
 
 The kernel command line can also be provided by the dhcp server with the
 root-path option. See <<NetworkBoot>>.
-- 
1.8.5.2
