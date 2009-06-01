From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 4/9] cmdline: cleanup handling and block: handler
Date: Mon, 01 Jun 2009 06:45:59 -0500
Message-ID: <1243856759.647.34.camel@sentry-no.fnordovax.org>
References: <cover.1243833882.git.dave@thedillows.org>
	 <d15c7a1ab71af9ab4fccd51fa02915e949f39c86.1243833882.git.dave@thedillows.org>
	 <1243848391.647.13.camel@sentry-no.fnordovax.org>
	 <1243853668.3844.117.camel@obelisk.thedillows.org>
	 <1243854157.647.22.camel@sentry-no.fnordovax.org>
	 <1243854952.3844.134.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=kri/65umEDlCUuhwUK1q9RyYXIVRTL2kTTCG3PxSOWg=;
        b=sZXWKO1jdpZNugRmzixufp9GFxACujh/k0PbCM5zBek4BhCyxahUyXrLwlrZenVP9f
         Er/4N3beDL0ARfiVU0tAb+ie64bFcrPEvyofxDJvOM/SmHtYfOuxkW+R2IfWFf5pTFET
         750r6P2JC5QNH4YQQjr9v0BySyCgvNLu3wOck=
In-Reply-To: <1243854952.3844.134.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, 2009-06-01 at 07:15 -0400, David Dillow wrote:
> On Mon, 2009-06-01 at 06:02 -0500, Victor Lowther wrote:
> > On Mon, 2009-06-01 at 06:54 -0400, David Dillow wrote:
> > > On Mon, 2009-06-01 at 04:26 -0500, Victor Lowther wrote:
> > > > Which editor are you using that highlights bash but not sh correctly?
> > > 
> > > vim on F10 has different rules for sh and bash -- things like $() and
> > > ${t%%:*} are lit in red for sh, but they are valid; they don't highlight
> > > that way if vim sees #!/bin/bash
> > 
> > Ah, that explains it. I am a fan of the OS with an editor tacked onto
> > the side.
> 
> So, ditch the whole shebang at the top? No #!/bin/sh or #!/bin/bash?

All scripts on the initramfs should be POSIX -- #!/bin/sh is another way
of declaring that for people who haven't R'ed TFM. #!/bin/bash is
misleading.

-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
