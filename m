From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Passing dhclient leases through switch_root
Date: Mon, 01 Jun 2009 17:46:50 -0500
Message-ID: <1243896410.647.35.camel@sentry-no.fnordovax.org>
References: <4A244FF4.9040905@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=OUaTtxNMgMYpBd/U9OrdYg1PacRbRC2YocKUsjNvCYM=;
        b=Crx1C89XCGyy/UeSkZXSsBAyweIo8o+U8k/TgcRBBkYA4HVQURK0oTPZQwoBERG+mA
         Yd7ACFraUoLAh+2Neb8SfF9qjkeklY9KN1w6IgjOWGwtv+iEPBCVshjC8GgYC0nRyBZZ
         SsaHURDHBZC1jvGgSG0+ZYk/cvmPX1mAil+fs=
In-Reply-To: <4A244FF4.9040905-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, 2009-06-01 at 18:02 -0400, Warren Togami wrote:
> cp /var/lib/dhclient/dhclient.leases /sysroot/dev/.dhclient-$dev.leases
> 
> mkinitrd for a while has copied the leases file to /dev, because it is 
> the only directory that survives switch_root.  The system then can have 
> the entire leases file for whatever needed purposes.
> 
> Any objections to doing this in dracut?

None here.  We should do something along those lines for /tmp if we were
asked to debug the initrd.

> Warren Togami
> wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
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
