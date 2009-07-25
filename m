From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: Re: initramfs-tools stable release 0.93.3
Date: Sat, 25 Jul 2009 11:21:59 +0200
Message-ID: <20090725092159.GJ11967@stro.at>
References: <20090610153017.GA19401@stro.at>
 <1244716927.4532.34.camel@quest>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1244716927.4532.34.camel@quest>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Scott James Remnant <scott-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org

On Thu, 11 Jun 2009, Scott James Remnant wrote:

> On Wed, 2009-06-10 at 17:30 +0200, maximilian attems wrote:
> 
> > hook-functions: Add i915 module for kms.
> > 
> This is exactly the kind of bloat I want to avoid for the initramfs.
> The initramfs should do one thing only, that's mount the root filesystem
> and chain load into it.

well it is useful to resume or to load acpi modules early so boxes don't
overheat. also there are quite some different scenarios your root can be
on.
 
> Anything else is an extravagance.
> 
> Why load the KMS driver in the initramfs?  Because it takes too long to
> get to the point in the real system where we can load it!  Why does it
> take too long to get there?  Because we spend so long in the initramfs!

fb modules got scrammed in the initramfs from early on since
the time of jbailey.
 
> Slimming the initramfs right down to the essentials reduces the boot
> time by over a second!  Paradoxically, this means that the driver can be
> loaded in the real system at roughly the same time point as it would be
> loaded in a bloated initramfs.

well afair the intel fast boot doesn't use initramfs in the fast path
at all, what are you up to axe. on irc you mentioned locales (which
are not in initramfs), fonts (detto), keymaps (only if you have cryptsetup
installed), splash screen (you need to have the relevant installed)
and kms.



--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
