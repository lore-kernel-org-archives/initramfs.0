From: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] listing modules fixed
Date: Wed, 9 Mar 2011 00:24:55 +0300
Message-ID: <AANLkTikP6V9KC14chu5tJjt_pEWQaSWRak1QCzXw5VGR@mail.gmail.com>
References: <1299618814-16400-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JCYlqA7riYEGsMqhmyV8W5wmKL+SGwjVTCYLyRSsxoc=;
        b=qs5H64WA2+wk7hq8gXb5CY5/9YJpptIk/4cZEo79c+6AFChCwMo/p1HZUDSl8eXRn8
         JkFjYNK4J7KKUf3hWxevCI6pND280HjjzP2pDEDlZQS1JHmfsVWoKg0FcdT8etxQF026
         aEHgveHQPovHqREccw1DvVgntgX4GCWZC05ng=
In-Reply-To: <1299618814-16400-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: =?ISO-8859-2?Q?Amadeusz_=AFo=B3nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

2011/3/9 Amadeusz =C5=BBo=C5=82nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>:
> Modules were not listed because code relied on deprecated 'install' a=
nd
> 'installkernel' scripts.
> ---
> =C2=A0dracut | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/dracut b/dracut
> index 6e6de1e..ef8d398 100755
> --- a/dracut
> +++ b/dracut
> @@ -227,7 +227,7 @@ export dracutfunctions
> =C2=A0[[ $do_list =3D yes ]] && {
> =C2=A0 =C2=A0 for mod in $dracutbasedir/modules.d/*; do
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [[ -d $mod ]] || continue;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0[[ -e $mod/install || -e $mod/installker=
nel ]] || continue;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0[[ -e $mod/module-setup.sh ]] || continu=
e;

The code in dracut-functions still supports both old and new style; I
guess it should check for both as well unless old is going to be
completely removed.

We still have some add-ons that were not ported to new API.
