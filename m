From: Dave Reisner <d@falconindy.com>
Subject: Re: [systemd-devel] [PATCH-v3 1/2] systemd: mount the securityfs
 filesystem at early stage
Date: Tue, 13 Mar 2012 13:39:11 -0400
Message-ID: <20120313173911.GY838@rampage>
References: <1331655340-11595-1-git-send-email-roberto.sassu@polito.it>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1331655340-11595-1-git-send-email-roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Cc: systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ima-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mzerqung-uLTowLwuiw4b1SvskN2V4Q@public.gmane.org, zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org

On Tue, Mar 13, 2012 at 05:15:35PM +0100, Roberto Sassu wrote:
> The mount of the securityfs filesystem is now performed in the main systemd
> executable as it is used by IMA to provide the interface for loading custom
> policies. The unit file 'units/sys-kernel-security.mount' has been removed
> because it is not longer necessary.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
> Acked-by: Gianluca Ramunno <ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
> ---
>  Makefile.am                     |    3 ---
>  src/mount-setup.c               |    6 ++++--
>  units/sys-kernel-security.mount |   17 -----------------
>  3 files changed, 4 insertions(+), 22 deletions(-)
>  delete mode 100644 units/sys-kernel-security.mount
> 
> diff --git a/Makefile.am b/Makefile.am
> index d2bd340..c0fcd70 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -291,7 +291,6 @@ dist_systemunit_DATA = \
>  	units/dev-mqueue.mount \
>  	units/sys-kernel-config.mount \
>  	units/sys-kernel-debug.mount \
> -	units/sys-kernel-security.mount \
>  	units/sys-fs-fuse-connections.mount \
>  	units/var-run.mount \
>  	units/media.mount \
> @@ -2342,7 +2341,6 @@ systemd-install-data-hook:
>  			dev-mqueue.mount \
>  			sys-kernel-config.mount \
>  			sys-kernel-debug.mount \
> -			sys-kernel-security.mount \
>  			sys-fs-fuse-connections.mount \
>  			systemd-modules-load.service \
>  			systemd-tmpfiles-setup.service \
> @@ -2352,7 +2350,6 @@ systemd-install-data-hook:
>  		$(LN_S) ../dev-mqueue.mount dev-mqueue.mount && \
>  		$(LN_S) ../sys-kernel-config.mount sys-kernel-config.mount && \
>  		$(LN_S) ../sys-kernel-debug.mount sys-kernel-debug.mount && \
> -		$(LN_S) ../sys-kernel-security.mount sys-kernel-security.mount && \
>  		$(LN_S) ../sys-fs-fuse-connections.mount sys-fs-fuse-connections.mount && \
>  		$(LN_S) ../systemd-modules-load.service systemd-modules-load.service && \
>  		$(LN_S) ../systemd-tmpfiles-setup.service systemd-tmpfiles-setup.service && \
> diff --git a/src/mount-setup.c b/src/mount-setup.c
> index 7c14ea8..75d5cae 100644
> --- a/src/mount-setup.c
> +++ b/src/mount-setup.c
> @@ -51,13 +51,15 @@ typedef struct MountPoint {
>  } MountPoint;
>  
>  /* The first three entries we might need before SELinux is up. The
> - * other ones we can delay until SELinux is loaded. */
> -#define N_EARLY_MOUNT 3
> + * fourth (securityfs) is needed by IMA to load a custom policy. The
> + * other ones we can delay until SELinux and IMA are loaded. */
> +#define N_EARLY_MOUNT 4
>  
>  static const MountPoint mount_table[] = {
>          { "proc",     "/proc",                  "proc",     NULL,                MS_NOSUID|MS_NOEXEC|MS_NODEV, true },
>          { "sysfs",    "/sys",                   "sysfs",    NULL,                MS_NOSUID|MS_NOEXEC|MS_NODEV, true },
>          { "devtmpfs", "/dev",                   "devtmpfs", "mode=755",          MS_NOSUID,                    true },
> +        { "securityfs", "/sys/kernel/security", "securityfs", NULL,              MS_NOSUID|MS_NOEXEC|MS_NODEV, true },

Failure to mount securtiyfs might be fatal for _your_ purposes, but I'd
wager that not only are some people not interested in this, but some
people (myself included) might not even have securityfs in their kernel.

dave

>          { "tmpfs",    "/dev/shm",               "tmpfs",    "mode=1777",         MS_NOSUID|MS_NODEV,           true },
>          { "devpts",   "/dev/pts",               "devpts",   "mode=620,gid=" STRINGIFY(TTY_GID), MS_NOSUID|MS_NOEXEC, false },
>          { "tmpfs",    "/run",                   "tmpfs",    "mode=755",          MS_NOSUID|MS_NODEV, true },
> diff --git a/units/sys-kernel-security.mount b/units/sys-kernel-security.mount
> deleted file mode 100644
> index 80cd761..0000000
> --- a/units/sys-kernel-security.mount
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -#  This file is part of systemd.
> -#
> -#  systemd is free software; you can redistribute it and/or modify it
> -#  under the terms of the GNU General Public License as published by
> -#  the Free Software Foundation; either version 2 of the License, or
> -#  (at your option) any later version.
> -
> -[Unit]
> -Description=Security File System
> -DefaultDependencies=no
> -ConditionPathExists=/sys/kernel/security
> -Before=sysinit.target
> -
> -[Mount]
> -What=securityfs
> -Where=/sys/kernel/security
> -Type=securityfs
> -- 
> 1.7.7.6
> 



> _______________________________________________
> systemd-devel mailing list
> systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> http://lists.freedesktop.org/mailman/listinfo/systemd-devel
