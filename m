From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 08/16] Add support for bzip2 and xz compressed initramfs images.
Date: Sat, 14 Aug 2010 21:02:16 -0500
Message-ID: <AANLkTinQO4Z3_u+wKx0CDUABJ3F2Et_PL===sPTmZsKF@mail.gmail.com>
References: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther@gmail.com>
	<d23e6d8e5281904090c6a05cecf1576ee7f098f6.1281812506.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=s5VNk6uGAmlxhkqSpWpIXxDaAwxrM+WzE+4pO6PYJHo=;
        b=DTBdV2u7K3XVFqCA5v7SFnPm/rTeUlqJgpfD4PfSSPPcZvpiOvSXxEnjeXLKmqfW1U
         qwzNtWwsPvzYaPuXsTQg4muJJQE2qDexDpWpVnHUXFico/LqOfQ2A+/1p3rn8w9C9BMo
         siMsNPOvymq/JAbw/fAxoADrjPbliRxZLu0RA=
In-Reply-To: <d23e6d8e5281904090c6a05cecf1576ee7f098f6.1281812506.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

In this one, s/xz/lzma/g.

On Sat, Aug 14, 2010 at 2:23 PM, Victor Lowther
<victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Current kernels know how to uncompress bzip2 and xz, so use them for =
compressing
> the initramfs if asked. =A0The more compression the merrier.
>
> Also add support for generating uncompressed images, although they
> are usually not what you want.
>
> ---
> =A0dracut =A0 =A0 =A0 =A0 =A0 =A0 | =A0 21 ++++++++++++++++++---
> =A0mkinitrd-dracut.sh | =A0 =A02 +-
> =A02 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/dracut b/dracut
> index a2bc312..5c1c4b4 100755
> --- a/dracut
> +++ b/dracut
> @@ -75,6 +75,17 @@ Creates initial ramdisk images for preloading modu=
les
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Target directory i=
n the final initramfs.
> =A0 -I, --install [LIST] =A0Install the space separated list of files=
 into the
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0initramfs.
> + =A0--gzip =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Compress the generated ini=
tramfs using gzip.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0This will be done by=
 default, unless another
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compression option o=
r --no-compress is passed.
> + =A0--bzip2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Compress the generated initr=
amfs using bzip2.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Make sure your kerne=
l has bzip2 decompression support
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compiled in, otherwi=
se you will not be able to boot.
> + =A0--xz =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Compress the generated i=
nitramfs using xz.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Make sure your kerne=
l has xz support compiled in,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0otherwise you will n=
ot be able to boot.
> + =A0--no-compress =A0 =A0 =A0 =A0 Do not compress the generated init=
ramfs. =A0This will
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0override any other c=
ompression options.
> =A0"
> =A0}
>
> @@ -111,6 +122,10 @@ while (($# > 0)); do
> =A0 =A0 =A0 =A0--fstab) use_fstab_l=3D"yes" ;;
> =A0 =A0 =A0 =A0-i|--include) include_src=3D"$2"; include_target=3D"$3=
"; shift 2;;
> =A0 =A0 =A0 =A0-I|--install) install_items=3D"$2"; shift;;
> + =A0 =A0 =A0 =A0--gzip) [[ $compress !=3D cat ]] && compress=3D"gzip=
 -9";;
> + =A0 =A0 =A0 =A0--bzip2) [[$compress !=3D cat ]] && compress=3D"bzip=
2 -9";;
> + =A0 =A0 =A0 =A0--xz) [[ $compress !=3D cat ]] && compress=3D"xz -9"=
;;
> + =A0 =A0 =A0 =A0--no-compress) compress=3D"cat";;
> =A0 =A0 =A0 =A0-*) printf "\nUnknown option: %s\n\n" "$1" >&2; usage;=
 exit 1;;
> =A0 =A0 =A0 =A0*) break ;;
> =A0 =A0 esac
> @@ -174,6 +189,7 @@ fw_dir=3D${fw_dir//:/ }
>
> =A0[[ $hostonly =3D yes ]] && hostonly=3D"-h"
> =A0[[ $hostonly !=3D "-h" ]] && unset hostonly
> +[[ $compress ]] || compress=3D"gzip -9"
>
> =A0if [[ -f $dracutbasedir/dracut-functions ]]; then
> =A0 =A0. $dracutbasedir/dracut-functions
> @@ -323,8 +339,8 @@ type hardlink &>/dev/null && {
> =A0 =A0 =A0 =A0hardlink "$initdir" 2>&1
> =A0}
>
> -type pigz &>/dev/null && gzip=3Dpigz || gzip=3Dgzip
> -( cd "$initdir"; find . |cpio -R 0:0 -H newc -o --quiet |$gzip -9 > =
"$outfile"; )
> +[[ $compress =3D gzip* ]] && type pigz > /dev/null 2>&1 && compress=3D=
"pigz -9"
> +( cd "$initdir"; find . |cpio -R 0:0 -H newc -o --quiet |$compress >=
 "$outfile"; )
> =A0if [ $? -ne 0 ]; then
> =A0 =A0 derror "dracut: creation of $outfile failed"
> =A0 =A0 exit 1
> @@ -333,4 +349,3 @@ fi
> =A0[[ $beverbose =3D yes ]] && ls -lh "$outfile"
>
> =A0exit 0
> -
> diff --git a/mkinitrd-dracut.sh b/mkinitrd-dracut.sh
> index 64b3069..59333a7 100644
> --- a/mkinitrd-dracut.sh
> +++ b/mkinitrd-dracut.sh
> @@ -96,7 +96,7 @@ while [ $# -gt 0 ]; do
> =A0 =A0 =A0 =A0 --without*) ;;
> =A0 =A0 =A0 =A0 --without-usb) ;;
> =A0 =A0 =A0 =A0 --fstab*) ;;
> - =A0 =A0 =A0 =A0--nocompress) ;;
> + =A0 =A0 =A0 =A0--nocompress) dracut_args=3D"$dracut_args --no-compr=
ess";;
> =A0 =A0 =A0 =A0 --ifneeded) ;;
> =A0 =A0 =A0 =A0 --omit-scsi-modules) ;;
> =A0 =A0 =A0 =A0 --omit-ide-modules) ;;
> --
> 1.7.2.1
>
>
