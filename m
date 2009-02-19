From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: Re: Tainting the initrd
Date: Thu, 19 Feb 2009 13:35:49 +0100
Message-ID: <20090219123549.GL3901@baikonur.stro.at>
References: <t7sv66-dk4.ln1@news.researchut.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <t7sv66-dk4.ln1-b1aPebNLFEbkkoF7R9+BZ0EOCMrvLtNR@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Feb 19, 2009 at 04:56:20PM +0530, Ritesh Raj Sarraf wrote:
> Hi,
> 
> I hope it is not too late to discuss this problem.
> I have a bugzilla filed for this, filed here:
> https://bugzilla.redhat.com/show_bug.cgi?id=435033

you seem to also have filed
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=514370
 
> The problem described in the above bugzilla entry is about "How do we 
> authenticate initrd images"
> We sure have a huge dependency on the initrd. And day-by-day that dependency 
> is increasing. Multipath SAN Boot, NFS et cetera all depend on the proper 
> execution of an initrd image.
> 
> We see a lot of problems in the SAN space, where users end up shuffling among 
> 2 versions of HBA drivers. One from the OS Vendor, the other from the HBA 
> vendor. And then we see IHVs and ISVs using their own set of utils to tamper 
> the initrd. This is just an example.

loading external modules that do s..t is easy to detect,
there is the tainting flag for that.
 
> Currently, we don't have a way to identify, like what initrd image has the 
> OS booted from. And we don't have a way to verify whether the initrd image 
> from which the OS has booted from (and ended up with a bug), is the same 
> initrd image that the OS vendor generates.
> 
> Since this is a re-write effort, I'd like to know opinions here.
> * Do we see this situation as a problem ?
> * If yes, how can we overcome it ?
> 
> I have some proposals listed in the bugzilla, but all are half-baked. I hope 
> with your help, we can come up with a better approach. Probably, we just 
> need a set of strict and enforcing assumptions.

as initramfs in Debian based boxes are updated by calls of postinst of
various packages. i see a hard time to check that is the vendor supplied
one.

-- 
maks
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
