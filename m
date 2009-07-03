From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: initqueue
Date: Thu, 02 Jul 2009 19:04:33 -0500
Message-ID: <1246579473.3339.96.camel@sentry-no.fnordovax.org>
References: <4A4C87DF.10904@redhat.com> <4A4CAA92.9000401@bfh.ch>
	 <4A4CAD9B.10503@redhat.com> <4A4CB136.6000109@bfh.ch>
	 <4A4CB241.8080406@redhat.com> <4A4CB434.1010001@bfh.ch>
	 <4A4CBFEE.2020500@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=DCjPaCDPRGd+yQcOeXvL08+u1wzuRbLPlRrfPUB+Ac4=;
        b=IyIdUSYciFjWf5XbRhMhw763R8vGU5eShKbNzOrP83uIYYdJWkag1Vepsb9AVzRgD/
         1h8DYyFhxVDdBn4hBCQwws/S/jHevpGkaPwoo7ipXkcJlXSLpwKVKgAmkNcI6oHtoEh8
         xXkO3eiUX4vx99ng2luSEasqr3jCNgMMWOcPY=
In-Reply-To: <4A4CBFEE.2020500-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, 2009-07-02 at 16:10 +0200, Harald Hoyer wrote:
> On 07/02/2009 03:20 PM, Seewer Philippe wrote:
> >>> Why not just put cryptsetup back into mountscripts as I've suggested
> >>> before?
> >>>
> >>
> >> Because so much more can be inside the crypto partition, which might
> >> need further processing.
> >
> > That is correct. But if it's in mountscripts, it would fire more
> > udev-events which are caught again by udevadm settle. I don't see
> > a problem there.
> 
> Hmm, we maybe should think of merging pre-mount and mount.
> pre-mount makes no sense, if mounting is done inside udev rules.

I would like to chime in again with the longstanding race condition
inherent in having resume from hibernate and root fs mounting as udev
rules.

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
