From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: wiki, README and TODO update
Date: Thu, 14 May 2009 22:53:08 -0400
Message-ID: <1242355988.5107.4.camel@obelisk.thedillows.org>
References: <4A098CB5.2070006@redhat.com>
	 <1242351147.29452.2.camel@sentry-no.us.dell.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1242351147.29452.2.camel-76q0VzFBGGqhmyxYjSZgiRL4W9x8LtSr@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, 2009-05-14 at 20:32 -0500, Victor Lowther wrote:
> On Tue, 2009-05-12 at 16:50 +0200, Harald Hoyer wrote:
> > Today I updated http://apps.sourceforge.net/trac/dracut/ and the package README and TODO files.
> > The next days, I will add iSCSI support and test various network setups.
> 
> Cool.  I ahve been working on some test suite improvements (lvm on
> cryptroot on software raid5), and am working on making dracut actually
> work in that configuration.  I will post patches to the mailing list
> once it works without manual hackery.
> 
> Next stop, all that over iscsi.  Should be fun.

Glad to see this project isn't dead...

I've got a few boot-off-of-NFS patches together that use DHCP options to
find the root, and let it be overridden by the command line. I've also
got a piece that lets it boot over a bonded network. I'll try to circle
back to those and post them before Memorial Day (May 25h).

These all trigger off of udev events, though I recall there was some
discussion about whether that was the way to go or not. In many ways,
they are just polish on some of the network patches that have been
posted here before (by you two, IIRC).

Dave

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
