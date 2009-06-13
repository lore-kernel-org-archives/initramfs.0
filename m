From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [RFC PATCH 0/5] Multiple interfaces support and lots of
 cmdline parsing
Date: Sat, 13 Jun 2009 08:24:58 -0400
Message-ID: <1244895898.18551.30.camel@obelisk.thedillows.org>
References: <4A327030.1000803@bfh.ch>
	 <1244865916.18551.20.camel@obelisk.thedillows.org>
	 <4A3360AA.9060600@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A3360AA.9060600-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sat, 2009-06-13 at 10:17 +0200, Seewer Philippe wrote:
> 
> David Dillow wrote:
> > The series broke the NFS and NBD test suites, and I've not looked into
> > why yet. It dies on the first test.
> 
> That's ... weird? I wasn't able to run the qemu/kvm test locally (don't 
> ask, please). But I replicated the test arguments and ran them through 
> the scripts. Should work, and nfsroot booted flawlessly Friday afternoon.
> 
> What's the die() error message?

The only thing printed for either test was
Warning: No ip= argument(s) provided, defaulting to DHCP

It never made it past the first subtest.

It's possible that I screwed up applying them, but git apply-mbox
applied all 6 (5+missing) in order without issue.

> > I've started digging in and trying to review some of the changes, but
> > I'm just not going to have time before I leave; perhaps I can sneak away
> > for a bit next week.
> 
> Thanks for looking into it!
> 
> > Perhaps a theory of operation/design document as to what the flow is
> > expected to be, or what is handled where would help?
> 
> Is it really that complex? I'll write down my thoughts and add in a few 
> examples.

I think part of the problem is that your series does too much in each
step. You have style changes, network device handling changes,
dhclient.conf changes, and command line parsing changes in the series.
Each one of those should be its own patch.

I would suggest getting the dhclient.conf and network device handling
changes in first; the dhclient.conf change should be uncontroversial and
we need to get the discussion on the handling going -- that is holding
back other progress. The command line handling is important, but lower
priority at the moment in my opinion.

Also, please try again to get the test suite running locally, and make
sure any support you add/drop is reflected in the test suite in the same
patch, if at all possible. This will help demonstrate the effect of the
changes you are making.

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
