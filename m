From: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH] dracut: make initial devices outside of initramfs
Date: Tue, 26 May 2009 16:36:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0905261634470.2270@gate.bb.dicp.net>
References: <Pine.LNX.4.58.0905231331400.2058@gate.bb.dicp.net> 
 <1243305738.3584.40.camel@obelisk.thedillows.org>  <20090526024454.GA10049@redhat.com>
 <1243306682.3584.42.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1243306682.3584.42.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 25 May 2009, David Dillow wrote:

> Bummer, that. And while it makes the initial dash able to give us
> stderr, it doesn't fix the emergency shell. Of course, I noticed this
> after hitting send... so bad patch all around. :(

I think the patch is unnecessary in any case.

Dash loosing stderr when /dev/tty is unavailable is a dash bug. It's been 
fixed in upstream git and the patch has been applied to rawhide and F11.

I think the problem should be considered fixed and we won't have to
introduce workarounds like pre-creating device nodes.

regards,
 andreas
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
