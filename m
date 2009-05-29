From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: TODO: instmods() firmware is broken
Date: Fri, 29 May 2009 17:54:32 -0500
Message-ID: <1243637672.31156.22.camel@sentry-no.fnordovax.org>
References: <4A1EE0B7.4030907@redhat.com>
	 <1243598095.31156.6.camel@sentry-no.fnordovax.org>
	 <4A206029.9050307@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=8Zfi9HwVSqUicGr6DTQDfmYMTlUInNH9xMBpS209+80=;
        b=eJ08Pp0rRpKmHzEYZ+KROkAHbEl0LbaUDN4pWephQ720Ts1mwADmP2JhG/P14HqTd8
         1E+zHj0Li/TSvRqChFEQF9g6Ccln9VtLrZCPhdzUGSUj99DjvwuCK4X521e2oWa9l2yb
         TMfsWmA4AiVmXS3x/1m3GSAkihR9fanXFY/zQ=
In-Reply-To: <4A206029.9050307-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, 2009-05-29 at 18:22 -0400, Warren Togami wrote:
> On 05/29/2009 07:54 AM, Victor Lowther wrote:
> > Or to call modinfo only when instmods is actually installing a module,
> > and not when it is expanding module shorthand.
> >
> > Which is what one of the patches I just pushed to the repo does.
> 
> So looks like not a bug, but is it really necessary to print all this?

Good question.  I originally didn't. Harald?

> W: Possible missing firmware /lib/firmware/FW13 for module b43.ko
> W: Possible missing firmware /lib/firmware/iwlwifi-5150-1.ucode for 
> module iwlagn.ko
> W: Possible missing firmware /lib/firmware/isl3886pci for module p54pci.ko
> W: Possible missing firmware /lib/firmware/isl3887usb for module p54usb.ko
> W: Possible missing firmware /lib/firmware/isl3886usb for module p54usb.ko
> W: Possible missing firmware /lib/firmware/FW10 for module b43legacy.ko
> W: Possible missing firmware /lib/firmware/i2400m-fw-sdio-1.4.sbcf for 
> module i2400m-sdio.ko
> W: Possible missing firmware /lib/firmware/i2400m-fw-usb-1.4.sbcf for 
> module i2400m-usb.ko
> W: Possible missing firmware /lib/firmware/FW13 for module b43.ko
> W: Possible missing firmware /lib/firmware/FW10 for module b43legacy.ko
> W: Possible missing firmware /lib/firmware/isl3886pci for module p54pci.ko
> W: Possible missing firmware /lib/firmware/isl3887usb for module p54usb.ko
> W: Possible missing firmware /lib/firmware/isl3886usb for module p54usb.ko
> W: Possible missing firmware /lib/firmware/aic94xx-seq.fw for module 
> aic94xx.ko
> W: Possible missing firmware /lib/firmware/ql8100_fw.bin for module 
> qla2xxx.ko
> W: Possible missing firmware /lib/firmware/ql2500_fw.bin for module 
> qla2xxx.ko
> W: Possible missing firmware /lib/firmware/ql2400_fw.bin for module 
> qla2xxx.ko
> W: Possible missing firmware /lib/firmware/ql2322_fw.bin for module 
> qla2xxx.ko
> W: Possible missing firmware /lib/firmware/ql2300_fw.bin for module 
> qla2xxx.ko
> W: Possible missing firmware /lib/firmware/ql2200_fw.bin for module 
> qla2xxx.ko
> W: Possible missing firmware /lib/firmware/ql2100_fw.bin for module 
> qla2xxx.ko
> 101213 blocks
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
