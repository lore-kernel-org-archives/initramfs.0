From: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: [PATCH] [40network] Fix ifup.sh to always execute initqueue/online hook after bringing up an interface
Date: Fri, 17 May 2013 18:13:57 +0200
Message-ID: <1992756.u6R4HOtcTb@ernie>
References: <1365694894-7926-1-git-send-email-devurandom@gmx.net> <1888619.XKMYbluzRY@ernie> <1367349915.2614.5.camel@metroid.usersys.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5078634.4HubVGaa3T"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1367349915.2614.5.camel-s6BhOCdKmxS3M6m420IelR/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--nextPart5078634.4HubVGaa3T
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello!

Am Dienstag, 30. April 2013, 15:25:15 schrieb Will Woods:
> On Thu, 2013-04-11 at 18:13 +0200, Dennis Schridde wrote:
> > Am Donnerstag, 11. April 2013, 17:44:08 schrieb Harald Hoyer:
> > > IIRC, that is done, as soon as the dhcp client gets an IP
> 
> Technically it doesn't happen *immediately* - it adds a job to the
> initqueue, and that job will run the initqueue/online hook.
> 
> > These patches are already a few months old, so dracut's behaviour may very
> > well have changed in the meantime. Where does what you describe happen?
> 
> See 40network/dhclient-script.sh - when $reason is BOUND (i.e. initial
> binding to a new address, as per dhclient-script(8)), it adds a job
> named "setup_net_$netif.sh" to the initqueue.

Thanks for that information!

I removed the patch and discovered some bugs and misconceptions about the 
inner workings of dracut in my own code. It works now without the patch.

Best regards,
Dennis
--nextPart5078634.4HubVGaa3T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iEYEABECAAYFAlGWV0kACgkQjqfyF1DtJW591ACeKpHO17j3PmeEkxZt3pKuSuK8
eywAoKhvIZHsd1Gr/Eszkb7Vsz4xTTEN
=XreF
-----END PGP SIGNATURE-----

--nextPart5078634.4HubVGaa3T--
