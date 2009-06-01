From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [RFC PATCH 5/9] resume: add support for labeled resume devices
Date: Mon, 01 Jun 2009 06:55:27 -0400
Message-ID: <1243853727.3844.123.camel@obelisk.thedillows.org>
References: <cover.1243833882.git.dave@thedillows.org>
	 <9810ce7e38ec1ba52a9c2f5f5047ea779d1006a3.1243833882.git.dave@thedillows.org>
	 <1243848618.647.15.camel@sentry-no.fnordovax.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1243848618.647.15.camel-76q0VzFBGGr21HsLBtNmTckMGDeJXHgy@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, 2009-06-01 at 04:30 -0500, Victor Lowther wrote:
> On Mon, 2009-06-01 at 00:25 -0400, David Dillow wrote:
> > --- a/modules.d/95resume/install
> > +++ b/modules.d/95resume/install
> > @@ -1,5 +1,4 @@
> >  #!/bin/bash
> > -dracut_install echo
> 
> erm, not exactly.
> 
> > --- a/modules.d/95resume/resume-genrules.sh
> > +++ b/modules.d/95resume/resume-genrules.sh
> > @@ -1,6 +1,8 @@
> > -resume=$(getarg resume=) && ! getarg noresume  && {
> > -(
> > -	/bin/echo -e 'KERNEL=="'${resume#/dev/}'", RUN+="/bin/echo %M:%m > /sys/power/resume"'
> > -	/bin/echo -e 'SYMLINK=="'${resume#/dev/}'", RUN+="/bin/echo %M:%m > /sys/power/resume"'
> > -) >> /etc/udev/rules.d/99-resume.rules
> > -}
> 
> The real dependency is in the RUN+= part.

Of course, and it is obvious. -ESLEEPY is my excuse.

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
