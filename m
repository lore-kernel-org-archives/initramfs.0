From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: How do we want to handle configuring network boot devices?
Date: Wed, 27 May 2009 20:40:25 -0400
Message-ID: <1243471225.23466.34.camel@obelisk.thedillows.org>
References: <1243126816.4217.248.camel@obelisk.thedillows.org>
	 <4A1DB696.9060807@redhat.com>
	 <1243470194.23466.32.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1243470194.23466.32.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, 2009-05-27 at 20:23 -0400, David Dillow wrote:
> On Wed, 2009-05-27 at 17:54 -0400, Warren Togami wrote:
> > This is an abomination.  I haven't anyone ever use this. In-kernel dhcp 
> > client?  How do you control which interface to use? 
>
> ip= lines are also parsed by the kernel and can be used for this.

I should also note that this only takes effect if CONFIG_IP_PNP is set,
which is again not the case for most distros.


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
