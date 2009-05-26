From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [PATCH] dracut: make initial devices outside of initramfs
Date: Tue, 26 May 2009 15:53:37 -0400
Message-ID: <1243367617.19603.8.camel@lap75545.ornl.gov>
References: <Pine.LNX.4.58.0905231331400.2058@gate.bb.dicp.net>
 <1243305738.3584.40.camel@obelisk.thedillows.org>
 <20090526024454.GA10049@redhat.com>
 <1243306682.3584.42.camel@obelisk.thedillows.org>
 <Pine.LNX.4.58.0905261634470.2270@gate.bb.dicp.net>
 <1243349941.19603.5.camel@lap75545.ornl.gov> <4A1C159B.1070009@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <4A1C159B.1070009-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Tue, 2009-05-26 at 18:15 +0200, Harald Hoyer wrote:
> On 05/26/2009 04:59 PM, David Dillow wrote:
> > If I need to carry this locally, I don't mind, but I figure others could
> > use the fix when working on the initramfs.
>
> just omit the dash module for debugging purposes :)
> 
> dracut --omit dash

Yeah, but I want to be a good citizen and make sure my scripts work with
dash, which often requires debugging. :)

If you guys don't want to put in fixes for this, I'm fine with carrying
it locally. I can understand not wanting to work around every broken
utility out there, but at some point it may make sense to list the
distro's we're going to explicitly support, and then we may want to have
workarounds available for the tools provided.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
