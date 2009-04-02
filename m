From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: initramfs-tools stable release 0.93.2
Date: Thu, 2 Apr 2009 13:18:17 +0200
Message-ID: <20090402111817.GA4903@stro.at>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org

initramfs-tools is a generic initramfs generation tool.

latest stable adds fb fixes and a behaviour change for
update-initramfs -u to work against newest initramfs
instead of following maybe outdated /initrd.img symlink.

git clone git://git.debian.org/kernel/initramfs-tools.git              =
        =20
                                                                       =
        =20
online repo:                                                           =
        =20
http://git.debian.org/git/kernel/initramfs-tools.git                   =
        =20



complete shortlog, aka git shortlog 0.93.1..

=46ran=E7ois Delawarde (1):
      hook-functions: MODULES=3Ddep fix for luks over cciss devices

Maik Zumstrull (1):
      init-top/framebuffer: Load intel-agp for intelfb

maximilian attems (12):
      hook-functions: stricter match on loaded module for firmware warn=
ing.
      hook-functions: Add firmware from versioned directories too.
      hook-functions: MODULES=3Dmost add all fb modules per default
      update-initramfs: Cleanup run_bootloader()
      update-initramfs: mbr_check() use /boot/grub/grub.cfg for grub2 s=
earch.
      update-initramfs: Run update on highest version instead of /initr=
d.img link
      hook-functions: MODULES=3Dmost fb add all available agp modules
      update-initramfs: Fix error message on wrong -k version argument
      hooks/thermal: Prevent inclusion of windfarm modules on PS3.
      init-top/framebuffer: syntax fix.
      mkinitramfs: Allow dots in boot and script filenames.
      release 0.93.2


diffstat

 debian/changelog             |   28 ++++++++++++++++++++++++
 hook-functions               |   27 +++++++++++++++++++----
 hooks/thermal                |    3 ++
 mkinitramfs                  |    4 +-
 scripts/functions            |    4 +-
 scripts/init-top/framebuffer |    7 +++++-
 update-initramfs             |   48 ++++++++++++++++++++++++----------=
-------
 7 files changed, 91 insertions(+), 30 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
