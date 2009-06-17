From: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Re: including python in the initramfs
Date: Wed, 17 Jun 2009 09:28:39 +0100
Message-ID: <1245227319.2158.4.camel@polyethylene>
References: <1245174031.2150.67.camel@polyethylene>
	 <A4EC33E8-3A45-4A6B-AE97-5B48EA425F75@gmail.com>
	 <1245178189.2150.76.camel@polyethylene> <4A37EA8E.7090508@redhat.com>
	 <4A38960B.20305@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=snCCcU7xSq6pfPY8bHf55AAKAtrPQVidxIeEQ82IQrU=;
        b=LzChaJxCwA6cvtfLRf2tLMECtdck0+ifNM7MpAI0INLyKQlf411KLHyN0qSwICWY1r
         pvkpJXNHPUvf4Vh84qJZq60nF3vVEyNnWMztCjbNMi8qEuQz9OcF4xa3+2WsaLSUoc31
         1UgVTX1yPbc6KHzY6fBoU3w0fc7yQkINH3Z0U=
In-Reply-To: <4A38960B.20305-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, 2009-06-17 at 09:06 +0200, Seewer Philippe wrote:
> Warren Togami wrote:
> [snip]
> > This is a good case for the modules.d design of dracut.  Write your own 
> > module that does whatever you want, and install that module only in 
> > cases where you generate the initrd for your XO.  Your special module 
> > does not belong in dracut upstream.
> 
> I agree. That's what the module system is designed for among other 
> things. Have a look at README.modules and the currently available 
> modules, that should give you an idea on how to proceed.

Yes, thanks. The module system is excellent and I've already been
crafting my work as a module. Dracut is perfect in this respect.

I was just interested in the opportunity of getting some or all of our
work upstream, hence "doing it right" from the start. But I guess we're
still a bit too nutty for that. (whatever you do, don't ask about our
previous initramfs setup!)

Daniel


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
