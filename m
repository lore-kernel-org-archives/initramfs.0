From: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Re: including python in the initramfs
Date: Tue, 16 Jun 2009 19:49:49 +0100
Message-ID: <1245178189.2150.76.camel@polyethylene>
References: <1245174031.2150.67.camel@polyethylene>
	 <A4EC33E8-3A45-4A6B-AE97-5B48EA425F75@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=QSgns5PDqlyWllWoOqwLBIbsL09INJNfaV6Yj+zAGmA=;
        b=rzB1H4JCa/R3JWUP921xrbkDUlbSnZpxAS7CRbQR32fyiL4vtc+d1jjFFiNMPz41hv
         m+Dghh678u1KJdhqAUq2DrB8bp+WJ477P6zePMQoaG/d5M9onrW5kFyUdji58KCGJVe1
         zG4oumChRYpwf8IbGXB6QlHJLQ+78OXDRdKhI=
In-Reply-To: <A4EC33E8-3A45-4A6B-AE97-5B48EA425F75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Tue, 2009-06-16 at 13:22 -0500, Victor Lowther wrote:
> > OLPC have a security client that runs pre-root-mount in the initramfs
> > which is quite complex. It is written in Python. As such, we need  
> > python
> > in the initramfs.
> 
> /me boggles.
> 
> Why can't it run after switching to the real root?

heh.. here we go :)

It's part of an antitheft system.
The users of the machine have root access by design, so they could
trivially disable any security system that runs on the root filesystem.
Thieves included.

However, our initramfs is secure. It's signed with OLPC's master key.
Our special BIOS will not boot an unsigned initramfs. So effectively, we
can trust that the code we put in the initramfs cannot be
modified/crippled/disabled.

It's certainly a strange requirement and I figure from your responses
there is no obvious "good" answer. I agree. I just thought I'd ask
anyway.

cheers,
Daniel


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
