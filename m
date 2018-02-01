From: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC PATCH] rootfs: force mounting rootfs as tmpfs
Date: Thu, 01 Feb 2018 16:51:52 -0500
Message-ID: <1517521912.3619.0.camel@linux.vnet.ibm.com>
References: <1517348777.3469.5.camel@linux.vnet.ibm.com>
         <1814af5c-170d-39c0-58fd-02eb7216e008@landley.net>
         <1517436423.3469.237.camel@linux.vnet.ibm.com>
         <a538e55c-81ca-6d59-20cf-21b47387c3e2@landley.net>
         <20180201020331.GA3774@rani.riverdale>
         <1517458921.3329.2.camel@linux.vnet.ibm.com>
         <f9112881-772c-2568-ebfa-d2ca807124e9@landley.net>
         <1517500500.3974.45.camel@linux.vnet.ibm.com>
         <875e5d2d-9ffe-14ab-090a-4a9632af0f35@landley.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <875e5d2d-9ffe-14ab-090a-4a9632af0f35-VoJi6FS/r0vR7s880joybQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Arvind Sankar <nivedita-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Taras Kondratiuk <takondra-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, Victor Kamensky <kamensky-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, linux-security-module <linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-3bDd1+5oDREiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, 2018-02-01 at 11:09 -0600, Rob Landley wrote:
> On 02/01/2018 09:55 AM, Mimi Zohar wrote:
> > On Thu, 2018-02-01 at 09:20 -0600, Rob Landley wrote:
> >=20
> >>> With your patch and specifying "root=3Dtmpfs", dracut is complaining:
> >>>
> >>> dracut: FATAL: Don't know how to handle 'root=3Dtmpfs'
> >>> dracut: refusing to continue
> >>
> >> [googles]... I do not understand why this package exists.
> >>
> >> If you're switching to another root filesystem, using a tool that
> >> wikipedia[citation needed] says has no purpose but to switch to another
> >> root filesystem, (so let's reproduce the kernel infrastructure in
> >> userspace while leaving it the kernel too)... why do you need initramfs
> >> to be tmpfs? You're using it for half a second, then discarding it,
> >> what's the point of it being tmpfs?
> >=20
> > Unlike the kernel image which is signed by the distros, the initramfs
> > doesn't come signed, because it is built on the target system. =C2=A0Ev=
en
> > if the initramfs did come signed, it is beneficial to measure and
> > appraise the individual files in the initramfs.
>=20
> You can still shoot yourself in the foot with tmpfs. People mount a /run
> and a /tmp and then as a normal user you can go
> https://twitter.com/landley/status/959103235305951233 and maybe the
> default should be a little more clever there...
>=20
> I'll throw it on the todo heap. :)
>=20
> >> Sigh. If people are ok with having rootfs just be tmpfs whenever tmpfs
> >> is configured in, even when you're then going to overmount it with
> >> something else like you're doing, let's just _remove_ the test. If it
> >> can be tmpfs, have it be tmpfs.
> >=20
> > Very much appreciated!
>=20
> Not yet tested, but something like the attached? (Sorry for the
> half-finished doc changes in there, I'm at work and have a 5 minute
> break. I can test properly this evening if you don't get to it...)

Yes, rootfs is being mounted as tmpfs.

Mimi
