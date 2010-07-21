From: Maarten Vanraes <maarten.vanraes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: patches
Date: Wed, 21 Jul 2010 17:20:02 +0200
Message-ID: <201007211720.02572.maarten.vanraes@gmail.com>
References: <201007140205.35944.maarten.vanraes@gmail.com> <201007211703.36797.maarten.vanraes@gmail.com> <4C470EAD.705@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=f1KSiUUts/7lhsHCwUnaGx4dek0e2zTjnGT8cpq0QB8=;
        b=T+6mqI+dMzi/3jzJdgRfcXQXaT3QmKr8LQGkow6px1dgG9/721cAoVt8kR/TswdCp9
         2stm3PGtAdnsnyVyqyKWJaym7WjIbfURElCbCAL8oEQz7FTXCVLTJqyDMCVQVmdomwqN
         T/zWz6JtvhN/LUMbYZR6glDKGmNlV2D0CTSbI=
In-Reply-To: <4C470EAD.705-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Op woensdag 21 juli 2010 17:13:49 schreef Harald Hoyer:
> On 07/21/2010 05:03 PM, Maarten Vanraes wrote:
> > Op woensdag 21 juli 2010 13:41:04 schreef Harald Hoyer:
> >> On 07/14/2010 02:05 AM, Maarten Vanraes wrote:
> >>> Hi,
> >>>
> >>> Here are some patches, some that were used as patches in the mandriva
> >>> builds, and a first one from me, to fix nfs hostonly on chrooted
> >>> installs.
> >>>
> >>> Kind regards,
> >>>
> >>> Maarten Vanraes
> >>
> >> Pushed the conffile patch and the bootchartd patch, but I disabled
> >>   bootchartd by default.
> >> Users can always add "-a bootchartd" on image creation or add it to
> >> /etc/dracut.conf.d/myconf.conf.
> >
> > well, i think the bootchartd one only works if you have bootchartd? or am
> > i mistaken?
> 
> Sure, but even if you have bootchartd installed, you might not want it.

well, imo, by default NO modules should be selected (in the future); and 
generic would make it use all, while hostonly would detect only those you 
have. but that's for the future anyway.
 
> > in any case i'm fine with it. those patches come from the Mandriva tree,
> > and the less patches need to be maintained, the better.
> 
