From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: module 90kernel-modules-loaded
Date: Mon, 09 Mar 2009 05:37:08 -0500
Message-ID: <1236595028.14649.40.camel@sentry-no.fnordovax.org>
References: <49B1439A.7030208@redhat.com>
	 <20090306160822.GD10711@nostromo.devel.redhat.com>
	 <1236361391.6517.0.camel@sentry-no.fnordovax.org>
	 <20090306203921.GA28154@nostromo.devel.redhat.com>
	 <1236382532.5147.38.camel@sentry-no.fnordovax.org>
	 <20090309031111.GC3983@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=9kP+VxNmeqXwvrloDJetrQ6xPodZjgwsslE2qUrdQLg=;
        b=sh3fqNIEje+6JeIjoZjJaOhNpuP/kYtmljOtBVUlhLyAuUqWqYt+jdyVr7guD+hxrl
         z1NqUMYlMKaFuKIj9o93VwOV4IbCN3TfBcw5UDer8QsDYOrwCLj1WdWC7w8pt8OKRBiL
         ZXdmFk3anNq+l4D315ZmPs8Kyvfkj7Xr+P6iI=
In-Reply-To: <20090309031111.GC3983-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sun, 2009-03-08 at 23:11 -0400, Jeremy Katz wrote:
> On Friday, March 06 2009, Victor Lowther said:
> > On Fri, 2009-03-06 at 15:39 -0500, Bill Nottingham wrote:
> > > [I]nstead of scripts hard-coded to do various things, we depend on
> > > udev to create device nodes for us and then when we have the
> > > rootfs's device node, we mount and carry on
> > 
> > We do this just fine.  Udev is the engine that drives everything in a
> > dracut-generated initramfs -- the additional scripts are there in the
> > initramfs to handle things that udev does not handle gracefully. If you
> > see some functionality currently handles in a script that udev could
> > handle better, please implement it.
> 
> The problem is the direction seems to be "hm, udev can't do this, guess
> we'll make a hook" rather than "fix udev and the underlying tools".
> Yes, it means it's harder.  And yes it means that distros have to get
> updates for everything to work.  But otherwise, we remain in the past
> with piles of scripts doing most things.

udev and the underlying tools are not broken.  Udev names devices
according to rules and calls out to external programs or scripts for
everything else.  It does that job very well.

> [snip]
> > > - handle various device types through shell snippets, not udev
> > >   (raid, crypt, etc.)
> > 
> > We use shell snippets where udev is not flexible enough or where there
> > are other limitations we have to work around.  The entire process on the
> > initramfs is still udev driven, however.
> 
> Honestly, I really wouldn't say that "the entire process is still udev
> driven".  The rootfs *NEEDS* to be being mounted from a udev rule --
> otherwise, we're not being driven by events.  We're having events to do
> some things and scripts for others/more

OK, there are a few ways that spring to mind to do this:

1: Teach udev how to interpret all the kernel parameters that might be
involved in detecting, performing all the prerequisites for mounting,
and then mounting the root filesystem.  Package all this logic up into
something that can can be driven by a small number of new rules.

While that sounds tempting, it seems to add quite alot of magic to udev
that it currently does not have and that is well outside its core focus
of device naming -- or does udev perform any device configuration that
it does not call out to an external executable or a shell script to do?

2: Include enough logic on the initramfs to parse all the kernel
parameters that might be involved in booting the system and then
custom-write udev rules that will do all the work of making the root
filesystem available (assuming it is available at all) inside the
initramfs.

That sounds like loads of extra work -- we will have to write a script
or program written in C whose job is to parse kernel parameters,
custom-write udev rules based on the ones that might be involved in
booting, and inject them into udevd and hope for the best.

3: As above, but create our custom rules at initramfs generation time
instead of at boot time.

This makes a generic initrd impossible to create, so I will discard it
out of hand.

4: Add a few udev rules that call scripts to configure a few key device
types as they are detected, and have another process running that looks
for the root filesystem to appear running in tandem with udev.

This is what we currently have, and it seems to be doing very well.

Of all the approaches, only the first meets your *NEEDS* requirement,
and it involves tacking a shedload of extra capabilities onto udev that
it will only ever use while booting the system. The second sounds even
harder to debug than any of the current initramfs schemes, and the third
is too brittle and actually worse than the current redhat/fedora
initramfs scheme. We have made large advances using the fourth approach
-- sorry they were not in the direction you initially hoped for.


> Jeremy
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
