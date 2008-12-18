From: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Dracut -- Cross distribution initramfs infrastructure
Date: Thu, 18 Dec 2008 15:12:11 -0500
Message-ID: <1229631131.13174.23.camel@aglarond.local>
References: <1229540094.28858.150.camel@aglarond.local>
	 <20081217190700.GA15377@infradead.org>  <4949FD67.6040906@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4949FD67.6040906-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

(dropping lkml again)

On Thu, 2008-12-18 at 08:36 +0100, Hannes Reinecke wrote:
> Christoph Hellwig wrote:
> > On Wed, Dec 17, 2008 at 01:54:54PM -0500, Jeremy Katz wrote:
> >> Therefore I've started on a new project, dracut, to try to be a new
> >> initramfs tool that can be used across various distributions.  From the
> >> README...
> > 
> > It looks like Hannes has also been working on a new, modular initramfs
> > for a while:
> > 
> > 	http://git.kernel.org/?p=linux/kernel/git/hare/mkinitrd.git;a=summary
> > 
> > I hope you guys can get together and agree on one implementation..
> 
> Thanks hch for pointing this out.
> 
> We definitely should get together to hammer our one implementation.
> Having different scripts for every distributions is a PITA.

Indeed -- but as davej noticed, going with one distro's implementation
is unlikely to fly and so we need to start over

> I'm not saying my implementation is the greatest on earth, so
> if anyone has any better suggestions I'm all ears.

I had actually looked at it some a couple of months ago when the
discussion started, but it looked like the same thing that an
initramfs/initrd has always been -- piles of shell scripts that are
strung together based on what the system building the initramfs looks
like.  The problem is that you then a) have a fair bit of system
dependence in the initramfs b) spend a lot of time running shell
scripts. 

By instead moving to where we're basing everything off of uevents we can
hopefully move away from the massive shell scripts of doom, speed up
boot and also maybe get to where a more general initramfs can be built
_with the kernel_ instead of per-system.

Jeremy

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
