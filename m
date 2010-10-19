From: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH] 90crypt: keys on external devices support
Date: Tue, 19 Oct 2010 14:54:48 +0100
Message-ID: <4CBDA328.40401@googlemail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=c+DszhNoRICFLMYKL7PHoL00XIBMCdE0q85Ip7uHV+o=;
        b=dook+mRR7mhP0yX5LkmwtsVEAtHbX4DMvjBOClLMm1jamZR2/tvLeC9eTKVHlbHdqz
         Fl/ivbfyUD7madHQXA9Hc4n7s/ZrQph6t+0hRbGJzKVxPDD4IHVaH0pBXJevBdVL4nCN
         1ey2/s/0uKWOuhVsmG16IDo160GRRjZW2Yw+E=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I am currently trying to modify dracut (I am on up-to-date FC13 x86_64) 
so that it enables me to use my smartcard token to unlock (and use) a 
boot partition. As a secondary task I would then try and automate a 
similar process (through the smartcard event manager - pkcs11_eventmgr) 
when the card is inserted to automatically ask for pin and unlock LUKS 
partitions.

That was the reason I have stumbled across this patch - 
http://www.spinics.net/lists/linux-initramfs/msg01402.html and the 
subsequent response that it has been included in the repository for 
dracut. That was a couple of months ago.

Could you tell me whether this feature is already implemented in 
FC13/FC14 repositories and if not what are the plans? I am also 
interested to see whether there are plans (or, indeed attempted 
implementations) to introduce smartcard support to LUKS partitions (boot 
or not)? Many thanks
