From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] Revert "add option --ignore-kernel-modules"
Date: Fri, 15 Oct 2010 09:53:42 +0200
Message-ID: <4CB80886.5010809@redhat.com>
References: <1286991554-3715-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1286991554-3715-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/13/2010 07:39 PM, Amadeusz =C5=BBo=C5=82nowski wrote:
> This reverts commit 0ca3a5ee849614e85241274d24380f3eabd73b78
> and removes later changes related to this commit.
>
> Conflicts:
>
> 	dracut
> 	dracut.8
> 	modules.d/99base/install
> ---
>   NEWS                     |    1 +
>   dracut                   |   10 +---------
>   dracut.8.xml             |    9 ---------
>   modules.d/99base/install |   12 ++----------
>   4 files changed, 4 insertions(+), 28 deletions(-)
>
> diff --git a/NEWS b/NEWS
> index 766867d..a2a7c7b 100644
> --- a/NEWS
> +++ b/NEWS
> @@ -1,5 +1,6 @@
>   dracut-008
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +- removed --ignore-kernel-modules option (no longer necessary)
>
>   dracut-007
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/dracut b/dracut
> index 9c1223a..303d817 100755
> --- a/dracut
> +++ b/dracut
> @@ -49,10 +49,6 @@ Creates initial ramdisk images for preloading modu=
les
>                           firmwares, separated by :
>     --kernel-only         Only install kernel drivers and firmware fi=
les
>     --no-kernel           Do not install kernel drivers and firmware =
files
> -  --ignore-kernel-modules
> -                        Don't try to load modules. It automatically =
implies
> -                         '--no-kernel'. It's assumed that everything=
 needed
> -                         is built into kernel.
>     --strip               Strip binaries in the initramfs
>     --nostrip             Do not strip binaries in the initramfs (def=
ault)
>     --mdadmconf           Include local /etc/mdadm.conf
> @@ -147,10 +143,6 @@ while (($#>  0)); do
>               type pigz>  /dev/null 2>&1&&  compress=3D"pigz -9" || \
>                   compress=3D"gzip -9"
>               fi;;
> -        --ignore-kernel-modules) kernel_only=3D"no"; no_kernel=3D"ye=
s"
> -            ignore_kmodules=3D"yes"
> -            omit_dracutmodules_l+=3D\ kernel-modules
> -            ;;
>           --list-modules)
>               do_list=3D"yes";
>               ;;
> @@ -304,7 +296,7 @@ chmod 755 "$initdir"
>
>   export initdir hookdirs dracutbasedir dracutmodules drivers \
>       fw_dir drivers_dir debug beverbose no_kernel kernel_only \
> -    add_drivers mdadmconf lvmconf filesystems ignore_kmodules \
> +    add_drivers mdadmconf lvmconf filesystems \
>       use_fstab libdir usrlibdir
>
>   if [[ $kernel_only !=3D yes ]]; then
> diff --git a/dracut.8.xml b/dracut.8.xml
> index a27c6e9..0931f48 100644
> --- a/dracut.8.xml
> +++ b/dracut.8.xml
> @@ -204,15 +204,6 @@ include in the generic initramfs. This parameter=
 can be specified multiple times
>           </varlistentry>
>           <varlistentry>
>             <term>
> -<option>--ignore-kernel-modules</option>
> -</term>
> -<listitem>
> -<para>don&apos;t try to load modules; it automatically implies<optio=
n>--no-kernel</option>; it&apos;s
> -assumed that everything needed is built into kernel</para>
> -</listitem>
> -</varlistentry>
> -<varlistentry>
> -<term>
>               <option>--mdadmconf</option>
>             </term>
>             <listitem>
> diff --git a/modules.d/99base/install b/modules.d/99base/install
> index 6fac851..aa897e8 100755
> --- a/modules.d/99base/install
> +++ b/modules.d/99base/install
> @@ -1,15 +1,8 @@
>   # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4=
; -*-
>   # ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
>
> -dracut_install mount mknod mkdir pidof sleep chroot sed ls flock cp =
mv dmesg \
> -    rm ln mkfifo less
> -if [[ ${ignore_kmodules} =3D yes ]]; then
> -    inst /bin/true
> -    ln -s /bin/true "${initdir}"/sbin/modprobe
> -    ln -s /bin/true "${initdir}"/sbin/rmmod
> -else
> -    dracut_install modprobe rmmod
> -fi
> +dracut_install mount mknod mkdir modprobe pidof sleep chroot \
> +    sed ls flock cp mv dmesg rm ln rmmod mkfifo less
>   if [ ! -e "${initdir}/bin/sh" ]; then
>       dracut_install bash
>       (ln -s bash "${initdir}/bin/sh" || :)
> @@ -33,4 +26,3 @@ inst "$moddir/dracut-lib.sh" "/lib/dracut-lib.sh"
>   inst_hook cmdline 10 "$moddir/parse-root-opts.sh"
>   inst_hook cmdline 20 "$moddir/parse-blacklist.sh"
>   mkdir -p "${initdir}/var/run"
> -

pushed
