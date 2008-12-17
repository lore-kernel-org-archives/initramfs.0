From: David Zeuthen <davidz-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Dracut -- Cross distribution initramfs infrastructure
Date: Wed, 17 Dec 2008 16:15:07 -0500
Message-ID: <1229548507.1229.4.camel@x61.fubar.dk>
References: <1229540094.28858.150.camel@aglarond.local>
	 <20081217193151.GA7356@hmsreliant.think-freely.org>
	 <1229543309.28858.163.camel@aglarond.local>
	 <ac3eb2510812171229g57eee496o6ad9e2fa97609455@mail.gmail.com>
	 <20081217210645.GC7356@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: davidz-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
In-Reply-To: <20081217210645.GC7356-B26myB8xz7F8NnZeBjwnZQMhkBWG/bsMQH7oEaQurus@public.gmane.org>
List-Id: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Cc: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>, Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cjwatson-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org, Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Wed, 2008-12-17 at 16:06 -0500, Neil Horman wrote:
> > Busybox is nice as an option to be able to rescue/hack. It should
> > definitely be provided as an optional "plugin" for people who need it.
> > But there is no chance to depend on it by default, for the very same
> > reason klibc, or any other libc is not an option.
> > 
> > Full-featured distros who make their money with support, can just not
> > afford to support tools compiled differently from the tools in the
> > real rootfs. SUSE used klibc for one release, and stopped doing that
> > immediately, because you go crazy if you run into problems with bootup
> > problems on cutomer setups you can not reproduce with the tools from
> > the real rootfs.
> > 
> This is all hyperbolie.  

Hardly. Having to support two different C libraries in a real production
environment, for reasons like "just because we can" and "it's about
freedom" is not something I ever want this project to see or support. In
there lies madness.

FWIW, as Kay said, it's fine to have an unsupported "--with-busybox" or
whatever option but please don't think that people using it can expect
any kind of real support or attention to their bug reports.

     David

