From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: Re: [PATCH 17/42] Align dev_unit_name() with systemd's function.
Date: Tue, 24 Feb 2015 12:37:51 +0300
Message-ID: <20150224123751.48e24fe2@laptop.puleglot.ru>
References: <1418309193-11208-1-git-send-email-trenn@suse.de>
	<1418309193-11208-18-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=mymail;
	h=Sender:Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date; bh=s+EbyqZF5zZe9EWmyR9ng2QODiuqquVu8Si5kYaA4mQ=;
	b=SPoRIP/1IBhNolkgx80HPdRxUWlvK6CXslVo0DEbs77HWDPyeFNsu96ufFI3kQd+atPUGPZUaRWwf62lp3e8QDin1dLKjmcVev68F+F53o9Fpp2TvDPgoTO4Lhxor3UyWqjOgbL6JDXj/QoK4P0UFvSgtEcXbGgobrMUqwkAv9A=;
In-Reply-To: <1418309193-11208-18-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thorsten Behrens <tbehrens-IBi9RG/b67k@public.gmane.org>

Hello all!

=D0=92 Thu, 11 Dec 2014 15:46:08 +0100
Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> From: Thorsten Behrens <tbehrens-IBi9RG/b67k@public.gmane.org>
>=20
> Add more corner cases from systemd's
> unit_name_from_path_instance() C function.
>=20
> Signed-off-by: Thorsten Behrens <tbehrens-IBi9RG/b67k@public.gmane.org>
> Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
> ---
>  modules.d/99base/dracut-lib.sh | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>=20
> diff --git a/modules.d/99base/dracut-lib.sh
> b/modules.d/99base/dracut-lib.sh index f7cffc4..5c1504f 100755
> --- a/modules.d/99base/dracut-lib.sh
> +++ b/modules.d/99base/dracut-lib.sh
> @@ -866,18 +866,30 @@ wait_for_mount()
>      } >> "$hookdir/emergency/90-${_name}.sh"
>  }
> =20
> +# get a systemd-compatible unit name from a path
> +# (mimicks unit_name_from_path_instance())
>  dev_unit_name()
>  {
> +    local dev=3D"$1"
> +
>      if command -v systemd-escape >/dev/null; then
> -        systemd-escape -p  "$1"
> +        systemd-escape -p  "$dev"
>          return
>      fi
> =20
> -    _name=3D"${1%%/}"
> -    _name=3D"${_name##/}"
> -    _name=3D"$(str_replace "$_name" '-' '\x2d')"
> -    _name=3D"$(str_replace "$_name" '/' '-')"
> -    echo "$_name"
> +    if [ "$dev" =3D "/" -o -z "$dev" ]; then
> +        printf -- "-"
> +        exit 0
> +    fi
> +
> +    dev=3D"${1%%/}"
> +    dev=3D"${dev##/}"
> +    dev=3D"$(str_replace "$dev" '\' '\x5c')"
> +    dev=3D"$(str_replace "$dev" '-' '\x2d')"
> +    dev=3D${dev/#\./\\x2e}

The above string substitution works only in bash. With dash it gives
the following warnings:

$ grep 'Bad subst' rdsosreport.txt=20
[    2.493678] laptop dracut-cmdline[121]: /bin/dracut-cmdline:
889: //lib/dracut/hooks/cmdline/30-parse-lvm.sh: Bad substitution
[    2.537849] laptop dracut-cmdline[121]: /bin/dracut-cmdline:
889: //lib/dracut/hooks/cmdline/30-parse-lvm.sh: Bad substitution
[    2.578491] laptop dracut-cmdline[121]: /bin/dracut-cmdline:
889: //lib/dracut/hooks/cmdline/30-parse-lvm.sh: Bad substitution
[    3.854089] laptop dracut-initqueue[250]: /bin/dracut-initqueue:
889: /lib/dracut/hooks/initqueue/settled/systemd-cryptsetup-sda3.sh:
Bad substitution


Harald, is dash is still supported by dracut and do you accept patches
to remove bashisms?

> +    dev=3D"$(str_replace "$dev" '/' '-')"
> +
> +    printf -- "%s" "$dev"
>  }
> =20
>  # wait_for_dev <dev>

--=20
Alexander Tsoy
