From: Thomas Backlund <tmb-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] 90kernel-modules: update for xhci module split in kernel
 3.18
Date: Sun, 21 Dec 2014 12:44:30 +0159
Message-ID: <5496A4A7.6040609@mageia.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020004010105010909060900"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a multi-part message in MIME format.
--------------020004010105010909060900
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit


--------------020004010105010909060900
Content-Type: text/x-diff;
 name="dracut-xhci-modules-kernel-3.18.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dracut-xhci-modules-kernel-3.18.patch"


As reported in https://bugs.mageia.org/show_bug.cgi?id=14799

the xhci module got splitted up in upstream linux merged during
3.18 release cycle:

From 29e409f0f7613f9fd2235e41f0fa33e48e94544e Mon Sep 17 00:00:00 2001
From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Date: Fri, 3 Oct 2014 11:35:29 +0300
Subject: xhci: Allow xHCI drivers to be built as separate modules

so we need to adjust 90kernel-modules accordingly.

Signed-off-by: Thomas Backlund <tmb-odJJhXpcy38dnm+yROfE0A@public.gmane.org>

--- dracut/modules.d/90kernel-modules/module-setup.sh.orig
+++ dracut/modules.d/90kernel-modules/module-setup.sh
@@ -41,7 +41,7 @@ installkernel() {
             ehci-hcd ehci-pci ehci-platform \
             ohci-hcd ohci-pci \
             uhci-hcd \
-            xhci-hcd
+            xhci-hcd xhci-pci xhci-plat-hcd
 
         instmods yenta_socket scsi_dh_rdac scsi_dh_emc \
             atkbd i8042 usbhid hid-apple hid-sunplus hid-cherry hid-logitech \

--------------020004010105010909060900--
