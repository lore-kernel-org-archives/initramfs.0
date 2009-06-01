From: Sergey Vlasov <vsu-u2l5PoMzF/Uox3rIn2DAYQ@public.gmane.org>
Subject: Re: [RFC PATCH 4/9] cmdline: cleanup handling and block: handler
Date: Mon, 1 Jun 2009 16:59:08 +0400
Message-ID: <20090601125908.GB4160@newmaster.mivlgu.local>
References: <cover.1243833882.git.dave@thedillows.org> <d15c7a1ab71af9ab4fccd51fa02915e949f39c86.1243833882.git.dave@thedillows.org> <1243848391.647.13.camel@sentry-no.fnordovax.org> <1243853668.3844.117.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1243853668.3844.117.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 01, 2009 at 06:54:28AM -0400, David Dillow wrote:
> vim on F10 has different rules for sh and bash -- things like $() and
> ${t%%:*} are lit in red for sh, but they are valid; they don't highlight
> that way if vim sees #!/bin/bash

Add "let g:is_posix = 1" to your .vimrc (see :help ft-sh-syntax for
other possible settings).

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFKI9CcW82GfkQfsqIRAlhUAKCQ+owkIjP3Sx1EBCGHYN/aCb46YwCfV2Fu
0r/261Bm56H+0a4D3fte8Tw=
=JUWX
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
