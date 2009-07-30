From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: Broken substitution
Date: Wed, 29 Jul 2009 21:57:13 -0400
Message-ID: <1248919033.3564.10.camel@obelisk.thedillows.org>
References: <4A70BB67.7030803@redhat.com>
	 <1248903464.19166.43.camel@lap75545.ornl.gov> <4A70C190.6050902@redhat.com>
	 <1248908439.8777.9.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1248908439.8777.9.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, 2009-07-29 at 19:00 -0400, David Dillow wrote:
> > > On Wed, 2009-07-29 at 17:13 -0400, Warren Togami wrote:
> > >> Upstream dhclient writes out \032 instead of a space if multiple search
> > >> domains are specified in dhcpd.conf.  It has been this way for years.
> > >> Debian and Fedora have worked around this by doing the below bash
> > >> substitution.  Upstream has rejected fixing this in dhclient for
> > >> different reasons.

> Can we get dhclient to fix this obvious bug, even if they won't fix the
> real issue? We've tried to avoid working around tool bugs in the past,
> and as I understand it, this is a combo dhclient bug and DHCP server
> configuration bug, so is it really important to work around it?

Are you sure this bites with dhcpd.conf, and not just dhclient.conf? I
was trying to find a recent bug report on this to get more info, and
while I found a few [1-5], they all reference dhclient.conf. They are
also a bit old, so perhaps you know of something more recent.

Currently, we install our own dhclient.conf, so this shouldn't bite us
unless there is a server component as well. We may want to change that
at some point, which has its own hairy issues with respect to merging
the option lists...

[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=492500
[2] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=461056
[3] https://bugs.launchpad.net/ubuntu/+source/dhcp3/+bug/275288
[4] https://bugzilla.redhat.com/show_bug.cgi?id=450042
[5] https://bugzilla.redhat.com/show_bug.cgi?id=458555

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
