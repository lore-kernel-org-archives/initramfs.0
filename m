From: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Take into account lib64 dirs when detecting version,
 modules and params
Date: Sun, 11 Jan 2015 17:20:29 +0300
Message-ID: <20150111172029.0653ffce@opensuse.site>
References: <1420985530-5006-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Ny7Js0p0UD/lbz6WHgxjXxQgaMbRJ43EhWy/dBAU8sY=;
        b=OdBSmGgAbMyzg3z3wg/f5ONwZ6JLzHAwDz6UHtkI50rIgcjY7fsBKHL9GjSXgDV8Ye
         6LV6hjARBa2u8nW6aapCYtW/+bsfiTr50IFfDqcIDVUEWDLL5ttR8IOqb6OMMFRqFCLe
         LbGc9lyVnLUS7nST/c00uLoSs5+NQ/goaSPDwXst8u/hqfrJ+p3Kxid5yDFJPLX4E4JP
         VkgdRE9RgdYI6H9MZck8CuF27R7TvLwGtN5MrZU/KdonC1RbJ+Hburq+vRwxZHPAxB6l
         mZcR5cIMjYHnFNc9bE0G32DQWH6zK5ZXmw4sE7rfs9P9vQs6nUmN+X8pEoa6Tuc/+cqv
         jkmw==
In-Reply-To: <1420985530-5006-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

=D0=92 Sun, 11 Jan 2015 15:12:10 +0100
Amadeusz =C5=BBo=C5=82nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org> =D0=BF=D0=B8=D1=88=D0=
=B5=D1=82:

> ---
>  lsinitrd.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/lsinitrd.sh b/lsinitrd.sh
> index 4f12c2c..dc1f88f 100755
> --- a/lsinitrd.sh
> +++ b/lsinitrd.sh
> @@ -124,7 +124,7 @@ extract_files()
>  list_modules()
>  {
>      echo "dracut modules:"
> -    $CAT "$image" | cpio --extract --verbose --quiet --to-stdout -- =
'lib/dracut/modules.txt' 'usr/lib/dracut/modules.txt' 2>/dev/null
> +    $CAT "$image" | cpio --extract --verbose --quiet --to-stdout -- =
'lib64/dracut/modules.txt' 'lib/dracut/modules.txt' 'usr/lib/dracut/mod=
ules.txt' 2>/dev/null

How it can become lib64? Name is really hardcoded

=2E/dracut.sh:    printf "%s\n" "$i" >> $initdir/lib/dracut/modules.txt


>      ((ret+=3D$?))
>  }
> =20
> @@ -217,7 +217,7 @@ ret=3D0
>  if (( ${#filenames[@]} > 0 )); then
>      extract_files
>  else
> -    version=3D$($CAT "$image" | cpio --extract --verbose --quiet --t=
o-stdout -- 'lib/dracut/dracut-*' 'usr/lib/dracut/dracut-*' 2>/dev/null=
)
> +    version=3D$($CAT "$image" | cpio --extract --verbose --quiet --t=
o-stdout -- 'lib64/dracut/dracut-*' 'lib/dracut/dracut-*' 'usr/lib/drac=
ut/dracut-*' 2>/dev/null)

Can it really be lib64 here?

>      ((ret+=3D$?))
>      echo "Version: $version"
>      echo
> @@ -226,7 +226,7 @@ else
>          echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D"
>      else
>          echo -n "Arguments: "
> -        $CAT "$image" | cpio --extract --verbose --quiet --to-stdout=
 -- 'lib/dracut/build-parameter.txt' 'usr/lib/dracut/build-parameter.tx=
t' 2>/dev/null
> +        $CAT "$image" | cpio --extract --verbose --quiet --to-stdout=
 -- 'lib64/dracut/build-parameter.txt' 'lib/dracut/build-parameter.txt'=
 'usr/lib/dracut/build-parameter.txt' 2>/dev/null

Ditto.

>          echo
>          list_modules
>          list_files
