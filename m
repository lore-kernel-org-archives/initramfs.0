From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: Broken substitution
Date: Wed, 29 Jul 2009 19:00:39 -0400
Message-ID: <1248908439.8777.9.camel@obelisk.thedillows.org>
References: <4A70BB67.7030803@redhat.com>
	 <1248903464.19166.43.camel@lap75545.ornl.gov> <4A70C190.6050902@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A70C190.6050902-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, 2009-07-29 at 17:39 -0400, Warren Togami wrote:
> On 07/29/2009 05:37 PM, David Dillow wrote:
> > On Wed, 2009-07-29 at 17:13 -0400, Warren Togami wrote:
> >> Upstream dhclient writes out \032 instead of a space if multiple search
> >> domains are specified in dhcpd.conf.  It has been this way for years.
> >> Debian and Fedora have worked around this by doing the below bash
> >> substitution.  Upstream has rejected fixing this in dhclient for
> >> different reasons.
> >>
> >> The substitution below works on bash but not dash.
> >>
> >> Dillow suggested this method that will work with bash and dash.
> >> Unfortunately I now noticed that this seems to remove the space between
> >> search domain entries.
> >
> > What are you talking about?
> >
> > # dash
> > $ t="1 2"
> > $ printf "$t"
> > 1 2$
> >
> 
> It handles an actual space just fine.  But not the broken \032 space 
> from dhclient.

Ok, it looked link a space in the terminal, but when I went to copy it
into this mail to show that I still could not reproduce the problem, I
noticed the actual issue -- \032 is not a space, it is ctrl-Z (0x1a, or
SUB).

Can we get dhclient to fix this obvious bug, even if they won't fix the
real issue? We've tried to avoid working around tool bugs in the past,
and as I understand it, this is a combo dhclient bug and DHCP server
configuration bug, so is it really important to work around it?

There may be a way to build a loop to convert instances of \032 to
spaces, but it will be ugly.

Or perhaps printf and a few games with IFS.


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
