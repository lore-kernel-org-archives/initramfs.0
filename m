From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: Re: [PATCH] Take into account lib64 dirs when detecting version,
 modules and params
Date: Mon, 12 Jan 2015 09:25:10 +0300
Message-ID: <20150112092510.4f1c3928@home.puleglot>
References: <1420985530-5006-1-git-send-email-aidecoe@aidecoe.name>
	<20150111172029.0653ffce@opensuse.site>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=mymail;
	h=Sender:Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date; bh=Iku6GBdesymtKfQ0U6pR8HE3MnkHOgTnlr0eCWpucAQ=;
	b=WFpr+dFIEw0DDfRdQguVH54PSJ0hQ6o1hNRSlDPnsBCf/nyLbThlWtGjcXK8CM2pUch3r7ecy5A6D2RXZW3QCXjgYwcgmrGqfhISiQ7mGtmGp7b7Mnzev7/NfLJZnUNnT2Tl5wN7a7j4d1raBsHbYaMH2t9pz7oq6Z4FXzzqOTY=;
In-Reply-To: <20150111172029.0653ffce-stAJ6ESoqRzYCGPCin2YbQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

=D0=92 Sun, 11 Jan 2015 17:20:29 +0300
Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> =D0=92 Sun, 11 Jan 2015 15:12:10 +0100
> Amadeusz =C5=BBo=C5=82nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org> =D0=BF=D0=B8=D1=88=
=D0=B5=D1=82:
>=20
> > ---
> >  lsinitrd.sh | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/lsinitrd.sh b/lsinitrd.sh
> > index 4f12c2c..dc1f88f 100755
> > --- a/lsinitrd.sh
> > +++ b/lsinitrd.sh
> > @@ -124,7 +124,7 @@ extract_files()
> >  list_modules()
> >  {
> >      echo "dracut modules:"
> > -    $CAT "$image" | cpio --extract --verbose --quiet --to-stdout
> > -- 'lib/dracut/modules.txt' 'usr/lib/dracut/modules.txt' 2>/dev/nul=
l
> > +    $CAT "$image" | cpio --extract --verbose --quiet --to-stdout
> > -- 'lib64/dracut/modules.txt' 'lib/dracut/modules.txt'
> > 'usr/lib/dracut/modules.txt' 2>/dev/null
>=20
> How it can become lib64? Name is really hardcoded
>=20
> ./dracut.sh:    printf "%s\n" "$i" >> $initdir/lib/dracut/modules.txt

In Gentoo we have a crazy default layout (only true for amd64 and
ppc64 and it is going to be fixed [1]) with the following symlinks:
/lib -> lib64
/usr/lib -> lib64

Obviously cpio cannot follow symlinks inside archives.

[1] https://bugs.gentoo.org/show_bug.cgi?id=3D506276

>=20
>=20
> >      ((ret+=3D$?))
> >  }
> > =20
> > @@ -217,7 +217,7 @@ ret=3D0
> >  if (( ${#filenames[@]} > 0 )); then
> >      extract_files
> >  else
> > -    version=3D$($CAT "$image" | cpio --extract --verbose --quiet
> > --to-stdout -- 'lib/dracut/dracut-*' 'usr/lib/dracut/dracut-*'
> > 2>/dev/null)
> > +    version=3D$($CAT "$image" | cpio --extract --verbose --quiet
> > --to-stdout -- 'lib64/dracut/dracut-*' 'lib/dracut/dracut-*'
> > 'usr/lib/dracut/dracut-*' 2>/dev/null)
>=20
> Can it really be lib64 here?
>=20
> >      ((ret+=3D$?))
> >      echo "Version: $version"
> >      echo
> > @@ -226,7 +226,7 @@ else
> >          echo
> > "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D"
> > else echo -n "Arguments: "
> > -        $CAT "$image" | cpio --extract --verbose --quiet
> > --to-stdout -- 'lib/dracut/build-parameter.txt'
> > 'usr/lib/dracut/build-parameter.txt' 2>/dev/null
> > +        $CAT "$image" | cpio --extract --verbose --quiet
> > --to-stdout -- 'lib64/dracut/build-parameter.txt'
> > 'lib/dracut/build-parameter.txt'
> > 'usr/lib/dracut/build-parameter.txt' 2>/dev/null
>=20
> Ditto.
>=20
> >          echo
> >          list_modules
> >          list_files
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs"
> in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Alexander Tsoy
