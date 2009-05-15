From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: wiki, README and TODO update
Date: Fri, 15 May 2009 07:03:50 -0500
Message-ID: <1242389030.29452.10.camel@sentry-no.us.dell.com>
References: <4A098CB5.2070006@redhat.com>
	 <1242351147.29452.2.camel@sentry-no.us.dell.com>
	 <1242355988.5107.4.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=GpnfFtJmYo7A+WZnfoX4A54BiF8WaRImnB5oMqeXFeM=;
        b=qpdRZ+GTWKUu7ZdepCvAigfvEtWkRNJdLu5jLUalytx5b4d7zYg6LiKXOsc8BRojuH
         5H5ehmC1qg2vkU1/6u1XEH87AS6bIolkV9IjF+mtMlFtaSeIAHnC7GvHg3JXxSPDQfLn
         D1GQXCbO2pJ5fp2uu4I7PEgdD5FeUivGby+H0=
In-Reply-To: <1242355988.5107.4.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, 2009-05-14 at 22:53 -0400, David Dillow wrote:
> On Thu, 2009-05-14 at 20:32 -0500, Victor Lowther wrote:
> > On Tue, 2009-05-12 at 16:50 +0200, Harald Hoyer wrote:
> > > Today I updated http://apps.sourceforge.net/trac/dracut/ and the package README and TODO files.
> > > The next days, I will add iSCSI support and test various network setups.
> > 
> > Cool.  I ahve been working on some test suite improvements (lvm on
> > cryptroot on software raid5), and am working on making dracut actually
> > work in that configuration.  I will post patches to the mailing list
> > once it works without manual hackery.
> > 
> > Next stop, all that over iscsi.  Should be fun.
> 
> Glad to see this project isn't dead...

I had a sudden attack of Real Life -- my daughter learned to crawl, so
the tiny amounts of free time I once had vanished.

> I've got a few boot-off-of-NFS patches together that use DHCP options to
> find the root, and let it be overridden by the command line. I've also
> got a piece that lets it boot over a bonded network. I'll try to circle
> back to those and post them before Memorial Day (May 25h).

Cool.  Can you also hack up a makefile target that tests it using kvm
and/or qemu?

I suppose I should post my more generic test suite improvements (making
kvm/qemu work no matter what it is named on any given distro) to give
you something a little easier to build with.

> These all trigger off of udev events, though I recall there was some
> discussion about whether that was the way to go or not. In many ways,
> they are just polish on some of the network patches that have been
> posted here before (by you two, IIRC).

I don't think we ever finally decided one way or the other, the
conversations kind of died off without reaching a conclusion.

> Dave
> 
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
