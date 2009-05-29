From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: TODO: instmods() firmware is broken
Date: Fri, 29 May 2009 06:54:55 -0500
Message-ID: <1243598095.31156.6.camel@sentry-no.fnordovax.org>
References: <4A1EE0B7.4030907@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=v0ATkdI5yhd+YO8uhwjY180pvKpHQEKGX4BD3ydfOYo=;
        b=tP1JZUDtXRLNi4+HxgtH1yUKX4W5zIzWwrSP+7EZrsvFEfakS4RYsmSAMlb8BAG84a
         P0KzyvdcaMUn/FkFM+i43QBQPT7zGotuUsE6+lEdGvszJTfzMyaDrgY1BgMwf1PW28LG
         zgEVzuk+nkPeRIQFJ/ObtosJ4+pNkXr9qMs5o=
In-Reply-To: <4A1EE0B7.4030907-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, 2009-05-28 at 15:06 -0400, Warren Togami wrote:
> Note this as a TODO if you want some drivers to be usable during the initrd.
> 
> dracut-functions instmods() seems to be broken in that it only looks for 
> firmware in cases where instmods() was called with a single module as a 
> parameter.  Most drivers are copied by dracut as the result of 
> =groupname groups, thus firmware is not being copied for storage and 
> network drivers.
> 
> A better fix might be to wait until all installs are done, then run a 
> modinfo loop across all copied .ko's to install all firmware?

Or to call modinfo only when instmods is actually installing a module,
and not when it is expanding module shorthand.

Which is what one of the patches I just pushed to the repo does.

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
