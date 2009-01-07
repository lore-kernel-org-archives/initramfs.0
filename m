From: Hannes Reinecke <hare@suse.de>
Subject: Re: Dracut -- Cross distribution initramfs infrastructure
Date: Wed, 07 Jan 2009 17:04:50 +0100
Message-ID: <4964D2A2.2010109@suse.de>
References: <1229540094.28858.150.camel@aglarond.local> <20081217190700.GA15377@infradead.org> <4949FD67.6040906@suse.de> <494B5031.5080306@bfh.ch> <20081219091841.207bc951@kopernikus.site> <494BA7CE.2020007@suse.de> <20081219152708.GE9871@mit.edu> <9C4F1B7D-CCBC-48D7-8624-9A7C314C1590@redhat.com> <87skojrm5e.fsf@rimspace.net> <20081220182254.GA2996@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759850AbZAGQFH@vger.kernel.org>
In-Reply-To: <20081220182254.GA2996@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Dave Jones <davej@redhat.com>, Daniel Pittman <daniel@rimspace.net>, Jeremy Katz <katzj@redhat.com>, Theodore Tso <tytso@mit.edu>, initramfs@vger.kernel.org, linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Sun, Dec 21, 2008 at 12:50:21AM +1100, Daniel Pittman wrote:
>=20
>  > One of the features of the Debian / Ubuntu initramfs infrastructur=
e,
>  > which sounds remarkably like your design (or vice-versa), is that =
it
>  > drops all the "standard" drivers into the initramfs.
>  >=20
>  > This is, to me, worth several minutes of additional boot time, in =
terms
>  > of flexibility: being able to modify the hardware and be confident=
 that
>  > the appropriate drivers are in place already makes life much, much
>  > easier.
>=20
> There's another reason this is really useful.
> If something goes wrong, remotely debugging a users initrd right is
> a lot easier if you know what it looks like.  Right now, in Fedora fo=
r eg,
> where we generate an initrd for each users system at runtime, we need
> to get a copy of the generated initrd, and pull it apart just to find
> out what modules ended up in there, what didn't, and then somehow
> try to work backwards to try and figure out how the generator got int=
o
> that state.  After doing this for five years, let me tell you it's
> _really_ _really_ painful.
>=20
Whom do you tell.

I ended up on adding lots of shell escapes; everytime something goes
wrong you'll be dropped into a shell, which will resume execution
of the initrd once exited.
Quite handy for fixing up most things.

>  > (In practice I doubt this adds more than a second or five to boot =
time;
>  >  certainly, it takes no longer to get to rootfs mounted than the R=
HEL 4
>  >  systems that have nothing but what is essential in the initrd...)
>=20
> At least in theory, with a kernel-event/udev driven system, the addit=
ional
> modules shouldn't cause any additional boot time. There wouldn't be
> events generated to cause them to be loaded, so they'd just be taking
> up space.  And the additional load time for a bigger initrd should be
> really lost in the noise of the overall boot.
>=20
One can but hope. You certainly will notice a load time increase if the=
 size
of the initrd increases by orders of magnitude.
Plus kdump / kexec will need to be configured to have more memory avail=
able.

Actually, I do like the callout idea:
Have the initrd configure a 'standard' system, and add some API which w=
ill
allow you to hook in additional scripts / services / whatever to config=
ure
non-standard systems.
Which then can be distributed by the individual packages / vendors.
And then we would have a small common initramfs which well could be inc=
luded
with the kernel sources.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Markus Rex, HRB 16746 (AG N=FCrnberg)
