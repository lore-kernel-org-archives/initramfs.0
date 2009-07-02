From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [PATCH] Don't use absolute paths for utilities
Date: Thu, 02 Jul 2009 11:17:38 -0400
Message-ID: <1246547858.28989.12.camel@lap75545.ornl.gov>
References: <4A4CBE3B.10703@bfh.ch>
 <1246545040.28989.7.camel@lap75545.ornl.gov> <4A4CC6F6.2070907@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <4A4CC6F6.2070907-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, 2009-07-02 at 16:40 +0200, Seewer Philippe wrote:
> 
> David Dillow wrote:
> > On Thu, 2009-07-02 at 16:03 +0200, Seewer Philippe wrote:
> >> diff --git a/dracut b/dracut
> > 
> > It would be good if your commit message mentioned why it is not a good
> > idea to use absolute paths, eg different distros put things in different
> > places, etc.
> 
> We've had the discussion about absolute paths and distros a few times, 
> so it should be obvious.

We have, on the list and in IRC, but newcomers to the project will only
have the commit log. Our commit text has often been of the same quality
as
	int i = 0; /* set i to zero */

and I'd like to see it improve. This isn't directed solely at you --
many of us are guilty, including myself.

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
