From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: initramfs-tools stable release 0.93.3
Date: Wed, 10 Jun 2009 17:30:17 +0200
Message-ID: <20090610153017.GA19401@stro.at>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org

small random fixes all over the place, see belows shortlog or
git clone git://git.debian.org/kernel/initramfs-tools.git

or online repo:
http://git.debian.org/git/kernel/initramfs-tools.git

-- 
maks


Loic Minier (1):
      copy_exec: also avoid picking sse2, neon, and vfp hwcaps libs.

maximilian attems (11):
      cleanup LABEL handling code
      update-initramfs: Text exit code of command -v too.
      hook-functions: Add i915 module for kms.
      update-initramfs: Pass version to flash-kernel
      update-initramfs: Don't hardcode path for lilo or elilo.
      hook-functions: MODULES=dep error out if sysfs not mounted on /sys.
      debian/control: No longer mention EVMS in long description.
      hook-functions: MODULES=most fix old typo s/smc911x/smc91x/
      mkinitramfs: Invoke dpkg --print-architecture
      nuke useless old file
      release 0.93.3

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
