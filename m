From: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 01/31] Some dracut cleanups and bashification.
Date: Mon, 9 Feb 2009 14:13:33 -0500
Message-ID: <20090209191333.GA8665@redhat.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com> <20090209171521.GA3646@redhat.com> <7FE9B1BD-31DA-4605-9881-3C42A05075E3@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7FE9B1BD-31DA-4605-9881-3C42A05075E3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, Feb 09, 2009 at 12:57:15PM -0600, Victor Lowther wrote:

>> The introduction of additional bashisms is something I'm not sold on.
>
> Well, it seems that most of the concern about bashisms has to do with  
> the code that ends up on the initrd. Making that code strictly posix is 
> probably a good thing.
>
> There is no real benifit in having the initrd generating code be  
> strictly posix, IMHO. It could be written in C, python, haskell, or  
> INTERCAL.

Good point.   I admit my comment was a knee-jerk reaction from reading
the first post without having read the whole patchset.

	Dave

-- 
http://www.codemonkey.org.uk
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
