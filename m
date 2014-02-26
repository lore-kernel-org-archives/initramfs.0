From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: Re: [PATCH] dracut.sh: add legacy flag (-l) to lz4
Date: Wed, 26 Feb 2014 15:43:25 +0400
Message-ID: <20140226154325.4aeea7eb@work.puleglot>
References: <E1WIbkL-0000mN-Ao@secretive.ru>
	<0067BAB6-F3BF-4831-940E-3C0D1F1F17DD@dominion.thruhere.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date; bh=wEiaqo4ICDNdp9tpmPqP59rshfguXuL4u/6JKlLSF2Q=;
	b=DW25rM3bIMlAmK7kxLew7pkiyna66j5wxXgBqognlS4y+I79zP/mFy78At3sUlZ4ptYtSPgzmniibtwTfxdnkdus+HAaqvyib6IipUANoTuK7T0BqwdZv6vBSfR2jHwD8Vs07hlzemu4taoU832KewKtu+M4DD2CNaT926E837w=;
In-Reply-To: <0067BAB6-F3BF-4831-940E-3C0D1F1F17DD-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="koi8-r"
To: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

=F7 Wed, 26 Feb 2014 12:12:30 +0100
Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org> =D0=C9=DB=C5=D4:

>=20
> Op 26 feb. 2014, om 11:20 heeft Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org> he=
t volgende geschreven:
>=20
> > Linux kernel does not support the new default lz4 format.
> >=20
> > https://bugs.gentoo.org/show_bug.cgi?id=3D502102
> > ---
> > dracut.sh | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/dracut.sh b/dracut.sh
> > index 5267af5..49077fd 100755
> > --- a/dracut.sh
> > +++ b/dracut.sh
> > @@ -782,7 +782,7 @@ case $compress in
> >     xz)    compress=3D"xz --check=3Dcrc32 --lzma2=3Ddict=3D1MiB -T0=
";;
> >     gzip)  compress=3D"gzip -9"; command -v pigz > /dev/null 2>&1 &=
& compress=3D"pigz -9";;
> >     lzo)   compress=3D"lzop -9";;
> > -    lz4)   compress=3D"lz4 -9";;
> > +    lz4)   compress=3D"lz4 -l -9";;
>=20
> Does the magic number need updating as well?

Yes, thanks! I'll fix this in v2.

>=20
> regards,
>=20
> Koen

--=20
Alexander Tsoy
