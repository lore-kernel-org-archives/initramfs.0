From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Thoughts on mounting the rootfs from a udev rule
Date: Fri, 20 Mar 2009 09:31:40 +0100
Message-ID: <49C3546C.8050505@suse.de>
References: <1237496785.5070.28.camel@sentry-no.fnordovax.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1237496785.5070.28.camel-76q0VzFBGGr21HsLBtNmTckMGDeJXHgy@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Victor Lowther wrote:
> It seems that there are two major use cases that make mounting the ro=
ot
> file system directly from a udev rule an inadvisable design decision:
>=20
> The first is when your root filesystem does not reside on a block
> device, as in the nfsroot case.  In this case, there is no backing
> device for the filesystem for udev to detect, so we would still need =
a
> non-udev method of mounting the root filesystem in order to handle an=
y
> case where there is no backing device for the root filesystem.
>=20
Hmm. There is no strict _need_ for a backing device for udev to work
properly, we just need an event here.
So for the nfsroot case it would be totally sufficient to have an event
like 'network is up'. This could then trigger a nfsmount

> The second is when we are asked to resume from hibernate.  In this ca=
se,
> we must not attempt to mount the root filesystem (or any other
> filesystem, for that matter) until we have either attempted to resume
> (and failed) or we have determined that resuming is impossible.  Udev
> does not make any guarantees about the order in which devices are
> discovered, which leads to all sorts of interesting potential failure
> modes when you have either or both of resume handling and rootfs
> handling in a udev rule.
>=20
Ah, that's ok. In these cases you'll have a 'resume=3D' argument in
the kernel commandline, so you just need to write a rule using an
event serializer/capture like 'collect':
- Use three arguments to collect, root device, resume device, and
  another one signifying 'resume_done'.
- Add another rule which triggers resume on the resume device, sets
  'resume_done' if resume returns, and triggers the collect rule again.
- Then collect will return 1 and start the mount process.

No problem there. However, you're still facing the problem that you'd
might want to run 'fsck' on the root device. And you might want to
know when 'mount' has actually finished, as only then you can execute
'init'. Sadly the 'mount' events are gone from the kernel, otherwise
it would've been quite handy here.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare-l3A5Bk7waGM@public.gmane.org			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Markus Rex, HRB 16746 (AG N=FCrnberg)
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
