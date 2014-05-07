From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Intend of hostonly-cmdline?
Date: Wed, 07 May 2014 15:40:57 +0200
Message-ID: <1706311.vdFaWiovt6@skinner>
References: <2263850.UM9clb02rz@skinner> <536A19D7.2010405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <536A19D7.2010405-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wednesday, May 07, 2014 01:32:39 PM Harald Hoyer wrote:
> On 07.05.2014 13:12, Thomas Renninger wrote:
...
> 
> hostonly stores config files like mdadm.conf and only installs those kernel
> modules, which are specific to the machine.
> 
> hostonly-cmdline also stores dracut specific kernel cmdline parameters to
> boot the system in the initramfs, so that basically you could boot the
> system by only specifying "root=" on the kernel cmdline.

Ok, so both: hostonly and hostonly-cmdline stores hostonly specific stuff into
the initrd.
That means this has nothing to do with a generic initrd and
hostonly-cmdline only makes sense together with hostonly option, right?

> The advantage of hostonly-cmdline is that the kernel cmdline does not need
> complex rd.md.uuid=... or rd.luks.uuid=... parameters.
> 
> The disadvantage is that in case of uuid or disk changes, you cannot alter
> the parameters which are in the initramfs.
> 
> I suggest to use the output of:
> 
> # dracut --print-cmdline
> 
> and add it to the kernel command line.
> 
> hostonly-cmdline should only be used, when e.g. the maximum char limit of
> the kernel command line would be reached or when the user has a generic
> rescue image, to be used when the disk layout changed and the user has not
> generated a new initramfs with it.
> 
> Maybe we could let hostonly-cmdline be the default and add a parameter
> "rd.cmdline.conf=0", which turns of parsing $initrd/etc/cmdline.d/*.conf.
> 
> Thoughts?

Most parameters are unique and if it is ensured that:
single getarg and friends calls prefer the (real)
kernel cmdline parameter over the faked one, it should more or less be safe
and things can still be overridden via kernel cmdline.

Don't know whether this is the case atm, though.

    Thomas
