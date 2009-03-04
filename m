From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] Steal rules we need from the latest udev package.
Date: Wed, 04 Mar 2009 05:33:28 -0600
Message-ID: <1236166408.6500.37.camel@sentry-no.fnordovax.org>
References: <d53985b1c536e2fb845e0e3c369edd06d5018011.1236124962.git.victor.lowther@gmail.com>
	 <462be3c3cfdf24ba51bc4d1a1f66cc30b8d29d82.1236124962.git.victor.lowther@gmail.com>
	 <20090304002535.GB96609@redhat.com>
	 <1236129369.6500.18.camel@sentry-no.fnordovax.org>
	 <ac3eb2510903040212m5d68d812kbce03d831e8c3d12@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=zxeqtWWD6/wDkBKbYHW0rwVXV++CFr+JAetvXyXeqdQ=;
        b=cnl4X5MSuvgwvBvWtDWdDofPiSgYaAJmd5Kf/FE90hUekCvips2S4wMNa+e/ykl0um
         qBdW3I2L+UYdShq4rUia1Cr5oCI+Gfz4t7e76nDadBa18+fOwzJR4tNbzviCBn8bHYAe
         ZjG+hs/okmmPuvJpILizf+rUn7XBLy3WTduvM=
In-Reply-To: <ac3eb2510903040212m5d68d812kbce03d831e8c3d12-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Cc: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, 2009-03-04 at 11:12 +0100, Kay Sievers wrote:
> On Wed, Mar 4, 2009 at 02:16, Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > On Tue, 2009-03-03 at 19:25 -0500, Jeremy Katz wrote
> >> Stealing rules, though, means that they're almost certain to be out of
> >> date as soon as they're present.
> 
> Exactly. And they will break horribly next month, when we e.g. switch
> from vol_id to blkid.
> 
> > Yep.  This is intended to be a quick and dirty hack for those of us who
> > prefer not to delve into the nuances of how each distro does things.
> 
> Don't do that. There is no need to know how "distros" work, you only
> need to know about Debian. :)
> 
> > Out of date does not mean as much to the initramfs, IMAO -- as long as
> > we can find and mount root, it does not matter how out of date the rules
> > are.
> The current default udev
> rules will not even work correctly on the "ancient" udev package
> Debian ships today.

Ah,  I was not aware of that little tidbit of information.

inst_rules (in this patch series, at least) will try to grab rules from
the host system before using the ones I stole from udev upstream.  That
did not work on Debian due to their having a
different-enough-to-be-infuriating naming scheme, and I did not feel
like spending enough time examining their scheme to figure out the
"right" rules to grab.

> All other distros work together and ship a set of rules which is the
> result of a merge of all the distro stuff. They all ship an identical
> setup today. There is only one left, which thinks it can do better,
> and I would not like to see broken workarounds for everybody in the
> dracut repo. It should be a "Debian dracut module to work around their
> weird idea of upstream", and not a "pain to maintain default" for all
> other users. :)

Fair enough. Consider this patch withdrawn.

> > Mmmm... sweet scent of politics.  I get the feeling that many kilobytes
> > have been spent flaming^Wdiscussing this topic.
> 
> Yeah, it seems hard for some kids to share their toys. :) But it's
> pretty much over, there is not much to discuss anymore. We all ship
> the same stuff, and share the same bugs. If you want "Debian" use
> Ubuntu. It's part of the upstream development, ships recent versions
> which other stuff can develop against, and can depend on. :)

Good to know, but I think I will stick with Fedora for now.  It seems
like we have enough patches floating around on the mailing list right
now to have a good chance at making everything but Debian work without
too many distro-specific workarounds (or, at least we will once
switch_root is rewritten in C and packaged into util-linux)

> Thanks,
> Kay
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
