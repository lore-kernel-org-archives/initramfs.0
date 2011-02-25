From: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] dracut-functions: fixed doubled $initdir prefix inst_library()
Date: Fri, 25 Feb 2011 13:14:36 +0100
Message-ID: <AANLkTimUuoaOWg2HHBSGcrwrxQH3FFcAVtbLWfo+y6Je@mail.gmail.com>
References: <1298624374-23980-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uWltp940KDjTpsaxDm4uyJ9/TL64W/n9yEmOc7MhKSA=;
        b=XGfG+1aO3thddF8nbHuEJd6Q28C1HdnW+Quxq9R2BMFV8+2uojPbOt62LWZdmZBokp
         3GnUGnPIJT/DNhOOk6EPTcZC0Uj4q2Lz7V2pt4xEKOMoAS5v8iTfY+FACKSbCUMw9kre
         gzDI8Qjl5iEjDWesqSq0n6coadgc1BLldBP3A=
In-Reply-To: <1298624374-23980-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: =?ISO-8859-2?Q?Amadeusz_=AFo=B3nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello,

2011/2/25 Amadeusz =C5=BBo=C5=82nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>:
> Commit 172d85b9c949b321771d63dbd5f06ecf19cf94f0 caused following erro=
r:
>
> ./dracut-functions: line 307: cd: /tmp/initramfs.mP7cPY/tmp/initramfs=
=2EmP7cPY/lib64: No such file or directory
>
> Patch removes beginning $initdir for symlink case.
> ---
> =C2=A0dracut-functions | =C2=A0 =C2=A06 ++++--
> =C2=A01 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/dracut-functions b/dracut-functions
> index 1cb43e7..cc16760 100755
> --- a/dracut-functions
> +++ b/dracut-functions
> @@ -302,8 +302,10 @@ inst_library() {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 lib=3D${src##*/}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 inst_simple "$reallib" "$reallib"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 inst_dir "${dest%/*}"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0[[ -L ${initdir}${dest%/*} ]] && \
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0dest=3D$(readlink -f ${initdir}${dest%/*=
})/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if [[ -L ${initdir}${dest%/*} ]]; then
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dest=3D$(readlink -f ${ini=
tdir}${dest%/*})/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dest=3D${dest#${initdir}}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 (cd "${initdir}${dest%/*}" && ln -s "$rea=
llib" "$lib")

I'm sorry about the trouble caused by my patch I didn't considered the
case /lib64 -> lib. On debian I was getting /lib64 -> /lib

Regards,

JonAn.
