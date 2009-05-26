From: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH] dracut: make initial devices outside of initramfs
Date: Tue, 26 May 2009 22:39:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0905262237480.2270@gate.bb.dicp.net>
References: <Pine.LNX.4.58.0905231331400.2058@gate.bb.dicp.net>
 <1243305738.3584.40.camel@obelisk.thedillows.org> <20090526024454.GA10049@redhat.com>
 <1243306682.3584.42.camel@obelisk.thedillows.org>
 <Pine.LNX.4.58.0905261634470.2270@gate.bb.dicp.net> <1243349941.19603.5.camel@lap75545.ornl.gov>
 <Pine.LNX.4.58.0905261818090.2270@gate.bb.dicp.net>
 <1243367721.19603.10.camel@lap75545.ornl.gov>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1243367721.19603.10.camel-FqX9LgGZnHWDB2HL1qBt2PIbXMQ5te18@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 26 May 2009, David Dillow wrote:

> > I can push an upgrade for F10. But Centos? I'm not sure they  even have 
> > dash.
> They do.

Not in main AFAICS and EPEL doesn't have it either. So no way of me fixing 
the issue there. 

But F10 just got an updated dash built.

 
> Ok, I'm fine with carrying this locally until F10 gets fixed. I agree
> with not wanting to have to accumulate workarounds until we start
> listing supported distros.

Right, which could be an interesting excercise in itself... :/

regards,
 andreas
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
