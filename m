From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: --include functionality?
Date: Wed, 20 May 2009 21:04:49 -0500
Message-ID: <1242871489.29452.32.camel@sentry-no.us.dell.com>
References: <Pine.LNX.4.58.0905201806160.7805@gate.bb.dicp.net>
	 <7969D0E7-3BC0-46AC-A75B-1EEFA85DAE67@gmail.com>
	 <Pine.LNX.4.58.0905202135570.7805@gate.bb.dicp.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=3iQjxPI/fC0uaQJUKJGnrFgUXLx34TF8rf4Jf4WwaMc=;
        b=dgPGFe5cvoRD6Hjf0qNC/wnvXrdZp0GoTZ6F+KMWkSTFaoC7i+y7PGpZpG/BZrx6nV
         AU6nA0hqG02XMiRNkSZc7+6PJ+97WDXW3k5nEgxHTyLuX7qCEY9TUt3H+AB594oD0X4m
         vEVX1kN+8dgR92IGmPrDnHAfDzAqBavnNviCg=
In-Reply-To: <Pine.LNX.4.58.0905202135570.7805-bvJ793YqIODNUDpmljszgg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, 2009-05-20 at 21:38 +0200, Andreas Thienemann wrote:
> On Wed, 20 May 2009, Victor Lowther wrote:
> 
> > The test framework uses it to inject the files needed for the root  
> > filesystem.
> 
> You sure about that?

It doesn't in the git repo on sf.net, it does in the private branch I am
hacking on testing on.

> --include is not used at all.
> What the test scripts do is to source dracut-functions and call 
> dracut-install().

Yeah, the first round of the test framework did that.  However,
generating cryptroot images using that method did not work for testing.

> That is perfectly okay and I wasn't suggesting changing this. I was 
> thinking about the --include command line switch.

All I can say is what I was thinking when I added it. :)

> regards,
>  andreas
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
