From: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: dracut: automatically add "unix" kernel module
Date: Fri, 12 Aug 2011 09:58:35 +0200
Message-ID: <2596808.kGfioqbkmA@ernie>
References: <1824774.VrzXCv2fyA@ernie> <4E44C1B0.7050605@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1813486.XMdkf3yiFd"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E44C1B0.7050605-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--nextPart1813486.XMdkf3yiFd
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello!

Please CC me, since I am not on the list.

Am Freitag, 12. August 2011, 06:41:56 schrieb WANG Cong:
> On Fri, 12 Aug 2011 08:01:20 +0200, Harald Hoyer wrote:
> > On 12.08.2011 01:01, Dennis Schridde wrote:
> >> Dracut currently does not seem to automatically include the "unix"
> >> kernel module in the initramfs, which causes udev to be unable to start
> >> ("address family not supported by protocol").
> >
> > Just add a file /etc/modprobe.d/myaliases.conf to your system,
> > containing: alias net-pf-1 unix
> 
> The kernel already does the same thing:
> 
> MODULE_ALIAS_NETPROTO(PF_UNIX);
> 
> don't know why udev can't load it automatically...

The problem is that dracut does not automatically include the "unix" module in 
the initramfs it generates. If I include the module manually (via 
"add_drivers" in dracut.conf) it will be successfully loaded.

Does the kernel use a different aliases table than dracut?

Kind regards,
Dennis
--nextPart1813486.XMdkf3yiFd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEABECAAYFAk5E3S8ACgkQjqfyF1DtJW7lggCfbmHyKUOxzNL9nVrYwljFX60W
DE8AoLkbPDm5zjUGs4bIR2TBLtDf9Y5X
=hg5L
-----END PGP SIGNATURE-----

--nextPart1813486.XMdkf3yiFd--
