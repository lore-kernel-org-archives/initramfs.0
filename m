From: Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Subject: Re: Tainting the initrd
Date: Thu, 19 Feb 2009 18:52:34 +0530
Message-ID: <200902191852.36935.rrs@researchut.com>
References: <t7sv66-dk4.ln1@news.researchut.com> <20090219123549.GL3901@baikonur.stro.at>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1432540.ayU61aa8P8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090219123549.GL3901-P4at2qFsAtP5lb2fJPEjcQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--nextPart1432540.ayU61aa8P8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 19 Feb 2009 18:05:49 maximilian attems wrote:
> On Thu, Feb 19, 2009 at 04:56:20PM +0530, Ritesh Raj Sarraf wrote:
> > Hi,
> >
> > I hope it is not too late to discuss this problem.
> > I have a bugzilla filed for this, filed here:
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D435033
>
> you seem to also have filed
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D514370
>

Sorry, yes. I filed that recently. And this applies to Debian also. I'd lov=
e to=20
see if this could be fixed in Debian also.

> > We see a lot of problems in the SAN space, where users end up shuffling
> > among 2 versions of HBA drivers. One from the OS Vendor, the other from
> > the HBA vendor. And then we see IHVs and ISVs using their own set of
> > utils to tamper the initrd. This is just an example.
>
> loading external modules that do s..t is easy to detect,
> there is the tainting flag for that.
>
Oh! Yes. The kernels shipped by vendors do taint the kernel when an=20
unsupported (even a GPL module) module is loaded. So this taint status will=
 be=20
able to solve half of the problem that I've put here.

The other problems would be things like booting itself.
The initrd has an important job of, for example:
* Setting up iscsi and logging into the targets
* Setting up multipath and creating the multipathed iscsi devices.
* Mounting and booting with them.

These are important part of the OS and when something fails during initrd, =
it=20
becomes very difficult to identify as to what really is the culprit there.

In the bugzilla, I put an option about SE Linux MAC restrictions using some=
=20
policy. But that might not be the right approach to solving the problem. Al=
so=20
root runs unconfined, both under Fedora and Debian. So from root, the initr=
d is=20
still vulnerable to tampering.

One weired way.
We make the initrd creation/updation utilities only callable through the po=
st-
inst of the kernel package. The initrd utils ensure that they are only call=
ed=20
from a signed and pristine kernel package from the OS vendor. This way, we=
=20
_might_ get an initrd image that the OS Vendor wants to see on the users bo=
x.

But anyway, this approach is just stupid:
* I myself would like to be able to update initrd images in cases where=20
something went bad. update-initrd kind utils are very helpful there.
* But yes, from a support point, it might make sense. RH, for example, will=
=20
not support bugs against packages that have been tampered. That includes=20
recompiled packages with different configurations and optimizations.

Ritesh
=2D-=20
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."


--nextPart1432540.ayU61aa8P8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmdXRwACgkQ4Rhi6gTxMLy0ngCfZQA6xEGT+SVmSNlnq1d4hUDS
TnUAoK+gTBWeqkiJXBTh41AXZIIpjBtB
=xVen
-----END PGP SIGNATURE-----

--nextPart1432540.ayU61aa8P8--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
