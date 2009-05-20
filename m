From: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH] LIBDIR detection without /proc
Date: Wed, 20 May 2009 23:24:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0905202309060.7805@gate.bb.dicp.net>
References: <4A146687.3020508@redhat.com> <Pine.LNX.4.58.0905202249560.7805@gate.bb.dicp.net>
 <4A146EBF.5060404@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A146EBF.5060404-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, 20 May 2009, Warren Togami wrote:

> If you have 64bit plymouth it will be at that location.  If it isn't at 
> that location, then the previous lib vs lib64 check and subsequent 
> copying would have failed to do its job anyway.  So what is the possible 
> harm?

For this specific case, it would work in hopefully all cases.
I have no idea how common ia32 systems with amd64 binaries in addition to 
the used ia32 binaries are. This is something which would throw off the 
check.

I've seen such things on development systems, which is why I'm personally 
tending to favor uname output... In any case, it's Harald's call. :)

regards,
 andreas
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
