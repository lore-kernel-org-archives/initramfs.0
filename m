From: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [Linux-ima-user] [systemd-devel] [PATCH 2/2] main: added
 support for loading IMA custom policies
Date: Tue, 21 Feb 2012 07:25:05 -0500
Message-ID: <1329827106.2186.1.camel@falcor>
References: <4F3BDCAA.7040001@polito.it>
	 <CAPdpN3C0xDeVBrbDxesPdEV+owf-q_wxUHTmr4YDCHw=NgPV1Q@mail.gmail.com>
	 <4F3BE763.9060704@polito.it> <4F3C8C6F.4010708@gmail.com>
	 <4F3D06D1.7000404@polito.it>
	 <CAPdpN3AAwJ6s-fOgTCV4h4OCKCw3RhEav56LJaUXWVpuf4Jowg@mail.gmail.com>
	 <4F3D144D.3060102@polito.it>
	 <CAPdpN3Bj2u7YRYXEuyTX=1p9vcrnDdMOEO+VeHEHW2R_B4ar3g@mail.gmail.com>
	 <20120220172418.GG26356@tango.0pointer.de>	<4F4299C2.5040205@polito.it>
	 <20120220191804.GD360@tango.0pointer.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120220191804.GD360-kS5D54t9nk0aINubkmmoJbNAH6kLmebB@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Lennart Poettering <lennart-mdGvqq1h2p+GdvJs77BJ7Q@public.gmane.org>
Cc: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-ima-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gustavo Sverzut Barbieri <barbieri-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org>, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org

On Mon, 2012-02-20 at 20:18 +0100, Lennart Poettering wrote:
> On Mon, 20.02.12 20:06, Roberto Sassu (roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org) wrote:
> 
> > >We moved SELinux loading out of the initrd into systemd, in order to
> > >support fully featured initrd-less boots. I don't think we should reopen
> > >this problem set by having IMA in the initrd. I believe IMA should be
> > >treated pretty much exactly like SELinux here: the policy should be
> > >loaded from PID1 and it needs to be a compile time option, and it needs
> > >a kernel cmdline option to disable it (i.e. like selinux=0).
> > >
> > 
> > If the SELinux module in dracut is to be considered definitively broken
> > probably also the IMA module should be removed, because it will not be
> > possible to load policies with LSM rules. But i don't know how this
> > feature can be supported by distributions without Systemd installed.
> 
> Well, if the rumours I keep hearing are true Ubuntu might join the
> systemd camp too after their LTS release. Maybe the supporting
> non-systemd systems issues solves itself by that for you?
> 
> > Regarding the kernel option, actually there is no a specific parameter
> > to disable IMA. However, it can be introduced in the patches proposed
> > by Mimi Zohar about the 'ima-appraisal' feature. This can allow to
> > disable IMA or to put it in permissive/enforce mode as it happens for
> > example in SELinux.
> 
> Whether there is a kernel option to enable/disable IMA will not stop
> these patches from getting into systemd. But I am quite sure they will
> stop IMA from getting any wider coverage in the mainstream distributions
> (if you care for that).

Really? The original IMA patch set defined CONFIG_IMA_BOOTPARAM and
CONFIG_IMA_BOOTPARAM_VALUE, but based on the lkml discussion, I removed
support for them. (May 2008)

In lieu of a switch to enable/disable IMA, the default measurement
policy is null, so that nothing is measured, unless 'ima_tcb' is
provided on the boot command line.

> Oh, and one more thing: it matters to me that this doesn't break my
> build. So it needs to allow me booting when enabled in configure, but
> without any IMA policy around.
> 
> Lennart

Of course IMA should work with/without updating the measurement policy.

thanks,

Mimi
