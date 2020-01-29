From: Michael Stapelberg <michael+lkml-Ocq5V1Lzw0iVILNE37Xk8A@public.gmane.org>
Subject: Re: distri: 20x faster initramfs (initrd) from scratch
Date: Wed, 29 Jan 2020 13:59:24 +0100
Message-ID: <CANnVG6nrehtmu9xdiR2eTdUsyEwO-43eP-DD9Fv=Wum49T5fbA@mail.gmail.com>
References: <CANnVG6nFsnvva+qoQHJF+YY6Y3q46-C6tA742fMAkZFB3QFubg@mail.gmail.com>
 <7212371cedf396e118d6b1a712b7d5aa2e928afe.camel@suse.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stapelberg-ch.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d0D3rzeVurhpxlRD5yHC3F1gVFUVbRuXrGqiLH+pm8g=;
        b=JDeWkj3RXcOM7dxCi9lSJ96wgEj7tyZ62fzNOw2N5EbjFxG2KMmS+OhV8Gz/KJ72+e
         j2qZbgbYxMmiq74tZPB/q8TlmLtFCormah/0/h4boUccq5PkHMN5tEFUgF8+23sbzK5N
         jhs0aXHDMGfyIL/bqJVAw6BMEvR3+79+p5tDwcSBfbu8YXUm+zqzrOlu5CeBnyzsrxRi
         xLmG5PseqIwp56xclTdApukG76524tl6X2EvyNc6vzBIAYLJ0Xz5eAobLvaZmAJvcOXb
         /HE+Ioteh5ZWzpOhs/oGuRnntirIoT3mRz2niLB5inZ3NXGT4TLrAQQiJ+SgxnEKqD73
         I3ag==
In-Reply-To: <7212371cedf396e118d6b1a712b7d5aa2e928afe.camel-IBi9RG/b67k@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Wilck <mwilck-IBi9RG/b67k@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I agree, and getting minitramfs adopted anywhere is not my goal at all
:) See section https://michael.stapelberg.ch/posts/2020-01-21-initramfs-from-scratch-golang/#minitrd-outside-of-distri

On Wed, Jan 29, 2020 at 10:53 AM Martin Wilck <mwilck-IBi9RG/b67k@public.gmane.org> wrote:
>
> On Tue, 2020-01-21 at 18:07 +0100, Michael Stapelberg wrote:
> > Hey,
> >
> > I just published a blog post about a custom proof-of-concept
> > initramfs
> > generator (minitrd):
> >
> > https://michael.stapelberg.ch/posts/2020-01-21-initramfs-from-scratch-golang/
> >
> > This demonstrates that there is still a whole bunch of optimization
> > potential in existing initramfs generators such as dracut :)
>
> Cool, but I don't think it has big chances to be adopted in larger
> mainstream distros unless you add some extension/plugin functionality,
> like dracut's modules.d. Such plugins should be easy to write and
> maintain.
>
> Martin
>
>
>
