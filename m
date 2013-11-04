From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: Re: [PATCH] dracut-functions.sh: Avoid loading unnecessary 32-bit
 libraries for 64-bit initrds
Date: Tue, 5 Nov 2013 01:53:09 +0400
Message-ID: <20131105015309.1a6aa99b@home.puleglot>
References: <1383391590-437-1-git-send-email-colin@mageia.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:Message-ID:Subject:To:From:Date; bh=HAKOi/bv2ry8MH14qVGHtorYNn5XyG7fVrZQL7lhD5Q=;
	b=Pe0QMdADkjTDQDs//dxsz6M2CIM8usiQc5/cRyPgMWNFEHUxxG0Plbni9NtYU+3nnnYZ3hPmVxj5KktQjmL+XUgkz0h4pRtqQg01+O3UI7neXhQbZKEEMQpMb435Qi2S5b7aSLoL+x51fvoc/vMhZonAmaub94sb1OyEY20UywU=;
In-Reply-To: <1383391590-437-1-git-send-email-colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="koi8-r"
To: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

=F7 Sat,  2 Nov 2013 11:26:30 +0000
Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org> =D0=C9=DB=C5=D4:

> Due to the 'inst_libdir_file "libnss_files*"' in the udev-rules modul=
e
> this caues the /usr/lib/libnss_files-2.18.so* to be included. This is
> a 32-bit library and pulls in a 32-bit version of glibc also even on =
a
> 64-bit system.
>=20
> This is due to the fact that ldconfig -pN will print [/usr]/lib paths
> from the cache as well as [/usr]/lib64. As we handle these paths
> specifically we should ignore these results from the cache.
>=20
> Also there was a missing space when appending the ldconfig paths
> onto our list meaning the last builtin and first ldconfig path
> were unusable.
> ---
>  dracut-functions.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/dracut-functions.sh b/dracut-functions.sh
> index 2e6e845..1355aca 100755
> --- a/dracut-functions.sh
> +++ b/dracut-functions.sh
> @@ -65,6 +65,7 @@ ldconfig_paths()
>              printf "%s\n" ${d%/*};
>          done
>      ); do
> +        [[ "$i" =3D "/lib" || "$i" =3D "/usr/lib" || "$i" =3D "/lib6=
4" ||
> "$i" =3D "/usr/lib64" ]] && continue a["$i"]=3D1;

"/lib32" and "/usr/lib32" should be also excluded. In Gentoo by default
we have 32-bit binaries in lib32 and lib is a symlink to lib64.

>      done;
>      printf "%s\n" ${!a[@]}
> @@ -81,7 +82,7 @@ if ! [[ $libdirs ]] ; then
>          [[ -d /usr/lib ]] && libdirs+=3D" /usr/lib"
>      fi
> =20
> -    libdirs+=3D"$(ldconfig_paths)"
> +    libdirs+=3D" $(ldconfig_paths)"
> =20
>      export libdirs
>  fi


--=20
Alexander Tsoy
