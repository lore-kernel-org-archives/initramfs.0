From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Dracut -- Cross distribution initramfs infrastructure
Date: Thu, 18 Dec 2008 15:07:24 +0100
Message-ID: <20081218140724.GD2930@nb.net.home>
References: <1229540094.28858.150.camel@aglarond.local> <20081217193151.GA7356@hmsreliant.think-freely.org> <1229543309.28858.163.camel@aglarond.local> <ac3eb2510812171229g57eee496o6ad9e2fa97609455@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ac3eb2510812171229g57eee496o6ad9e2fa97609455-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Cc: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cjwatson-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org

On Wed, Dec 17, 2008 at 09:29:51PM +0100, Kay Sievers wrote:
> On Wed, Dec 17, 2008 at 20:48, Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > On Wed, 2008-12-17 at 14:31 -0500, Neil Horman wrote:
> >> Not that I don't think a unifying tool to create an initramfs is a bad idea

 I'm personally very happy to see that someone is trying to work on
 distro-independent solution. Really.

> >> looks like a good start on standardizing the initramfs for the nominal case.  Do
> >> you have plans to include (or are you interested in including) support for
> >> alternate infrastructure (like busybox instead of nash), interactive setup, etc?
> >
> > Well, the use of nash right now is due to the fact that there isn't
> > historically any switchroot utility shipped in util-linux.  Hopefully

 util-linux-ng is open for arbitrary low-level stuff that makes sense
 for more distributions.

> > busybox, etc are really all just extra pain as compared to using real
> > system utilities... once you accept that you're dynamically linked,
> > you're better off just maintaining one set of the utilities as opposed
> > to having one set in coreutils and one set in busybox.
> 
> Busybox is nice as an option to be able to rescue/hack. It should
> definitely be provided as an optional "plugin" for people who need it.
> But there is no chance to depend on it by default, for the very same
> reason klibc, or any other libc is not an option.

 Note, some tools from uti-linux-ng is possible to link against klibc,
 and the whole package should be possible to rebuild on systems with
 uClibc, but the official goal is glibc.

> We need to use tools in initramfs which will not work realibly, or not
> at all, with other libcs. We will have one dynamic glibc there anyway,
> so there is no valid reason to also use any single statically linked
> binary, or any other libc by default. Really, it's just nice to use
> the same environment in the real root and in initramfs, and you also
> get the smallest possible size that way, if you need to include only a
> single "advanced" tool.

 Yeah.

 I don't like nash too much (sorry RH:-). The single "advanced" tools
 usually suck in mainstream distributions -- it's a way how duplicate
 code, how maintain two different environments, etc... My tiny network
 router uses busybox, but I don't think that my workstation with 2GB
 of RAM has to use a special single "advanced" tool when my
 distribution includes coreutils, util-linux and udev.

    Karel

-- 
 Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
