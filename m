From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: module 90kernel-modules-loaded
Date: Fri, 06 Mar 2009 11:43:11 -0600
Message-ID: <1236361391.6517.0.camel@sentry-no.fnordovax.org>
References: <49B1439A.7030208@redhat.com>
	 <20090306160822.GD10711@nostromo.devel.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=HfaEWOKT25AiPq415XDt8Veu1MWRAsoT/Q6RxpaqFMk=;
        b=jgcgIQ78aK2CFfGBrPkqWaFEvIwHyNdRVCq1Jccvwy5OCPfUtxfv6ahVTQ84dhPKzu
         ohhbTUcU3zY5FipNAup4hDNcdmXLvYPPVeFAC9uYKKfbWcRMCFaVQoxVdRvsvypDqQHy
         qut6KDewFglhlJZ1VVee9mpNm6A7DXhUdXmeo=
In-Reply-To: <20090306160822.GD10711-Zdt1ptygihhQcNjhGXsBABcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, 2009-03-06 at 11:08 -0500, Bill Nottingham wrote:
> Harald Hoyer (harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org) said: 
> > Added 90kernel-modules-loaded to be used instead or additionally to  
> > 90kernel-modules, which just installs all currently loaded modules to 
> > initrd.
> >
> > branch "merged" on:
> >
> > http://git.surfsite.org/dracut.git
> > git://surfsite.org/pub/git/dracut.git
> 
> Wasn't the entire point to make the initramfs generic?

No, to make the initramfs generator generic. A subtle but important
distinction.

> Bill
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
