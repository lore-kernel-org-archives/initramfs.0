From: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Subject: Re: Dracut -- Cross distribution initramfs infrastructure
Date: Wed, 17 Dec 2008 16:22:50 -0500
Message-ID: <20081217212250.GE7356@hmsreliant.think-freely.org>
References: <1229540094.28858.150.camel@aglarond.local>
	 <20081217193151.GA7356@hmsreliant.think-freely.org>
	 <1229543309.28858.163.camel@aglarond.local>
	 <ac3eb2510812171229g57eee496o6ad9e2fa97609455@mail.gmail.com>
	 <20081217210645.GC7356@hmsreliant.think-freely.org>
	 <1229548507.1229.4.camel@x61.fubar.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1229548507.1229.4.camel-v34h5/LVXhbZaaYASwVUlg@public.gmane.org>
List-Id: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Zeuthen <davidz-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>, Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cjwatson-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org, Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Wed, Dec 17, 2008 at 04:15:07PM -0500, David Zeuthen wrote:
> On Wed, 2008-12-17 at 16:06 -0500, Neil Horman wrote:
> > > Busybox is nice as an option to be able to rescue/hack. It should
> > > definitely be provided as an optional "plugin" for people who need it.
> > > But there is no chance to depend on it by default, for the very same
> > > reason klibc, or any other libc is not an option.
> > > 
> > > Full-featured distros who make their money with support, can just not
> > > afford to support tools compiled differently from the tools in the
> > > real rootfs. SUSE used klibc for one release, and stopped doing that
> > > immediately, because you go crazy if you run into problems with bootup
> > > problems on cutomer setups you can not reproduce with the tools from
> > > the real rootfs.
> > > 
> > This is all hyperbolie.  
> 
> Hardly. Having to support two different C libraries in a real production
> environment, for reasons like "just because we can" and "it's about
> freedom" is not something I ever want this project to see or support. In
> there lies madness.
> 
Either I wasn't clear, or you didn't read closely enough.  I don't use two
different c libraries, We use the same C library everywhere, busybox included.
Which is not to say you have to do that.  You can certainly use a different
library, and I agree with you there, to use two different C libraries in the
same system is rather insane.  But I don't do that, and unless you are _that_
constrained for space, you don't need to.

> FWIW, as Kay said, it's fine to have an unsupported "--with-busybox" or
> whatever option but please don't think that people using it can expect
> any kind of real support or attention to their bug reports.
> 
Seea above.
>      David
> 
> 
> 

-- 
/****************************************************
 * Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
 * Software Engineer, Red Hat
 ****************************************************/
