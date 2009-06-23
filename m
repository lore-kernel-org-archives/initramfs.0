From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: 13 NFS syntax variations
Date: Tue, 23 Jun 2009 00:34:23 -0400
Message-ID: <1245731663.13352.130.camel@obelisk.thedillows.org>
References: <4A39A9AF.6070009@redhat.com> <4A3A13A8.6050100@bfh.ch>
	 <4A3FEFE7.7080907@redhat.com>
	 <1245709757.13352.20.camel@obelisk.thedillows.org>
	 <4A4056EA.9010102@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A4056EA.9010102-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Tue, 2009-06-23 at 00:15 -0400, Warren Togami wrote:
> root=<server-ip>:/path:nfs-options
> 
> Yes, I am aware it has existed for decades.  However neither Red Hat nor 
> Debian's tools supported this method.[1]  This seems to make it a good 
> candidate for chopping.

Industry practice outside of Red Hat or Debian doesn't count? Then I
guess it is a good thing that Debian's initramfs-tools supports it,
albeit without options. 

> Harald, what do you think?

I'm sure he'll speak his own mind, but I'll point out he re-added the
syntax in commit 1e885ccd


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
