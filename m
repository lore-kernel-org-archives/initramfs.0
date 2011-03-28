From: =?utf-8?q?Amadeusz_=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: [PATCH 6/9] 40network: install dhclient, brctl and ifenslave optionally
Date: Mon, 28 Mar 2011 11:40:32 +0200
Message-ID: <1301305103-sup-5234@ittemni>
References: <1301065012-16356-1-git-send-email-aidecoe@aidecoe.name> <1301065012-16356-2-git-send-email-aidecoe@aidecoe.name> <1301065012-16356-3-git-send-email-aidecoe@aidecoe.name> <1301065012-16356-4-git-send-email-aidecoe@aidecoe.name> <1301065012-16356-5-git-send-email-aidecoe@aidecoe.name> <1301065012-16356-6-git-send-email-aidecoe@aidecoe.name> <4D8CB520.60504@bfh.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-1301305232-742514-4827-829-2-="; protocol="application/pgp-signature"
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <4D8CB520.60504-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--=-1301305232-742514-4827-829-2-=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Excerpts from Seewer Philippe's message of Fri Mar 25 16:30:40 +0100 2011=
:
> I'll have to object to this, sorry. The current network implementation =

> does not check if these binaries are there and throws errors if ip=3Ddh=
cp =

> is provided and no dhclient is available.

dhclient was optional before. You suggest it should be made required,
yes?
-- =

Amadeusz =C5=BBo=C5=82nowski

PGP key fpr: C700 CEDE 0C18 212E 49DA  4653 F013 4531 E1DB FAB5

--=-1301305232-742514-4827-829-2-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJNkFeQAAoJEPATRTHh2/q1gXIH/RE4HcO/n+0AsR5WXNYztuR9
2rX6x93eHfavaydhCBIJflVyZhSGKEQUF9+ytMVaB96Wj6efSfm09crTUisr8sTV
jenfHjREhhG5Dn3xGRFWKSZGCTOmieoI/S2gxNU6uM87TlVGoyFe0ut6w+OKWqa1
//of8P1R8H8/oP9YKV3V8Zbcp0uryogulWfsZuQrZRgoEFvPNBdI8aAYKQCHq+7Q
Ghi5gmvInwshKAmXyA7HZfDdOKEVAGf448h5vxhcZdtiiSJod1p2UIbfuPtflD4U
iGTJMjY188TRWAMClwPDwBvrA2pfLjWxDnA5WZB/0EQiQERwQzICjeqxeSZ87a4=
=6/bj
-----END PGP SIGNATURE-----

--=-1301305232-742514-4827-829-2-=--
