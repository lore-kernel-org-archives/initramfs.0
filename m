From: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 8/8] Use udev rules to create dmraid /dev/mapper/
 devices
Date: Sat, 27 Jun 2015 08:41:53 +0300
Message-ID: <20150627084153.1936a074@opensuse.site>
References: <1435330557-17685-1-git-send-email-trenn@suse.de>
	<1435330557-17685-9-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9iK5LZajxjKMX12EHTaNxlbtfYaEm2sPHvWzMVtmoIQ=;
        b=rxFIZTG7U7FYn82NVBehy90UmgeqmAkykW24jAt4RTaIX1Le1r15x2o5ZDpj1yP/au
         y6CPY7KVp2Yw6cTRJT1dDjN7w3jULI8M6a1SvUh8bBx7P5A1vtpNUx8bBaulYFm8nOV/
         tlevORSNWz7Fl1hD4WzP5AXl/vYaPR7XOHeIvMc7MKfBaDI9klGzO84xVLeCGsAHQMOF
         5HKgN0Z5tHNllZG4FXi7gZi98YfXY9bMsJWEgyWJ/0Jne97TMNzWXPs5/3T71LMjPqKz
         8/f0alVAYUCGrLNqVloNF/+iqV652eJPlxXCbvLKqP/qIDS4MnRpHG+SmyiV5JVMKJf1
         gtyg==
In-Reply-To: <1435330557-17685-9-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hannes Reinecke <hare-IBi9RG/b67k@public.gmane.org>

=D0=92 Fri, 26 Jun 2015 16:55:57 +0200
Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> From: Hannes Reinecke <hare-IBi9RG/b67k@public.gmane.org>
>=20
> https://bugzilla.opensuse.org/show_bug.cgi?id=3D905746
> Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
> ---
>  modules.d/90dmraid/dmraid.sh       | 2 --
>  modules.d/90dmraid/module-setup.sh | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/modules.d/90dmraid/dmraid.sh b/modules.d/90dmraid/dmraid=
=2Esh
> index 3dcff38..cc4390f 100755
> --- a/modules.d/90dmraid/dmraid.sh
> +++ b/modules.d/90dmraid/dmraid.sh
> @@ -26,8 +26,6 @@ if [ -n "$DM_RAIDS" ] || getargbool 0 rd.auto; then
>                  if [ "${s##$r}" !=3D "$s" ]; then
>                      info "Activating $s"
>                      dmraid -ay -i -p --rm_partitions "$s" 2>&1 | vin=
fo
> -                    [ -e "/dev/mapper/$s" ] && kpartx -a "/dev/mappe=
r/$s" 2>&1 | vinfo
> -                    udevsettle
>                  fi
>              done
>          done
> diff --git a/modules.d/90dmraid/module-setup.sh b/modules.d/90dmraid/=
module-setup.sh
> index e8de5f5..b77bbcf 100755
> --- a/modules.d/90dmraid/module-setup.sh
> +++ b/modules.d/90dmraid/module-setup.sh
> @@ -74,6 +74,8 @@ install() {
> =20
>      inst "$moddir/dmraid.sh" /sbin/dmraid_scan
> =20
> +    inst_rules 64-md-raid.rules 66-kpartx.rules 67-kpartx-compat.rul=
es
> +

Why 64-md-raid.rules is here?=20

>      inst_libdir_file "libdmraid-events*.so*"
> =20
>      inst_rules "$moddir/61-dmraid-imsm.rules"
