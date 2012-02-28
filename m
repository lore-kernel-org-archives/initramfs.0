From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: Testers wanted: dracut lazy install with cpio
Date: Tue, 28 Feb 2012 11:27:23 -0500
Message-ID: <1330446443.1026.123.camel@obelisk.thedillows.org>
References: <4F4BA634.5070804@gmail.com> <jiii51$5mc$1@dough.gmane.org>
	 <4F4CEE33.3000906@bitwagon.com> <4F4CF2D1.8090704@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F4CF2D1.8090704-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 2012-02-28 at 16:29 +0100, Harald Hoyer wrote:
> Am 28.02.2012 16:09, schrieb John Reiser:
> > On 02/28/2012 04:43 AM, Cong Wang wrote:
> > Was that run with a "cold cache"?  (What are the results for the
> > a second run on testimage, immediately after the first?)
> > I ask because the difference (48.5 - 34.5) between master and lazy
> > on testimage is much larger as a percentage than the (15.4 - 13.5)
> > difference for hostimage; and the testimage case was run first.
> > 
> 
> yes, "cold cache" should be ruled out.. better do several runs and pick the
> fastest one.

Is the purpose of this work to speed things up for the user, or for the
developers? Your approach is correct for developers, since we're more
likely to be making multiple dracut image with a warm cache. But users
are more likely to hit the cold cache case.

