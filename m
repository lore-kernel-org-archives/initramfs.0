From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: module 90kernel-modules-loaded
Date: Tue, 10 Mar 2009 04:57:10 -0500
Message-ID: <1236679030.14649.45.camel@sentry-no.fnordovax.org>
References: <49B1439A.7030208@redhat.com>
	 <20090306160822.GD10711@nostromo.devel.redhat.com>
	 <1236361391.6517.0.camel@sentry-no.fnordovax.org>
	 <20090306203921.GA28154@nostromo.devel.redhat.com>
	 <1236382532.5147.38.camel@sentry-no.fnordovax.org>
	 <20090309031111.GC3983@redhat.com>
	 <1236595028.14649.40.camel@sentry-no.fnordovax.org>
	 <49B61F89.4020902@spra.gg>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=LypziEkK9ScJTmMyzZiyRIYnKu547vT/2OM1JUdvidQ=;
        b=HMzOBlyVs97iOnwMFVwf6xP3SDre2vgX0UXFPMRtwZuQxbUsd+4h//BKjBvgIvP86c
         oNiRJ1uahVCBjwr63klFy+T/tCMvueWro5vyQ1TEqfxP4rFQTL/3PXQKpR44lzynmMuk
         bbBGsMnZbEfDsaQ4ptdt0KOBMVdKNdD36xIQc=
In-Reply-To: <49B61F89.4020902-2iSS7ArDF14@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Adam Spragg <adam-2iSS7ArDF14@public.gmane.org>
Cc: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 2009-03-10 at 08:06 +0000, Adam Spragg wrote:
> Victor Lowther wrote:
> > 4: Add a few udev rules that call scripts to configure a few key device
> > types as they are detected, and have another process running that looks
> > for the root filesystem to appear running in tandem with udev.
> [snip]
> > We have made large advances using the fourth approach
> 
> Something that worries me slightly ... ISTR that a large part of the goal of
> udev was to get device naming policy out of the kernel tree and into an
> externally maintained module.
> 
> But one of the goals of dracut seems to be to become part of the kernel
> source tree.
> 
> So, if dracut imports udev naming rules and, therefore, device naming
> policy, and is in turn imported into the main kernel source tree, doesn't
> that kind of defeat one of the main reasons for udev's existence?
> 
> Is this something we need to worry about?

Nope, we import our rules from the host system, so whatever policy
decisions are made are someone else's policy decisions.

> Adam Spragg.
> 
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
