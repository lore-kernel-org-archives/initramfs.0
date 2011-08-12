From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] 99fs-lib module for common fsck needs
Date: Fri, 12 Aug 2011 08:22:27 +0200
Message-ID: <4E44C6A3.2050403@redhat.com>
References: <1307049735-2345-1-git-send-email-soltys@ziu.info>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1307049735-2345-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 02.06.2011 23:22, Michal Soltys wrote:
> This introduces separate 99fs-lib module, covering all functions responsible
> for filesystem checking. Both single-fs and multi-fs checking is available.
> single-fs checkers call small "drivers" handling specific filesystems (or
> falling back to the default one).
> 
> Code is pretty well tested, so there should be no surprises.
> 
> See 1st commit message for more details, as well as comments in fs-lib.sh
> 
> Next on roster is updated fstab-sys module.
> 
> Michal Soltys (4):
>   implement fs-lib, squash a few bugs that were part of det_fs/wrap_fsck
>   95rootfs-block/mount-root.sh: '-a' for ext? is handled in fs-lib now
>   95rootfs-block/mount-root.sh: squash rootopts into rflags
>   95rootfs-block/mount-root.sh: comment out fstab generation
> 
>  modules.d/95fstab-sys/module-setup.sh    |    4 +-
>  modules.d/95fstab-sys/mount-sys.sh       |    5 +-
>  modules.d/95rootfs-block/module-setup.sh |    6 +-
>  modules.d/95rootfs-block/mount-root.sh   |   37 +++---
>  modules.d/99base/dracut-lib.sh           |   47 -------
>  modules.d/99fs-lib/fs-lib.sh             |  207 ++++++++++++++++++++++++++++++
>  modules.d/99fs-lib/module-setup.sh       |   22 +++
>  7 files changed, 258 insertions(+), 70 deletions(-)
>  create mode 100755 modules.d/99fs-lib/fs-lib.sh
>  create mode 100755 modules.d/99fs-lib/module-setup.sh
> 

pushed
