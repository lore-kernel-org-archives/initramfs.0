From: =?utf-8?q?Amadeusz_=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: [PATCH] 90crypt: keys on external devices support
Date: Fri, 22 Oct 2010 19:07:30 +0200
Message-ID: <1287766357-sup-2600@etiriah>
References: <4CBDA328.40401@googlemail.com> <1287497223-sup-3606@etiriah> <4CBDAC3D.7050906@googlemail.com> <1287580112-sup-97@etiriah> <4CBEF768.90908@googlemail.com> <1287583979-sup-416@etiriah> <4CBF0133.2070709@googlemail.com> <1287587924-sup-2572@etiriah> <4CC17A87.7050804@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256"; boundary="=-1287767250-720566-16039-6659-5-="; protocol="application/pgp-signature"
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <4CC17A87.7050804-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--=-1287767250-720566-16039-6659-5-=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Excerpts from Mr Dash Four's message of Fri Oct 22 13:50:32 +0200 2010:
> >> I am using dracut-006 (I think - the last which comes out of FC13 =

> >> repository) and currently I have to specify rd_LUKS_UUID=3Dluks-<UUI=
D> in =

> >> order to make it work, which is not very convenient.
> >>     =

> >
> > Much have changed in dracut-007, a bit changed in git repo, and more
> > will change soon, so track and use git/repo. :-)  You might be
> > interested in my current work <http://github.com/aidecoe/dracut> wher=
e
> > things go first before reaching Harald's official Dracut repo:
> >
> >   git://dracut.git.sourceforge.net/gitroot/dracut/dracut
> >   =

> It turns out that I am actually on dracut-005-3.fc13.noarch =

> (dracut-tools-005-3.fc13.noarch), which is even worse - that is the =

> 'latest' version which comes out of FC13 repositories.

Switch to git version.  Don't be afraid.  It's quite stable. :-)


> I've spend a bit of time looking through the various files dracut =

> uses/generates and have a query: there is a group of scripts in the =

> 50plymouth directory which also deals with encrypted partitions, so =

> which one takes precedence (I presume plymouth as it has a lower number=
, =

> is that right?)? If I modify/enhance the scripts in 90crypt would that =

> be futile as plymouth will already be done with it?

This was a problem.  It was solved by  Matt Smith some time ago, but
after 007 release, so again=E2=80=A6 see git version. :-)


> One other alternative is to build a stripped-down version of the tool I=
 =

> need, which implements just a single function: reads a specified token =

> from the smartcard (log in, specifying the card PIN, if necessary), =

> display it on the console and exit. This way, some/most of the =

> dependencies which currently exist may not be needed and installation =

> can proceed. I've posted on the dev forum to see if this can be done, s=
o =

> fingers crossed!

Maybe there's already such simplified tool?
--
Amadeusz =C5=BBo=C5=82nowski

PGP key fpr: C700 CEDE 0C18 212E 49DA  4653 F013 4531 E1DB FAB5

--=-1287767250-720566-16039-6659-5-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQEcBAEBCAAGBQJMwcTSAAoJEPATRTHh2/q1NTAH/2mbTpwpxvqnDdts0tzeDO8h
eQQS6gb1b4gMM4xxDr3zu/biiNMOTmZUGXECQfSX5g4b5XM3GnfhunzFvpBS6NKW
zGkt23QJodnl+a061X8N2SCfmcnLT7RThOA5WVxUikynsUCZFOpL2N+hWEItn+6G
qemch312kSJ8g1JQuBsDa2n88MYzZUHMYwsMVkweyh6SQTDwazfAY6AjiszVb/Lv
On4Cwlvl67+nTemZLuHUSRj7WoiQ3w+D10AhplwfJWRpFRtyvD890tK7U/UWYW37
aMSy1R8GWFCbIf4+gkCkkRs5XSDyh7Yr7Tu4qqCC5StNASjoZ250CLZelu0Ma3Y=
=8iFi
-----END PGP SIGNATURE-----

--=-1287767250-720566-16039-6659-5-=--
