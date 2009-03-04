From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] Steal rules we need from the latest udev package.
Date: Tue, 03 Mar 2009 19:16:09 -0600
Message-ID: <1236129369.6500.18.camel@sentry-no.fnordovax.org>
References: <d53985b1c536e2fb845e0e3c369edd06d5018011.1236124962.git.victor.lowther@gmail.com>
	 <462be3c3cfdf24ba51bc4d1a1f66cc30b8d29d82.1236124962.git.victor.lowther@gmail.com>
	 <20090304002535.GB96609@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=GqBYxr2Yvbl7M1dcAnBLEbf1YeuwKEGV18pdo9rfrPI=;
        b=C9BKrJa3ZKlfP4DJF2ZkejmhWQmGHuEk0LIty1TdFoGN5uGI+NpTFyLJqr5sMDdUh1
         0j9WuNajXaCMbAgwWhDkbk3+L7TGR+MzMBYx4h1xDOedKLnhUbwyGF0/PJWerKoXphiW
         7rbPxxC66GFsBn63oduGaGBPYn+e75IXPzK8c=
In-Reply-To: <20090304002535.GB96609-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 2009-03-03 at 19:25 -0500, Jeremy Katz wrote:
> On Tuesday, March 03 2009, Victor Lowther said:
> > This should arguably be done by importing the udev git repo as a submodule,
> > but I am too lazy to figure out how to do that right now.
> > 
> > I suppose this could also be done by rewriting the 95udev-rules.sh module
> > for each distribution, but that is something best left to the distro 
> > maintainers once we acheive some sort of widespread adoption.  Until then,
> > stealing rules from upstream udev seems like the most portable solution.
> 
> Stealing rules, though, means that they're almost certain to be out of
> date as soon as they're present.  

Yep.  This is intended to be a quick and dirty hack for those of us who
prefer not to delve into the nuances of how each distro does things.  

Out of date does not mean as much to the initramfs, IMAO -- as long as
we can find and mount root, it does not matter how out of date the rules
are.

> The right fix here is for distros not
> to go off and think that they know better than upstream on how to write
> udev rules.  But I'll let Kay chime in if he really wants to here ;-)

Mmmm... sweet scent of politics.  I get the feeling that many kilobytes
have been spent flaming^Wdiscussing this topic. 

> Jeremy
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
