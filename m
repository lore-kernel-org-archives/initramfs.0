From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH] Move actually mounting the root filesystem into
 its own series of hooks.
Date: Wed, 25 Feb 2009 06:13:55 -0600
Message-ID: <1235564035.28090.69.camel@sentry-no.fnordovax.org>
References: <3188506a1f06de54ee7874fc45261f5c2faf9e79.1235283966.git.victor.lowther@gmail.com>
	 <49A301FF.2090303@redhat.com>
	 <1235434056.28090.28.camel@sentry-no.fnordovax.org>
	 <49A3AB75.1010805@bfh.ch>
	 <1235475578.28090.64.camel@sentry-no.fnordovax.org>
	 <49A3F43F.6000103@bfh.ch> <644FF96C-AAA8-4309-A3C8-B38EA1DE7C45@gmail.com>
	 <49A414CD.8070204@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=kjRFMsG8WkxWKPFrFjuBrI7TmpVwkejVgzzz3kwLEkI=;
        b=NkKdEbpGuHs/2RqAVLuQ1B8VZswAklfguDd6MjO/mECB47N3nkkkq8jnd6t7pBUs1R
         Vpv8BH6225YINnx6LMnyu330lhlulGLIBoJw99YnjlWPjmoE+GAO9nq9EaZx6nSJMAO5
         uO83Yg00nGkAjQ9wXR76uzOOoa+Lfn+JwDNPk=
In-Reply-To: <49A414CD.8070204-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 2009-02-24 at 16:39 +0100, Seewer Philippe wrote:
> 
> Victor Lowther wrote:
> > I run it in daemon mode so that udev does not have to wait on it. The 
> > dhclient-script creates a file when the interface is up, and any mounts 
> > that depend on the network can wait for those files to appear. ifup does 
> > the same thing with static interfaces.
> 
> I don't like the asynchronousnes of this. This means we have to wait in 
> pre-mount or mount until we have at least one interface up without any 
> knowledge if another might come up later as well.

OK, the latest change moves handling interfaces that we requested DHCP
on into a pre-mount hook, and the dhclient-script now saves all the
options it got from the server into a file that should be sourceable
(although I have not tested that yet).  Interfaces with static
assignments are still handled on the fly as we find them.  Is this
something that is more easily customizable to your requirements?

-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
