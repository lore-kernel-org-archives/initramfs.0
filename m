From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: initramfs-tools stable release 0.93.1
Date: Mon, 23 Mar 2009 08:21:25 +0100
Message-ID: <20090323072125.GK7954@stro.at>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org

random pile of fixes combined with some Ubuntu syncs.
no new features.

The naming of the initramfs-tools stable releases changed
from adding a letter to the more accepted and widely used
addition of a maintenance number.


Ben Collins (1):
      init-top/framebuffer: ignore blacklist for forced vga= usage.

Matt Kraai (1):
      mkinitramfs-kpkg misspells "deprecation" as "depreciation"

Michael Vogt (1):
      update-initramfs: set_linked_version() check if the links point to an existing initrd.img

Scott James Remnant (1):
      mkinitramfs: include the modules.order file.

maximilian attems (10):
      init: export ip root param for configure_networking()
      initramfs-tools.8: Document exported IP kernel parameter.
      initramfs-tools.preinst: Nuke initrd-tools related migration path.
      MODULES=dep: ide-disk got renamed to ide-gd_mod since 2.6.28.
      mkinitramfs: usage() fix conffile name.
      update copyright year of my contributions
      control: conform to latest policy without changes
      hook-functions: reword MODULES=dep error message
      hook-functions: MODULES=dep fix for mmc root
      debian/compat: Set debhelper compatibility version 5

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
