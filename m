From: Taras Kondratiuk <takondra-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 01/15] Documentation: add newcx initramfs format description
Date: Thu, 25 Jan 2018 12:26:45 -0800
Message-ID: <151691200536.5378.11544479301138437367@takondra-t460s>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
 <1516850875-25066-2-git-send-email-takondra@cisco.com>
 <CAK8P3a2FqEcq44-sRQrsgJ=_DOanC-qgJ3yFr=J6UrOKO0_3uw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2259; q=dns/txt; s=iport;
  t=1516912010; x=1518121610;
  h=mime-version:content-transfer-encoding:to:from:
   in-reply-to:cc:references:message-id:subject:date;
  bh=26SXFoo7dqnXv4bmUCbGLpmwbMK9MeujDTDVLx2rX2w=;
  b=md3xigowwJBYiCLU18ZKTC4lPaMbEckDpN1zx8OHX6xpsPuqxw+pjtjx
   JDsXMcR8J+NRj3KFdwpygdqvlBEpJykjoIP8Ts6jFso28nwZdo1QNqh6C
   cNyHB0TddDvOTQBUNxLfiTnMWwgMRdTJm96fEvwLg7FskLVh57MZ+JYLY
   c=;
In-Reply-To: <CAK8P3a2FqEcq44-sRQrsgJ=_DOanC-qgJ3yFr=J6UrOKO0_3uw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, James McMechan <james.w.mcmechan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Victor Kamensky <kamensky-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LSM List <linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, xe-linux-external-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org

Quoting Arnd Bergmann (2018-01-25 01:29:12)
> On Thu, Jan 25, 2018 at 4:27 AM, Taras Kondratiuk <takondra-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org> wr=
ote:
> > Many of the Linux security/integrity features are dependent on file
> > metadata, stored as extended attributes (xattrs), for making decisions.
> > These features need to be initialized during initcall and enabled as
> > early as possible for complete security coverage.
> >
> > Initramfs (tmpfs) supports xattrs, but newc CPIO archive format does not
> > support including them into the archive.
> >
> > This patch describes "extended" newc format (newcx) that is based on
> > newc and has following changes:
> > - extended attributes support
> > - increased size of filesize to support files >4GB.
> > - increased mtime field size to have usec precision and more than
> >   32-bit of seconds.
> > - removed unused checksum field.
> >
> > Signed-off-by: Taras Kondratiuk <takondra-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
> > Signed-off-by: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
> > Signed-off-by: Victor Kamensky <kamensky-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
> =

> Ah nice, I like the extension of the time handling, that certainly
> addresses one of the issues with y2038 that we have previously
> hacked around in an ugly way (interpreting the 32-bit
> number as unsigned).
> =

> However, if this is to become a generally supported format
> for cpio files, could we make it use nanosecond resolution
> instead? The issue that I see with microseconds is that
> storing a file in an archive and extracting it again would
> otherwise keep the mtime stamp /almost/ identical on file
> systems that have nanosecond resolution, but most of
> the time a comparison would indicate that the files are
> not the same.
> =

> Unfortunately, the range of a 64-bit nanoseconds counter
> is still a bit limited (584 years, or half of that if we make it
> signed). While this is clearly enough for the uses in
> initramfs, it still has a similar problem: someone creating
> a fake timestamp a long time in the past or future on
> a file system would lose information after going though
> cpio.

We can match statx(2) by having 64 bits for seconds plus 32 bits for
nanoseconds. For initramfs nanoseconds field can be ignored during
unpacking.
