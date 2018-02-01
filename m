From: Taras Kondratiuk <takondra-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH] rootfs: force mounting rootfs as tmpfs
Date: Thu, 01 Feb 2018 14:41:26 -0800
Message-ID: <151752488608.10051.146219644323454814@takondra-t460s>
References: <1517348777.3469.5.camel@linux.vnet.ibm.com>
 <1814af5c-170d-39c0-58fd-02eb7216e008@landley.net>
 <1517436423.3469.237.camel@linux.vnet.ibm.com>
 <a538e55c-81ca-6d59-20cf-21b47387c3e2@landley.net>
 <20180201020331.GA3774@rani.riverdale>
 <1517458921.3329.2.camel@linux.vnet.ibm.com>
 <f9112881-772c-2568-ebfa-d2ca807124e9@landley.net>
 <1517500500.3974.45.camel@linux.vnet.ibm.com>
 <875e5d2d-9ffe-14ab-090a-4a9632af0f35@landley.net>
 <1517521912.3619.0.camel@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2358; q=dns/txt; s=iport;
  t=1517524887; x=1518734487;
  h=mime-version:content-transfer-encoding:to:from:
   in-reply-to:cc:references:message-id:subject:date;
  bh=MxMMwVRq3x/JkWA2B2H+aVEDZ0HVWnODRg8ZUbleYL0=;
  b=llwuRhHm65H1a538yUTv+2OHb65hGsQecwkpRIyMAGsWX9A8+XiCXL61
   v4YHBIFm86OaMC/GfPRhBgEc9IuBn807l9gnDuymWdNsimBPhghi139Vb
   HMtmURgn1F369UnQPIkcp6Iq80JRRte2YSusvy7mXNEENFkCEsRfcBGWo
   g=;
In-Reply-To: <1517521912.3619.0.camel-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Arvind Sankar <nivedita-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>, Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Victor Kamensky <kamensky-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, linux-security-module <linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-3bDd1+5oDREiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Quoting Mimi Zohar (2018-02-01 13:51:52)
> On Thu, 2018-02-01 at 11:09 -0600, Rob Landley wrote:
> > On 02/01/2018 09:55 AM, Mimi Zohar wrote:
> > > On Thu, 2018-02-01 at 09:20 -0600, Rob Landley wrote:
> > > =

> > >>> With your patch and specifying "root=3Dtmpfs", dracut is complainin=
g:
> > >>>
> > >>> dracut: FATAL: Don't know how to handle 'root=3Dtmpfs'
> > >>> dracut: refusing to continue
> > >>
> > >> [googles]... I do not understand why this package exists.
> > >>
> > >> If you're switching to another root filesystem, using a tool that
> > >> wikipedia[citation needed] says has no purpose but to switch to anot=
her
> > >> root filesystem, (so let's reproduce the kernel infrastructure in
> > >> userspace while leaving it the kernel too)... why do you need initra=
mfs
> > >> to be tmpfs? You're using it for half a second, then discarding it,
> > >> what's the point of it being tmpfs?
> > > =

> > > Unlike the kernel image which is signed by the distros, the initramfs
> > > doesn't come signed, because it is built on the target system. =C2=A0=
Even
> > > if the initramfs did come signed, it is beneficial to measure and
> > > appraise the individual files in the initramfs.
> > =

> > You can still shoot yourself in the foot with tmpfs. People mount a /run
> > and a /tmp and then as a normal user you can go
> > https://twitter.com/landley/status/959103235305951233 and maybe the
> > default should be a little more clever there...
> > =

> > I'll throw it on the todo heap. :)
> > =

> > >> Sigh. If people are ok with having rootfs just be tmpfs whenever tmp=
fs
> > >> is configured in, even when you're then going to overmount it with
> > >> something else like you're doing, let's just _remove_ the test. If it
> > >> can be tmpfs, have it be tmpfs.
> > > =

> > > Very much appreciated!
> > =

> > Not yet tested, but something like the attached? (Sorry for the
> > half-finished doc changes in there, I'm at work and have a 5 minute
> > break. I can test properly this evening if you don't get to it...)
> =

> Yes, rootfs is being mounted as tmpfs.

I don't think you can unconditionally replace ramfs with initramfs by
default. Their behavior is different in some cases (e.g. pivot_root vs
switch_root) and it can break many systems that expect ramfs by default.
