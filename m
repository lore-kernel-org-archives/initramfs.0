From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v1] dracut.sh: Support early microcode loading.
Date: Wed, 17 Jul 2013 13:20:09 -0400
Message-ID: <20130717172009.GC30248@phenom.dumpdata.com>
References: <1373397849-11397-1-git-send-email-konrad.wilk@oracle.com>
 <3E5A0FA7E9CA944F9D5414FEC6C712205A528195@ORSMSX106.amr.corp.intel.com>
 <51DD0F27.70202@redhat.com>
 <20130710145815.GD11007@phenom.dumpdata.com>
 <20130712210254.GA26664@phenom.dumpdata.com>
 <51E690C1.5010004@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51E690C1.5010004-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "Yu, Fenghua" <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

> > Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> > [v1: Support --host-only parameter]
> > ---
> >  dracut-functions.sh |   33 +++++++++++++++++++++++++++++++++
> >  dracut.sh           |   46 ++++++++++++++++++++++++++++++++++++++++++----
> >  2 files changed, 75 insertions(+), 4 deletions(-)
> > 
> 
> Pushed to dracut git HEAD, but disabled by default, also added the

Yeeey! Thank you.
> --early-microcode option and bash cimpletion.

I did check the initramfs with a kernel that does not have this support
(no CONFIG_EARLY_CPIO..), and found out that the kernel is smart enough to
combine the two payloads in one (so the initrd has the kernel/...).

In case that is your fear of enabling this by default  :-)
> 
> Man pages still need documentation.

Of course. Will do it.
> 
> lsinitrd only displays the microcode files at the moment of course.
> This is tricky to solve. Any ideas?

Oh boy. Tricky. I will look at it and cobble something up. Not this week
thought - but next one.
> 
> 
> 
