From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: plymouth working for anybody with F-11?
Date: Fri, 29 May 2009 06:49:05 -0500
Message-ID: <1243597745.31156.2.camel@sentry-no.fnordovax.org>
References: <4A1F6351.8070908@redhat.com>  <4A1F6550.4070400@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=SLpybBOlbAIaDawupYvKyDyb3GpQvvAObmU8oiVCn7Q=;
        b=XURALCpJ0pknJ2dA39+tFVZjORuhsLQvdi3ZMxuEwAPl1+vDnmCqfsPZyHudoyUY4x
         qg8jS4TKga5n2T2UfSy8J8PDh20aSN42iiziMKwd6X6r+a7nqmGlBJLPerccfibWfEtP
         ry5Ve5OQmRIer0oCw8iCMYhf6AISO6XdU0hnA=
In-Reply-To: <4A1F6550.4070400-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, 2009-05-29 at 00:32 -0400, Warren Togami wrote:
> On 05/29/2009 12:23 AM, Warren Togami wrote:
> > Is plymouth working for anyone with F-11 right now?
> >
> > In my case it seems to fail to load the KMS kernel module (intel.ko in
> > my case) prior to plymouth splash is executed.
> >
> 
> Another problem is it seems to still use default.so.
> 
> [[ -f ${LIBDIR}/plymouth/default.so ]] && inst ${LIBDIR}/plymouth/default.so
> 
> The plymouth in F-11 seems to no longer use the default.so symlink.  It 
> seems to be copying the default "charge" theme into the image, but 
> without the required two-step.so plugin.
> 
> BTW, why are we using our own plymouth-populate-initrd instead of using 
> plymouth's own /usr/libexec/plymouth/plymouth-populate-initrd, which 
> presumably would do the right thing for its own version of plymouth? 
> (Didn't try it yet.)

Because the original plymouth-populate-initrd script was full of useless
(to dracut) code that our internal inst functions handled better and in
a more generic fashion, so I trimmed it down to its essentials.

> Warren Togami
> wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
