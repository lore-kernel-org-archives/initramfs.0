From: "Kay Sievers" <kay.sievers-tD+1rO4QERM@public.gmane.org>
Subject: Re: Dracut -- Cross distribution initramfs infrastructure
Date: Wed, 17 Dec 2008 21:29:51 +0100
Message-ID: <ac3eb2510812171229g57eee496o6ad9e2fa97609455@mail.gmail.com>
References: <1229540094.28858.150.camel@aglarond.local>
	 <20081217193151.GA7356@hmsreliant.think-freely.org>
	 <1229543309.28858.163.camel@aglarond.local>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
In-Reply-To: <1229543309.28858.163.camel-T9xAYgMuJli44ywRPIzf9A@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cjwatson-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org, Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Wed, Dec 17, 2008 at 20:48, Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On Wed, 2008-12-17 at 14:31 -0500, Neil Horman wrote:
>> Not that I don't think a unifying tool to create an initramfs is a bad idea
>> (quite the contrary, I think it would be great), but I'd like to point out that
>> one of your underlying premises is a bit shaky.  That an initramfs has one
>> purpose, that being to get the rootfs mounted, isn't entirely accurate.  Kdump
>> and various embedded systems being the prime examples here.  Many embedded
>> systems run entirely out of the initramfs, and contain all the code they need to
>> do so in them.  Additionally, kdump in most environments, attemps to capture
>> core files entirely from the initramfs as well, operating under the assumption
>> that the rootfs may not be functioning properly after a crash.  By and large
>> these initramfs images tend to be larger and offer a more typical (if not
>> standard) user operating environment.
>
> While I'd like to think that embedded systems are not going to do
> something custom, you, I and everyone else know that's unlikely. ;-)
>
> The kdump case is one that I think is at least reasonable to get to
> eventually (and also, installer initramfsen), but I think that getting
> the cases of "initramfs for booting a system" consolidated first makes
> the most sense.

Maybe Bernhard Walle, who currently maintains the SUSE initramfs, can
possibly take care of that. He's is working on kdump stuff.

>> I'm looking at your tree now, and it
>> looks like a good start on standardizing the initramfs for the nominal case.  Do
>> you have plans to include (or are you interested in including) support for
>> alternate infrastructure (like busybox instead of nash), interactive setup, etc?
>
> Well, the use of nash right now is due to the fact that there isn't
> historically any switchroot utility shipped in util-linux.  Hopefully
> we'll get something there and then the only user of nash that's there
> right now can go away.

SUSE uses a small binary run-init copied from klibc:
  http://git.kernel.org/?p=libs/klibc/klibc.git;a=blob;f=usr/kinit/run-init/run-init.c;hb=HEAD
 Maybe it's time to add something like that to util-linux? Karel?

> busybox, etc are really all just extra pain as compared to using real
> system utilities... once you accept that you're dynamically linked,
> you're better off just maintaining one set of the utilities as opposed
> to having one set in coreutils and one set in busybox.

Busybox is nice as an option to be able to rescue/hack. It should
definitely be provided as an optional "plugin" for people who need it.
But there is no chance to depend on it by default, for the very same
reason klibc, or any other libc is not an option.

Full-featured distros who make their money with support, can just not
afford to support tools compiled differently from the tools in the
real rootfs. SUSE used klibc for one release, and stopped doing that
immediately, because you go crazy if you run into problems with bootup
problems on cutomer setups you can not reproduce with the tools from
the real rootfs.

We need to use tools in initramfs which will not work realibly, or not
at all, with other libcs. We will have one dynamic glibc there anyway,
so there is no valid reason to also use any single statically linked
binary, or any other libc by default. Really, it's just nice to use
the same environment in the real root and in initramfs, and you also
get the smallest possible size that way, if you need to include only a
single "advanced" tool.

Thanks,
Kay
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
