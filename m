From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] dracut: setup English locales for Dracut build script
Date: Fri, 18 Jun 2010 07:16:12 -0500
Message-ID: <AANLkTil85GmgtdZieaCwu93axSYZnlpVDpMX2kSRQiUQ@mail.gmail.com>
References: <20100618133841.61845f0d@etiriah.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Hvz95psQrcfkCZlY0EFK0Dv7Qhcu3n9Cymd3w5STRzE=;
        b=w9CS3Uld5SztwCCd6EeszryNUrmkI96GrioeLgy1f8cgzy8qKkK1zrRFi9sgFfopj0
         xMEPMtgeHThzANNfZe39DHE0zzY83FpWut2kdWmO//dgmxrkjvKlPU6JLqxbq/UmSS0z
         5VTl/SSG9hm8HOGA3gJI2ynPfQdpyn+VvSPPE=
In-Reply-To: <20100618133841.61845f0d-YdJE6FOikKfe60hTmSeVGxfX6IwIUJvj@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: =?ISO-8859-2?Q?Amadeusz_=AFo=B3nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

2010/6/18 Amadeusz =C5=BBo=C5=82nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>:
> Dracut rely upon programs' output like ldd's "not a dynamic executabl=
e".
> Assume user sets up Polish locales and then ldd prints
> "nie jest dynamicznym programem wykonywalnym". =C2=A0The patch preven=
ts this.
> ---
> =C2=A0dracut | =C2=A0 15 +++++++++++++++
> =C2=A01 files changed, 15 insertions(+), 0 deletions(-)
>
> diff --git a/dracut b/dracut
> index 3be4989..1437625 100755
> --- a/dracut
> +++ b/dracut
> @@ -71,6 +71,17 @@ Creates initial ramdisk images for preloading modu=
les
> =C2=A0"
> =C2=A0}

Hmmm... The usual way to do this is to run the program in the C locale
by setting
LC_ALL=3DC

> +# Change locales and language leaving existing suffix (.utf8 or simi=
lar).
> +# $1 =3D language (e.g. en_US)
> +change_locales() {
> + =C2=A0 =C2=A0local lang=3D(${LANG/./ })
> + =C2=A0 =C2=A0lang[0]=3D$1
> + =C2=A0 =C2=A0lang=3D${lang[@]}
> + =C2=A0 =C2=A0LANG=3D${lang/ /.}
> + =C2=A0 =C2=A0LC_ALL=3D${LANG}
> + =C2=A0 =C2=A0export LANG LC_ALL
> +}
> +
> =C2=A0while (($# > 0)); do
> =C2=A0 =C2=A0 case $1 in
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-f|--force) force=3Dyes;;
> @@ -107,6 +118,10 @@ done
>
> =C2=A0PATH=3D/sbin:/bin:/usr/sbin:/usr/bin
> =C2=A0export PATH
> +# We rely upon programs' output like ldd's "not found", so we have t=
o
> +# set up English locales.
> +change_locales en_US
> +
>
> =C2=A0[[ $debug ]] && {
> =C2=A0 =C2=A0 export PS4=3D'${BASH_SOURCE}@${LINENO}(${FUNCNAME[0]}):=
 ';
> --
> 1.7.1
>
