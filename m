From: =?utf-8?q?Amadeusz_=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: [PATCH 4/4] 91crypt-loop: use initqueue for cleanup strategy
Date: Wed, 31 Aug 2011 10:51:37 +0200
Message-ID: <1314780315-sup-5456@raeviah>
References: <1314711391-7149-1-git-send-email-leho@kraav.com> <1314711391-7149-4-git-send-email-leho@kraav.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; boundary="=-1314780698-999122-4656-3741-1-="
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1314711391-7149-4-git-send-email-leho-BFEd76tUscAAvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--=-1314780698-999122-4656-3741-1-=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Excerpts from Leho Kraav's message of 2011-08-30 15:36:31 +0200:
> ---
>  modules.d/90crypt/crypt-lib.sh           |    3 +++
>  modules.d/91crypt-loop/crypt-loop-lib.sh |    5 +++++
>  2 files changed, 8 insertions(+), 0 deletions(-)
> =

> diff --git a/modules.d/90crypt/crypt-lib.sh b/modules.d/90crypt/crypt-l=
ib.sh
> index b04512f..3095774 100755
> --- a/modules.d/90crypt/crypt-lib.sh
> +++ b/modules.d/90crypt/crypt-lib.sh
> @@ -225,6 +225,9 @@ readkey() {
>              if [ -f /lib/dracut-crypt-loop-lib.sh ]; then
>                  . /lib/dracut-crypt-loop-lib.sh
>                  loop_decrypt "$mntp" "$keypath" "$keydev" "$device"
> +                initqueue --onetime --finished --unique --name "crypt-=
loop-cleanup-99-$(basename $mntp)" \
> +                    $(command -v umount) "$mntp; " $(command -v rmdir)=
 "$mntp"
> +                return 0
>              else
>                  die "No loop file support to decrypt '$keypath' on '$k=
eydev'."
>              fi
> diff --git a/modules.d/91crypt-loop/crypt-loop-lib.sh b/modules.d/91cry=
pt-loop/crypt-loop-lib.sh
> index 63a553c..6774e7d 100644
> --- a/modules.d/91crypt-loop/crypt-loop-lib.sh
> +++ b/modules.d/91crypt-loop/crypt-loop-lib.sh
> @@ -32,6 +32,11 @@ loop_decrypt() {
>              --tty-echo-off
>  =

>          [ -b $key ] || die "Tried setting it up, but keyfile block dev=
ice was still not found!" =

> +
> +        initqueue --onetime --finished --unique --name "crypt-loop-cle=
anup-10-$(basename $key)" \
> +            $(command -v cryptsetup) "luksClose $key"
> +        initqueue --onetime --finished --unique --name "crypt-loop-cle=
anup-20-$(basename $loopdev)" \
> +            $(command -v losetup) "-d $loopdev"
>      else
>          info "Existing keyfile found, re-using it for $device"
>      fi

Always a bit better to use built-ins:

basename "$x" =3D=3D echo "${x#**/}"


-- =

Amadeusz =C5=BBo=C5=82nowski

PGP key fpr: C700 CEDE 0C18 212E 49DA  4653 F013 4531 E1DB FAB5

--=-1314780698-999122-4656-3741-1-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJOXfYZAAoJEPATRTHh2/q1+3MH/3bRBapvIQ7G7OlYyfPoRb5j
6FqKTyqaaJOOB/hX8jW+N0Qe2LrBuz3TStM85gNKWbhKUjvU2XBZoX226qFGnval
Yyf2V0rEFGgAYpm5pPhntAxutnK2IYschHUpxTTESjKXppffgPfvyGLrRfvVfb+e
M5Oc7B0KgYb8wlt/M6K7SIwk0VemdQX3T2SFdIYxmmnDj9hzs0yY4TxZ2WJiOwBy
yaaRc5phnkOhV1vrzIRN6L4vA/q5G2/j1U5o3hDQY6w6FmVXgC4bdiRKRP2iY9aa
cU1r1BB1oG4PiUtZC8n/yyuD3m/8M3vBK+pH9OVd7e5WAsl98/FTumf/+ojJohw=
=689p
-----END PGP SIGNATURE-----

--=-1314780698-999122-4656-3741-1-=--
