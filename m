From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: Testers wanted: dracut lazy install with cpio
Date: Tue, 28 Feb 2012 12:46:08 -0500
Message-ID: <1330451168.1026.139.camel@obelisk.thedillows.org>
References: <4F4BA634.5070804@gmail.com> <jiii51$5mc$1@dough.gmane.org>
		 <4F4CEE33.3000906@bitwagon.com> <4F4CF2D1.8090704@redhat.com>
	 <1330446443.1026.123.camel@obelisk.thedillows.org>
	 <4F4D07A1.7010305@bitwagon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F4D07A1.7010305-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 2012-02-28 at 08:58 -0800, John Reiser wrote:
> On 02/28/2012 08:27 AM, David Dillow wrote:
> 
> > Is the purpose of this work to speed things up for the user, or for the
> > developers? Your approach is correct for developers, since we're more
> > likely to be making multiple dracut image with a warm cache. But users
> > are more likely to hit the cold cache case.
> 
> Both users and developers.  However, the cache must be controlled
> (or known) for any measurement, else there is no way to attribute
> the effects of any measured change: the cache effect could be much
> larger than any improvement (or degredation).  The easiest way
> is to have a warm cache: discard the first run of a series because
> of the unknown cache state.

Your commentary on the effects of caching and non-idle machines is true
and a useful reminder, but I think you talked past my point -- Harald
seemed to be wondering if the speedup was worth the complexity, and that
can only be answered by benchmarking it in the appropriate environment.
A fully warmed up cache is easiest and probably correct for developers,
but does not cover the case for users -- though if the speed up is good
there, then it is likely better for the users' case.

Your point about a mixed cache from an updated kernel is well taken;
perhaps a good way to replicate the user's experience would be to put
something like the following in a script -- so you don't have to
remember the path and get it right in a sudo:

for i in {1..10}; do
	sudo sh -c "echo 1 > /proc/sys/vm/drop_caches"
	find /lib/modules/$(uname -r) -type f -print0 | xargs -0 cat > /dev/null
	time ...dracut...
done

and best if you do your testing from single user mode (may not even need
the sudo, then). It won't be perfect, but I think it would be more
meaningful than the easy case.

I tend to agree that the ~2 second improvements reported so far are not
compelling, but I see those as the developers case. I'm more interested
in the users' case -- is that 14 seconds Cong reported real?
