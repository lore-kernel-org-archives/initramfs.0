From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/3] allow network setup without netroot
Date: Thu, 12 Jan 2012 12:06:14 -0500
Message-ID: <20120112170611.GA26875@metroid.usersys.redhat.com>
References: <1326304109-32652-1-git-send-email-wwoods@redhat.com>
 <1326304109-32652-3-git-send-email-wwoods@redhat.com>
 <20120111210614.GB14024@metroid.usersys.redhat.com>
 <4F0E3CB1.3080607@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F0E3CB1.3080607-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Jan 12, 2012 at 09:51:45AM +0800, Dave Young wrote:
> > Maybe a 'dummyroot' netroot "handler" that doesn't do anything would be
> > better - that way anything that wants to trigger when the network is up
> > can just add items to the 'netroot' hook, and they'll run like normal
> > netroot hooks.
[...]
> Yes, dummy netroot is a reasonable idea for automatically bring up
> network, but I still do not want to lose the manual setup option.
> I'd like to have both :)

Right - they're different problems with different solutions.

I'm looking into automatic network setup for non-netroot systems because
I'm trying to replicate a lot of the stuff that anaconda (the RH/Fedora
installer) used to do in its own custom initramfs system - like fetching
updates, driver disks, and the runtime root filesystem image from the
network.

Fetching the runtime image is already done - see modules.d/90livenet.

I've got nearly-finished code for the "rd.live.updates" argument,
which would let us push out (or test) bugfixes for LiveCDs after
they've been burned/released. (Which would be nice!)

Driver disks I'm still working on, but that'll be coming soon too.

Anyway, that stuff is all pretty separate from what it sounds like you're
working on - so I think there's definitely room for both. No worries.

-w
