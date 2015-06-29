From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: Re: [PATCH 7/8] ensure pre-mount (and resume) run before root fsck
Date: Tue, 30 Jun 2015 02:49:33 +0300
Message-ID: <20150630024933.3c41d601@home.puleglot.ru>
References: <1435330557-17685-1-git-send-email-trenn@suse.de>
	<1435330557-17685-8-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=mymail;
	h=Sender:Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date; bh=WH8/yikLMtW1k1C/sD7xK9LM3HaaAeY1q7dErntl0mY=;
	b=N/jRD8ZIEiiJg0vUmaPY3bSMIuwB2O4Pt/Yi93p6AHdVIukn4IlGhKYJ6rzAliM7FQF7J8B+wpf6II4/Tim2OE4vFoGIfR8v/MJZ45U3rU8rBbkxKZeiNty0SzaJmtz/9hteaa+N334hz6Anl1h1k5HJym/LTqq3uienmguxiEg=;
In-Reply-To: <1435330557-17685-8-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

=D0=92 Fri, 26 Jun 2015 16:55:56 +0200
Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> From: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> References:
> https://bugzilla.suse.com/show_bug.cgi?id=3D906592
> Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
> ---
>  modules.d/98dracut-systemd/rootfs-generator.sh | 18
> ++++++++++++++++++ 1 file changed, 18 insertions(+)
>=20
> diff --git a/modules.d/98dracut-systemd/rootfs-generator.sh
> b/modules.d/98dracut-systemd/rootfs-generator.sh index
> 5910ce7..7eb0b1a 100755 ---
> a/modules.d/98dracut-systemd/rootfs-generator.sh +++
> b/modules.d/98dracut-systemd/rootfs-generator.sh @@ -65,6 +65,23 @@
> generator_mount_rootfs() fi
>  }
> =20
> +generator_fsck_after_pre_mount()
> +{
> +    local _name
> +
> +    [ -z "$1" ] && return 0
> +
> +    _name=3D$(dev_unit_name "$1")
> +    [ -d /run/systemd/generator/systemd-fsck@${_name}.service.d ] ||
> mkdir -p /run/systemd/generator/systemd-fsck@${_name}.service.d
> +    if !
> [ -f /run/systemd/generator/systemd-fsck@${_name}.service.d/after-pre=
-mount.conf
> ]; then
> +        {
> +            echo "[Unit]"
> +            echo "After=3Ddracut-pre-mount.service"
> +        }
> > /run/systemd/generator/systemd-fsck@${_name}.service.d/after-pre-mo=
unt.conf
> +    fi
> +
> +}
> +
>  root=3D$(getarg root=3D)
>  case "$root" in
>      block:LABEL=3D*|LABEL=3D*)
> @@ -95,6 +112,7 @@ GENERATOR_DIR=3D"$1"
> =20
>  if [ "${root%%:*}" =3D "block" ]; then
>     generator_wait_for_dev "${root#block:}" "$RDRETRY"
> +   generator_fsck_after_pre_mount "${root#block:}"
>     strstr "$(cat /proc/cmdline)" 'root=3D' || generator_mount_rootfs
> "${root#block:}" "$(getarg rootfstype=3D)" "$(getarg rootflags=3D)" f=
i
> =20

Hmmm.. How about systemd >=3D220? See the following change:
http://cgit.freedesktop.org/systemd/systemd/commit/?id=3D4dda4e637e4c17=
a14db6cd265f36f5e8a5050367

Shouldn't we also add "Before=3Dsystemd-fsck-root.service" to
dracut-pre-mount.service?

--=20
Alexander Tsoy
