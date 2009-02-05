From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH 0/3] mdraid rootfs support
Date: Thu, 05 Feb 2009 15:49:10 -0700
Message-ID: <20090205224808.18610.14957.stgit@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: neilb-l3A5Bk7waGM@public.gmane.org, jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org

This series is a first take at dracut support for an mdraid rootfs.  It
includes considerations for the new external metadata formats supported in the
latest development branch of mdadm:

	git://neil.brown.name/mdadm devel-3.0

This is an RFC because it is not clear to me that a single call to "udevadm
settle" is enough to guarantee discovery of all storage devices ahead of raid
assembly.  A cursory test with (4) ahci attached drives was successful.

Regards,
Dan

---

Dan Williams (3):
      add more disk id helpers to udevexe
      raid: external and internal metadata support
      gen-mod-lists: create lists of modules that may talk to a root device


 dracut        |   13 ++++++++++---
 gen-mod-lists |   34 ++++++++++++++++++++++++++++++++++
 init          |   10 ++++++++++
 3 files changed, 54 insertions(+), 3 deletions(-)
 create mode 100755 gen-mod-lists
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
