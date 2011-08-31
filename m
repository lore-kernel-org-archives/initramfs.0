From: =?utf-8?q?Amadeusz_=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: [PATCH 4/4] 91crypt-loop: use initqueue for cleanup strategy
Date: Wed, 31 Aug 2011 11:29:48 +0200
Message-ID: <1314782941-sup-2236@raeviah>
References: <1314711391-7149-1-git-send-email-leho@kraav.com> <1314711391-7149-4-git-send-email-leho@kraav.com> <1314780315-sup-5456@raeviah>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; boundary="=-1314782989-138439-18958-4287-1-="
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1314780315-sup-5456@raeviah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--=-1314782989-138439-18958-4287-1-=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Excerpts from Amadeusz =C5=BBo=C5=82nowski's message of 2011-08-31 10:51:=
37 +0200:
> Excerpts from Leho Kraav's message of 2011-08-30 15:36:31 +0200:
> > ---
> >  modules.d/90crypt/crypt-lib.sh           |    3 +++
> >  modules.d/91crypt-loop/crypt-loop-lib.sh |    5 +++++
> >  2 files changed, 8 insertions(+), 0 deletions(-)
> > =

> > diff --git a/modules.d/90crypt/crypt-lib.sh b/modules.d/90crypt/crypt=
-lib.sh
> > index b04512f..3095774 100755
> > --- a/modules.d/90crypt/crypt-lib.sh
> > +++ b/modules.d/90crypt/crypt-lib.sh
> > @@ -225,6 +225,9 @@ readkey() {
> >              if [ -f /lib/dracut-crypt-loop-lib.sh ]; then
> >                  . /lib/dracut-crypt-loop-lib.sh
> >                  loop_decrypt "$mntp" "$keypath" "$keydev" "$device"
> > +                initqueue --onetime --finished --unique --name "cryp=
t-loop-cleanup-99-$(basename $mntp)" \
> > +                    $(command -v umount) "$mntp; " $(command -v rmdi=
r) "$mntp"
> > +                return 0
> >              else
> >                  die "No loop file support to decrypt '$keypath' on '=
$keydev'."
> >              fi
> > diff --git a/modules.d/91crypt-loop/crypt-loop-lib.sh b/modules.d/91c=
rypt-loop/crypt-loop-lib.sh
> > index 63a553c..6774e7d 100644
> > --- a/modules.d/91crypt-loop/crypt-loop-lib.sh
> > +++ b/modules.d/91crypt-loop/crypt-loop-lib.sh
> > @@ -32,6 +32,11 @@ loop_decrypt() {
> >              --tty-echo-off
> >  =

> >          [ -b $key ] || die "Tried setting it up, but keyfile block d=
evice was still not found!" =

> > +
> > +        initqueue --onetime --finished --unique --name "crypt-loop-c=
leanup-10-$(basename $key)" \
> > +            $(command -v cryptsetup) "luksClose $key"
> > +        initqueue --onetime --finished --unique --name "crypt-loop-c=
leanup-20-$(basename $loopdev)" \
> > +            $(command -v losetup) "-d $loopdev"
> >      else
> >          info "Existing keyfile found, re-using it for $device"
> >      fi
> =

> Always a bit better to use built-ins:
> =

> basename "$x" =3D=3D echo "${x#**/}"

Ups.  echo ${x##*/}, of course :-)

-- =

Amadeusz =C5=BBo=C5=82nowski

PGP key fpr: C700 CEDE 0C18 212E 49DA  4653 F013 4531 E1DB FAB5

--=-1314782989-138439-18958-4287-1-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJOXf8NAAoJEPATRTHh2/q1i/cIAJzGZzaNdn2jOAYWH+eNtcP8
RjKKsK690rqkzD7qex7t38EF09gXsGoi0pwYBGdEnZj5Z5kREw2VC4ZS/vVK687+
+ts5aS02R5bsdgdnFlaO4jJWIHVPzh1pI5NpMFX2lAsfsDMrMYv+loqhQX5Wfx47
HHxgI7Lq2iyjnIpBRCwHl/SJZqxwgrljiQKA1tmudqggmYW/lrYMH93/i3E4V5xn
h3z2k0KxDyB7Orq+h/J6FWbxNCLQVsqcnpjo+vLT/F+GCm511BME2/WOyTofSnla
MEHMydUizNwp+3qeEJpHHjxaDOPmL++SZCHRJpQ1slMMme1JAaa48VlIx3Wsbe4=
=wmkh
-----END PGP SIGNATURE-----

--=-1314782989-138439-18958-4287-1-=--
