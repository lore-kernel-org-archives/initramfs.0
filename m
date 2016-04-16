From: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Subject: Re: [PATCH] dracut: add support for updating the CPU microcode
Date: Sat, 16 Apr 2016 23:05:53 +0200
Message-ID: <1460840753.3201.24.camel@trentalancia.net>
References: <1460762332.3054.2.camel@trentalancia.net>
	 <5711D522.3090907@gmail.com> <1460814862.4296.4.camel@trentalancia.net>
	 <5712582A.2090502@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5712582A.2090502-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: "Alexander E. Patrakov" <patrakov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sat, 2016-04-16 at 20:20 +0500, Alexander E. Patrakov wrote:
> 16.04.2016 18:54, Guido Trentalancia =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Hello Andrei,
> >=20
> > thanks for getting back on this...
> >=20
> > On Sat, 16/04/2016 at 09.01 +0300, Andrei Borzenkov wrote:
> > > 16.04.2016 02:18, Guido Trentalancia =D0=BF=D0=B8=D1=88=D0=B5=D1=82=
:
> > > > This is the initial version of a new "microcode" dracut module
> > > > that can be used to update the microcode on Intel(R) CPUs.
> > > >=20
> > >=20
> > > ??? dracut already supports early microcode loading, why it is
> > > not
> > > enough and what problem this patch solves?
> >=20
> > To be honest, I didn't notice it. I was expecting such support, if
> > available, to be a module and I couldn't find it, so I wrote it.
> >=20
> > However, I have noticed it is much simpler than the actual
> > implementation. It doesn't differentiate between Intel and AMD (why
> > it
> > should ?), it just loads the microcode in the standard location as
> > defined by the microcode update utility.
>=20
> The microcode update utility stopped working when a Haswell
> microcode=C2=A0
> update got released that makes some CPU instructions illegal
> (because=C2=A0
> they didn't work properly in the first place). Please see=C2=A0
> http://bugs.debian.org/762195
>=20
> Sure, glibc no longer uses these instructions, but now (exactly to
> avoid=C2=A0
> repetition of this bug) the only supported way to update the
> microcode=C2=A0
> is to place it in the initcpio so that "early microcode update" in
> the=C2=A0
> kernel loader notices it.

If glibc has been fixed to avoid using those instructions, then I
suppose no initramfs process will crash, independently of whether the
microcode is loaded earlier or not.

However, if the support already exist, it is working well, is stable
and doesn't require a lot of maintenance, I do not want to insist on
adding a new module, although it's easier to use and avoids complexity.

Regards,

Guido
