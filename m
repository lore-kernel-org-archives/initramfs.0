From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: wiki, README and TODO update
Date: Fri, 15 May 2009 21:57:19 -0400
Message-ID: <1242439039.9330.4.camel@obelisk.thedillows.org>
References: <4A098CB5.2070006@redhat.com>
	 <1242351147.29452.2.camel@sentry-no.us.dell.com>
	 <1242355988.5107.4.camel@obelisk.thedillows.org>
	 <1242389030.29452.10.camel@sentry-no.us.dell.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1242389030.29452.10.camel-76q0VzFBGGqhmyxYjSZgiRL4W9x8LtSr@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, 2009-05-15 at 07:03 -0500, Victor Lowther wrote:
> On Thu, 2009-05-14 at 22:53 -0400, David Dillow wrote:
> > Glad to see this project isn't dead...
> 
> I had a sudden attack of Real Life -- my daughter learned to crawl, so
> the tiny amounts of free time I once had vanished.

I hope you enjoyed it while it lasted -- once they learn to walk your
free time goes negative! :)

> > I've got a few boot-off-of-NFS patches together that use DHCP options to
> > find the root, and let it be overridden by the command line. I've also
> > got a piece that lets it boot over a bonded network. I'll try to circle
> > back to those and post them before Memorial Day (May 25h).
> 
> Cool.  Can you also hack up a makefile target that tests it using kvm
> and/or qemu?

Most likely. I've been using libvirtd for my testing, but it shouldn't
be too hard to do.

> I suppose I should post my more generic test suite improvements (making
> kvm/qemu work no matter what it is named on any given distro) to give
> you something a little easier to build with.

If you get there first, cool. If not, I'm sure we'll be able to merge
our work.

> > These all trigger off of udev events, though I recall there was some
> > discussion about whether that was the way to go or not. In many ways,
> > they are just polish on some of the network patches that have been
> > posted here before (by you two, IIRC).
> 
> I don't think we ever finally decided one way or the other, the
> conversations kind of died off without reaching a conclusion.

Well, we'll have something concrete to tear apart then. :)

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
