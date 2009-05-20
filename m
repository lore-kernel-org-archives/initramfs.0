From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: wiki, README and TODO update
Date: Wed, 20 May 2009 08:55:47 +0200
Message-ID: <4A13A973.4060703@bfh.ch>
References: <4A098CB5.2070006@redhat.com>	 <1242351147.29452.2.camel@sentry-no.us.dell.com> <1242355988.5107.4.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1242355988.5107.4.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



David Dillow wrote:
[snip]
> These all trigger off of udev events, though I recall there was some
> discussion about whether that was the way to go or not. In many ways,
> they are just polish on some of the network patches that have been
> posted here before (by you two, IIRC).

The consesus was to try and do as much as possible from within udev.

I've been fiddling a bit with udev trying to improve the network patches 
I sent a while ago but I can't get to the point where I'm able to tell 
udev that a network device was configured. Detected: yes. Configured: 
no. Ideas are welcome.

Regards,
Philippe

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
