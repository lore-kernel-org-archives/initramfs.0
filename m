From: =?utf-8?q?Amadeusz_=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: [PATCH] dracut-logger: logging facility module for build- and boot-time
Date: Mon, 14 Mar 2011 02:08:06 +0100
Message-ID: <1300064747-sup-6148@ittemni>
References: <1300064403-23298-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-1300064886-799138-9101-6465-3-="; protocol="application/pgp-signature"
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1300064403-23298-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--=-1300064886-799138-9101-6465-3-=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Excerpts from Amadeusz =C5=BBo=C5=82nowski's message of Mon Mar 14 02:00:=
03 +0100 2011:
> It's dash compatible to be used also at boot-time. For now it's include=
d
> by dracut-functions and replaces functions: dinfo(), dwarning() and
> derror(). New options are introduced: -L|--stdlog, and -q|--quiet to
> control stderr verbosity. Logging to file or syslog may be controlled b=
y
> options set in config file.
> =

> Note that code is not adjusted to the meaning of the new logging
> functions, yet.
> =

> Doxygen formatted documentation (as a proposal, by the way) is included=

> in dracut-logger.

I've missed few files to include in commit, next e-mail includes proper
patch. Sorry for mess.
-- =

Amadeusz =C5=BBo=C5=82nowski

PGP key fpr: C700 CEDE 0C18 212E 49DA  4653 F013 4531 E1DB FAB5

--=-1300064886-799138-9101-6465-3-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJNfWp2AAoJEPATRTHh2/q1oHUIAJYxExIYTF6N2JeWdLN+/IK1
0FizpKmiq1wNwJsH9PQ8xRwrM+t1/riJF3vYvqDeOzbYcaJ5m0IEhlg0vLsWHWui
1M2kcwnkUIDv5pu7n0c0GGHYKaF5YFO22mIe2UuJnmENIH5Yr1MrghPiOI9l45vg
MzcRIINX5qZ59BatVsoiJl7Z+pNb6QdeaIPrcENOEPM3Kc2RZSHPJA/imWFGSjCd
1DP8wakLEo+wlgp3bW9yUzX9tEjfQ0WUrWY4S3DJUWSnrjEeHOxrLvfGHBPWe/cr
0cBsgcHiQukFr13MTzBh8aQitLckpLJOCZx2GTuL0cwIZ8Gj4Nn+CGYprNFgHQE=
=1ywJ
-----END PGP SIGNATURE-----

--=-1300064886-799138-9101-6465-3-=--
