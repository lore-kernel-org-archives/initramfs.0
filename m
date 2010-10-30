From: Ambroz Bizjak <ambrop7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dracut
Date: Sat, 30 Oct 2010 09:57:29 +0200
Message-ID: <AANLkTinO0edPay_HxUW93Dm2PpHkchxKDC1yezhV-u2K@mail.gmail.com>
References: <4CBDA328.40401@googlemail.com>
	<4CC17713.4030504@googlemail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=hdEtb28kz9WSaFyhSmmyfZby8qxuOn13n820ANwzdQs=;
        b=VwUy9fFRmCtsflsOOpc8DVcYa6TrnzooBFZOe2m1g+KDDaNT6oM3qcqpe6g3UptOXa
         nMsRi860qitTToSHbEjlSbauvHtV01Fnjtma5qMQKdsAW1nxBCyoh+f/n6+6adyiSwrg
         Nbd/oh7TCSpdBkllW3ZGW3jkbklXsVLDMm1uo=
In-Reply-To: <4CC17713.4030504-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, Oct 22, 2010 at 1:35 PM, Mr Dash Four
<mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
> Is it possible to build dracut for system/architecture which is different
> from the host on which dracut is run?

I have been interested in this before. However I decided it would be
too much work to add this functionality to dracut. Instead I wrote my
own initramfs generator which can do that by design.
It is very basic compared to dracut (can only boot from physical
disks), but I don't need anything else.
If anyone is interested, take a look at http://code.google.com/p/ainitramfs/ .

My generator, like dracut, takes all binaries from the existing
system. In my opinion, building software is out of scope for an
initramfs generator.
If some software doesn't work as intended when used inside the
initramfs, it should be updated to work, or, a seperate version should
be built specifically for use in the initramfs (but by the package
manager, not the generator).
