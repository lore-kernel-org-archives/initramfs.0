From: =?utf-8?q?Amadeusz_=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: [PATCH 2/2] (wip) successfully unlocks LUKS devices from an encrypted loop file
Date: Thu, 28 Apr 2011 08:24:07 +0200
Message-ID: <1303971430-sup-4255@ittemni>
References: <1303893012-10923-1-git-send-email-leho@kraav.com> <1303893012-10923-2-git-send-email-leho@kraav.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-1303971847-289689-4213-4056-2-="; protocol="application/pgp-signature"
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1303893012-10923-2-git-send-email-leho-BFEd76tUscAAvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: leho <leho-BFEd76tUscAAvxtiuMwx3w@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--=-1303971847-289689-4213-4056-2-=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Excerpts from leho's message of Wed Apr 27 10:30:12 +0200 2011:
> +            # Something seems to be locking our loop device
> +            while ! losetup -d $l; do
> +                sleep 0.5
> +            done =


What if it falls into infinite loop?  Anyway polling is not a good
thing.  You should do the same what is done when key for the device is
not found yet.  Notice what's done in =E2=80=9Celse block=E2=80=9D in cry=
ptoroot-ask:

modules.d/90crypt/cryptoroot-ask.sh:
> if tmp=3D$(getkey /tmp/luks.keys $device); then
>     keydev=3D"${tmp%%:*}"
>     keypath=3D"${tmp#*:}"
> else
>     info "No key found for $device.  Will try later."
>     initqueue --unique --onetime --settled \
>         --name cryptroot-ask-$luksname \
>         $(command -v cryptroot-ask) "$@"
>     exit 0
> fi
-- =

Amadeusz =C5=BBo=C5=82nowski

PGP key fpr: C700 CEDE 0C18 212E 49DA  4653 F013 4531 E1DB FAB5

--=-1303971847-289689-4213-4056-2-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJNuQgHAAoJEPATRTHh2/q1sQUH/0L1C6ujOngDAFuyj9BxXqIb
R8QQTMk8qJ7KZQAIn/wuGt+aY+X7sZQ9PVfXho+jhGPSHlZiomwDXklM6wnyUlU7
WV3C54M/STRk+/3laf/TWeaAfiojX7ffcAx+wRvN07e3faRDCmRg1x+cWj3prMsq
nUVaVsoGMnFgq9uc3HR9WDq691BKmVK70osCAMxfZKbaTqy+m47KwKWy0k0bmr6P
KAexZvUkCawa+G3DcnAeLfk3PyhJIxpv63nlV++vt9HuCa0IU5qZg3L5IbsTADPU
myW5NFFgwvVrIcFqLzV/dBfouTVACkROE5Gh3t63dyeorDdMuuueF1dvkDu22eQ=
=YzA9
-----END PGP SIGNATURE-----

--=-1303971847-289689-4213-4056-2-=--
