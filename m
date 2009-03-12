From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: module 90kernel-modules-loaded
Date: Thu, 12 Mar 2009 06:36:24 -0500
Message-ID: <1236857784.14649.75.camel@sentry-no.fnordovax.org>
References: <49B1439A.7030208@redhat.com>
	 <20090306160822.GD10711@nostromo.devel.redhat.com>
	 <1236361391.6517.0.camel@sentry-no.fnordovax.org>
	 <20090306203921.GA28154@nostromo.devel.redhat.com>
	 <1236382532.5147.38.camel@sentry-no.fnordovax.org>
	 <20090309031111.GC3983@redhat.com>
	 <1236595028.14649.40.camel@sentry-no.fnordovax.org>
	 <49B61F89.4020902@spra.gg>  <20090310151412.GA2996@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=TMY/giUKfGfYOJynLCcUueHBOI4T4U/nfr2PDd8A6zU=;
        b=MMoTRXJ4Y4y/dSiLkYn521+29E6jLbt98LKgQxzTWHm6T1I8VWRdvNGANuTUVwYh5V
         3F5Pv74lfUvAcebp2C7i1t5NzuGu1whCwmCD99dqZIppBQKDHZi18ZizYoCP9QQ/po4J
         tczn/EfHLEsCR4QBky1ajiSq8mhwMfM+MlxGA=
In-Reply-To: <20090310151412.GA2996-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Adam Spragg <adam-2iSS7ArDF14@public.gmane.org>, Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 2009-03-10 at 11:14 -0400, Dave Jones wrote:
> On Tue, Mar 10, 2009 at 08:06:33AM +0000, Adam Spragg wrote:
>  
>  > But one of the goals of dracut seems to be to become part of the kernel
>  > source tree.
> 
> I'm beginning to have some second thoughts about the feasibility of this.
> There are a number of use-cases where regeneration of the initramfs
> is desirable, which would mean a standalone tool would be needed that
> isn't shipped as part of the kernel package.

True, but that does not mean it would not be useful to have a reference
initrd generation tool.

How about a round of testing, documentation, and bugfixing to hammer out
any weirdness in the current codebase, then call it 0.5 "may eat babies"
and try to get feedback from a wider audience?

Do we have a bugtracker set up for dracut yet?

> 	Dave
> 
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
