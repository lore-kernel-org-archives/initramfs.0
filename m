From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH] Move actually mounting the root filesystem into
 its own series of hooks.
Date: Tue, 24 Feb 2009 05:39:38 -0600
Message-ID: <1235475578.28090.64.camel@sentry-no.fnordovax.org>
References: <3188506a1f06de54ee7874fc45261f5c2faf9e79.1235283966.git.victor.lowther@gmail.com>
	 <49A301FF.2090303@redhat.com>
	 <1235434056.28090.28.camel@sentry-no.fnordovax.org>
	 <49A3AB75.1010805@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=lYOg5IAGAMf0d4KeQnisVPBKjdaKBc9+o61OdKbCh2M=;
        b=EamB48THrA+zyqxio+LgE9sxuDxwEnqyQs0qVukD8Fzx+9EYWfPg98urS8jAt0+Xjc
         f3o7s8SZTq9jL8vzwkOpQW8o5yiU8dgwG/B/c/58DEQstuX1SgYz8N6NWeV0Mey1CKli
         dC9RMLxQmTaRn37N2Yv8gdXTIoJCxg/p078u8=
In-Reply-To: <49A3AB75.1010805-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 2009-02-24 at 09:10 +0100, Seewer Philippe wrote:
> Hi Victor
> 
> [snip]
> > Interesting -- I have been working on implementing code to detect and
> > configure network interfaces according to the netboot.txt kernel
> > document. The code I have written so far is browseable at
> > http://git.fnordovax.org/dracut/log/?h=network-configurability
> > (and it even works some of the time), and I would appreciate input from
> > someone who actually uses that functionality on a daily basis.
> Looks good. I'm actually considering replacing our own initrd with this 
> one when we upgrade our netboots to 2.6.29.

awesome!

> Though I see a small problem: Ever thought about what happens if there 
> are multiple interfaces on different networks? Only one is valid to 
> mount the root-fs... Currently I've solved that by upping each interface 
> and then ping-testing the nfs-server... Any better ideas?

My current plan was to try and mount the NFS share forever, and maybe
panic and die if a timeout option was passed as a kernel parameter.

Yes, I have thought about it, and have come to the conclusion that it is
one of those problems that someone who actually uses it is better
equipped to solve.  Writing the code to bring interfaces up and mount
filesystems is generic, writing code to see if servers are responding
depends on the environment -- the best way for me to handle it is to
make it dead simple for site admins to handle it.

> Thanks,
> Philippe
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
