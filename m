From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dracut broken on Fedora 10 (udevd)
Date: Mon, 01 Jun 2009 04:15:49 -0500
Message-ID: <1243847749.647.8.camel@sentry-no.fnordovax.org>
References: <1243833431.3844.4.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=IQSzkHeIa4LvnoBEnW/isGJ/MV822BL3yNEdM/iP2bo=;
        b=sZn5x1y9Dnwi4Yg/8JOftvu7iT6KlUbcIKyLJhheg00S0hD1JnXfGMqt2NA5Q/+Kan
         N3LoTEDln0csowFjJEZEWaZ/X61lV24/A0EmCyMNNP0NUHrraluBTAe80iDWVE+BdE9o
         iGOfLBPyCZrKJ6sbs3Z3cONaF/CbwH3AbNJKw=
In-Reply-To: <1243833431.3844.4.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, 2009-06-01 at 01:17 -0400, David Dillow wrote:
> Victor, commit 5033486389038516acc04403e9e2c3ba9653a98e broke dracut on
> F10, as the udev there does not understand the --resolve-names option.

Sorry about that, fixed. Testing with F11 ATM, so it slipped by.

> Perhaps we can find a way to let dracut populate /etc/passwd
> and /etc/group with some default user/group names to satisfy older
> udevs? I realize this is a workaround for older utilities, so I don't
> expect anyone to go for it, but I'll ask anyways.

It shouldn't really be a problem -- I wouldn't exactly call Fedora 10
legacy unsupported code yet. :)

If you need to pull in /etc/group and /etc/passwd, make sure you also
pull in whatever version of libnss_files you need -- glibc loads them on
the fly, so the usual library depsolving magic does not work. 

> I need an 'rpc' user for rpcbind anyways, so we could just put dummies
> in for that, since I don't care who really owns that data -- it'll be
> thrown away anyways.

It might be useful to make grabbing subsets of /etc/group,/etc/passwd,
and libnss into a function for dracut modules to call.  How to do that
in a sufficiently elegant fashion is a bit beyond me ATM.

> Thanks,
> Dave
> 
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
