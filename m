From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: initramfs-tools stable release 0.93.4
Date: Wed, 29 Jul 2009 15:54:46 +0200
Message-ID: <20090729135445.GA16345@stro.at>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org

the last 0.93 as the next version will focus on faster boot
and thus smaller initramfs out of the box. first commits
in this direction are already in latest git:
git clone git://git.debian.org/kernel/initramfs-tools.git
 http://git.debian.org/git/kernel/initramfs-tools.git
 
for the small fixes belows shortlog

Aaron M. Ucko (1):
      scripts/init-top/framebuffer: i915 needs intel-agp too

maximilian attems (7):
      preinst: Don't hardcode vol_id cmd
      initramfs-tools.8: Convert hyphen to minus sign
      control: bump versioned dep on debhelper
      control: bump standards version without changes.
      hook-functions: Fix loading of entries without newline in
      /etc/initramfs-tools/modules
      MODULES=most: Add virtio_net to initramfs.
      release 0.93.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
