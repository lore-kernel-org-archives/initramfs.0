From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] add default values in fstab_lines
Date: Mon, 17 Feb 2014 10:55:12 -0500
Message-ID: <20140217155512.GG11670@redhat.com>
References: <20140214084921.GA30064@dhcp-16-126.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140214084921.GA30064-je1gSBvt1TcFLmT5oZ11vB/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, Feb 14, 2014 at 04:49:21PM +0800, Dave Young wrote:
> It's useful for passing a full fstab line including like fs_passno so=
 fsck
> can take effect.
>=20
> Previously it's assumed that there's no fs_freq and fs_passno in fsta=
b lines
> so original code just append "0 0" at the end of each fstab lines.
>=20
> Improve this issue by assign default value in case they are not passe=
d in.
> Three field are handled here:
> fs_mntops: default to "defaults"
> fs_freq: default to "0"
> fs_passno: default to "0"=20
>=20
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  dracut.8.asc |    8 ++++++--
>  dracut.sh    |    6 +++++-
>  2 files changed, 11 insertions(+), 3 deletions(-)
>=20
> --- dracut.orig/dracut.sh
> +++ dracut/dracut.sh
> @@ -1222,7 +1222,11 @@ if [[ $kernel_only !=3D yes ]]; then
>      [[ $kernel_cmdline ]] && printf "%s\n" "$kernel_cmdline" >> "${i=
nitdir}/etc/cmdline.d/01-default.conf"
> =20
>      while pop fstab_lines line; do
> -        printf "%s\n" "$line 0 0" >> "${initdir}/etc/fstab"
> +        line=3D($line)
> +        [ -z "${line[3]}" ] && line[3]=3D"defaults"
> +        [ -z "${line[4]}" ] && line[4]=3D"0"
> +        [ -z "${line[5]}" ] && line[5]=3D"0"
> +        echo "${line[@]}" >> "${initdir}/etc/fstab"
>      done
> =20
>      for f in $add_fstab; do
> --- dracut.orig/dracut.8.asc
> +++ dracut/dracut.8.asc
> @@ -311,9 +311,13 @@ provide a valid _/etc/fstab_.
>  **--add-fstab** _<filename>_::
>      Add entries of _<filename>_ to the initramfs /etc/fstab.
> =20
> -**--mount**=A0"_<device>_ _<mountpoint>_ _<filesystem type>_ _<files=
ystem options>_"::
> +**--mount**=A0"_<device>_ _<mountpoint>_ _<filesystem type>_ _<files=
ystem options>_ _<dump options>_ _<fsck order>_"::
>      Mount _<device>_ on _<mountpoint>_ with _<filesystem type>_ and =
_<filesystem
> -    options>_ in the initramfs
> +    options>_ in the initramfs. _<dump options>_ and _<fsck order>_ =
can also be

How do you differentiate between filesystem options and dump option?  I=
OW,
what is used as separator so that dracut and find out what is a a
filesystem option and what is a dump option or pass number option?


> +    specified, see fstab manpage for the details.
> +    The default _<filesystem options>_ is "defaults".
> +    The default _<dump options>_ is "0".
> +    the default _<fsck order>_ is "2".

In changelog you said default is 0 and not 2. Also I personally like to
use fs_freq and fs_passno field in description as they are known in fst=
ab
instead of coming up with new names "dump options" and fsck order"

Thanks
Vivek
