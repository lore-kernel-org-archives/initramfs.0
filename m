From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Add option to bring up a device in initramfs
Date: Mon, 13 Aug 2012 11:10:29 -0400
Message-ID: <20120813151029.GE24876@redhat.com>
References: <20120809030848.GA10460@dhcp-16-143.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120809030848.GA10460-je1gSBvt1Td3da3rpXeqgR/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Aug 09, 2012 at 11:08:48AM +0800, Dave Young wrote:
>=20
> Kdump support dump to raw device which could be on top of complex sto=
rage
> such as multipath and iscsi which are standalone dracut modules.
>=20
> Add a --device option to dracut which will add the device to host_dev=
s so
> dracut can add the dependent modules automaticlly and enable them in =
initramfs.
>=20

You have not specified any format for --device argument? What do you ex=
pect
there? Device name, UUID, udev persistent link, or what?

Secondly, do we need some extra code to make sure somebody waits for
this device to come up? Who makes sure that initqueue does not exit
till this device node comes up.

Thanks
Vivek

> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Tested-by: Chao Wang <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  dracut.8.asc |    3 +++
>  dracut.sh    |    3 +++
>  2 files changed, 6 insertions(+)
>=20
> --- dracut.orig/dracut.sh
> +++ dracut/dracut.sh
> @@ -133,6 +133,7 @@ Creates initial ramdisk images for prelo
>    --mount "[DEV] [MP] [FSTYPE] [FSOPTS]"
>                          Mount device [DEV] on mountpoint [MP] with f=
ilesystem
>                          [FSTYPE] and options [FSOPTS] in the initram=
fs
> +  --device "[DEV]"      Bring up [DEV] in initramfs
>    -i, --include [SOURCE] [TARGET]
>                          Include the files in the SOURCE directory in=
to the
>                           Target directory in the final initramfs.
> @@ -261,6 +262,7 @@ TEMP=3D$(unset POSIXLY_CORRECT; getopt \
>      --long fscks: \
>      --long add-fstab: \
>      --long mount: \
> +    --long device: \
>      --long nofscks: \
>      --long ro-mnt \
>      --long kmoddir: \
> @@ -327,6 +329,7 @@ while :; do
>          --fscks)       push fscks_l              "$2"; shift;;
>          --add-fstab)   push add_fstab_l          "$2"; shift;;
>          --mount)       push fstab_lines          "$2"; shift;;
> +        --device)      push host_devs            "$2"; shift;;
>          --nofscks)     nofscks_l=3D"yes";;
>          --ro-mnt)      ro_mnt_l=3D"yes";;
>          -k|--kmoddir)  drivers_dir_l=3D"$2"; shift;;
> --- dracut.orig/dracut.8.asc
> +++ dracut/dracut.8.asc
> @@ -321,6 +321,9 @@ provide a valid _/etc/fstab_.
>      Mount _<device>_ on _<mountpoint>_ with _<filesystem type>_ and =
_<filesystem
>      options>_ in the initramfs
> =20
> +**--device** _<device>_ ::
> +    Bring up _<device>_ in initramfs
> +
>  **-i, --include**=A0_<SOURCE>_=A0_<TARGET>_::
>      include the files in the SOURCE directory into the
>      TARGET directory in the final initramfs. If SOURCE is a file, it=
 will be
