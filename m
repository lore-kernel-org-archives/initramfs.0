From: Thadeu Lima de Souza Cascardo <cascardo-DmMZpsCg3uxeGPcbtGPokg@public.gmane.org>
Subject: Re: Current status of dracut.
Date: Mon, 2 Feb 2009 15:26:33 -0200
Message-ID: <20090202172633.GS3643@vespa.holoscopio.com>
References: <20090202163708.GA27474@redhat.com> <20090202165736.GB29131@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090202165736.GB29131-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 02, 2009 at 11:57:36AM -0500, Dave Jones wrote:
> * NetworkManager vs dhclient for network based roots.
>   I think the latter makes more sense, otherwise we end up
>   sucking hal and all its dependancies into the image too.
>   When the real rootfs starts up NM it should be able to dtrt.

Any reason why not to use kernel level autoconfiguration?

> 	Dave

Regards,
Cascardo.

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmHLMkACgkQyTpryRcqtS0zBwCggcEVXZNNwmFQ2512TB11WjBJ
cEAAn0aIUZvjHdvcOkhnARAfG0cKmZkL
=ZTV7
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
