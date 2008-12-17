From: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Dracut -- Cross distribution initramfs infrastructure
Date: Wed, 17 Dec 2008 14:48:29 -0500
Message-ID: <1229543309.28858.163.camel@aglarond.local>
References: <1229540094.28858.150.camel@aglarond.local>
	 <20081217193151.GA7356@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
In-Reply-To: <20081217193151.GA7356-B26myB8xz7F8NnZeBjwnZQMhkBWG/bsMQH7oEaQurus@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>, cjwatson-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org

(Removing lkml from the cc)

On Wed, 2008-12-17 at 14:31 -0500, Neil Horman wrote:
> Not that I don't think a unifying tool to create an initramfs is a bad idea
> (quite the contrary, I think it would be great), but I'd like to point out that
> one of your underlying premises is a bit shaky.  That an initramfs has one
> purpose, that being to get the rootfs mounted, isn't entirely accurate.  Kdump
> and various embedded systems being the prime examples here.  Many embedded
> systems run entirely out of the initramfs, and contain all the code they need to
> do so in them.  Additionally, kdump in most environments, attemps to capture
> core files entirely from the initramfs as well, operating under the assumption
> that the rootfs may not be functioning properly after a crash.  By and large
> these initramfs images tend to be larger and offer a more typical (if not
> standard) user operating environment.  

While I'd like to think that embedded systems are not going to do
something custom, you, I and everyone else know that's unlikely. ;-)

The kdump case is one that I think is at least reasonable to get to
eventually (and also, installer initramfsen), but I think that getting
the cases of "initramfs for booting a system" consolidated first makes
the most sense.  

> I'm looking at your tree now, and it
> looks like a good start on standardizing the initramfs for the nominal case.  Do
> you have plans to include (or are you interested in including) support for
> alternate infrastructure (like busybox instead of nash), interactive setup, etc?

Well, the use of nash right now is due to the fact that there isn't
historically any switchroot utility shipped in util-linux.  Hopefully
we'll get something there and then the only user of nash that's there
right now can go away.  

busybox, etc are really all just extra pain as compared to using real
system utilities... once you accept that you're dynamically linked,
you're better off just maintaining one set of the utilities as opposed
to having one set in coreutils and one set in busybox.

Jeremy

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
