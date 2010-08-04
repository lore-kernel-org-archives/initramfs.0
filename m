From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] add option --ignore-kernel-modules
Date: Wed, 04 Aug 2010 18:32:09 +0200
Message-ID: <4C599609.6060107@redhat.com>
References: <20100804181519.5eaf9f1c@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100804181519.5eaf9f1c-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

pushed

On 08/04/2010 06:15 PM, Amadeusz =C5=BBo=C5=82nowski wrote:
> Instead of adding modprobe and rmmod, create symlinks to /bin/true to
> don't produce unnecessary errors.  Anyway it's a workaround for
> following desired behaviour: modprobe tries to insert module only if
> it's not built into kernel
> ---
>   dracut                   |   10 +++++++++-
>   dracut.8                 |    4 ++++
>   modules.d/99base/install |   13 ++++++++++---
>   3 files changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/dracut b/dracut
> index c22051c..e0c2186 100755
> --- a/dracut
> +++ b/dracut
> @@ -46,6 +46,10 @@ Creates initial ramdisk images for preloading modu=
les
>                           firmwares, separated by :
>     --kernel-only         Only install kernel drivers and firmware fi=
les
>     --no-kernel           Do not install kernel drivers and firmware =
files
> +  --ignore-kernel-modules
> +                        Don't try to load modules. It automatically =
implies
> +                        '--no-kernel'. It's assumed that everything =
needed
> +                        is built into kernel.
>     --strip               Strip binaries in the initramfs
>     --nostrip             Do not strip binaries in the initramfs (def=
ault)
>     --mdadmconf           Include local /etc/mdadm.conf
> @@ -86,6 +90,10 @@ while (($#>  0)); do
>   	--fwdir) fw_dir_l=3D"$2"; shift;;
>   	--kernel-only) kernel_only=3D"yes"; no_kernel=3D"no";;
>   	--no-kernel) kernel_only=3D"no"; no_kernel=3D"yes";;
> +    --ignore-kernel-modules) kernel_only=3D"no"; no_kernel=3D"yes"
> +        ignore_kmodules=3D"yes"
> +        omit_dracutmodules_l+=3D\ kernel-modules
> +        ;;
>   	--strip) do_strip_l=3D"yes";;
>   	--nostrip) do_strip_l=3D"no";;
>           --mdadmconf) mdadmconf_l=3D"yes";;
> @@ -228,7 +236,7 @@ chmod 755 "$initdir"
>
>   export initdir hookdirs dracutbasedir dracutmodules drivers \
>       fw_dir drivers_dir debug beverbose no_kernel kernel_only \
> -    add_drivers mdadmconf lvmconf filesystems
> +    add_drivers mdadmconf lvmconf filesystems ignore_kmodules
>
>   if [[ $kernel_only !=3D yes ]]; then
>       # Create some directory structure first
> diff --git a/dracut.8 b/dracut.8
> index 3a85cb5..4890357 100644
> --- a/dracut.8
> +++ b/dracut.8
> @@ -52,6 +52,10 @@ only install kernel drivers and firmware files
>   .BR \-\-no-kernel
>   do not install kernel drivers and firmware files
>   .TP
> +.BR \-\-ignore-kernel-modules
> +don't try to load modules; it automatically implies \fB--no-kernel\f=
R; it's
> +assumed that everything needed is built into kernel
> +.TP
>   .BR \-\-mdadmconf
>   include local /etc/mdadm.conf
>   .TP
> diff --git a/modules.d/99base/install b/modules.d/99base/install
> index 6ba9e7e..9cdb086 100755
> --- a/modules.d/99base/install
> +++ b/modules.d/99base/install
> @@ -1,6 +1,13 @@
>   #!/bin/bash
> -dracut_install mount mknod mkdir modprobe pidof sleep chroot \
> -    sed ls flock cp mv dmesg rm ln rmmod mkfifo less
> +dracut_install mount mknod mkdir pidof sleep chroot sed ls flock cp =
mv dmesg \
> +        rm ln mkfifo less
> +if [[ ${ignore_kmodules} =3D yes ]]; then
> +    inst /bin/true
> +    ln -s /bin/true "${initdir}"/sbin/modprobe
> +    ln -s /bin/true "${initdir}"/sbin/rmmod
> +else
> +    dracut_install modprobe rmmod
> +fi
>   if [ ! -e "${initdir}/bin/sh" ]; then
>       dracut_install bash
>       (ln -s bash "${initdir}/bin/sh" || :)
> @@ -18,7 +25,7 @@ if which switch_root>/dev/null 2>&1; then
>       dracut_install switch_root
>   else
>       inst "$moddir/switch_root" "/sbin/switch_root" \
> -	|| derror "Failed to install switch_root"
> +            || derror "Failed to install switch_root"
>   fi
>   inst "$moddir/dracut-lib.sh" "/lib/dracut-lib.sh"
>   inst_hook cmdline 10 "$moddir/parse-root-opts.sh"
