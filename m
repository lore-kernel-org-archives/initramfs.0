From: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V4 dracut 0/3] Install kernel module for active watchdog
Date: Tue, 8 Mar 2016 16:02:42 +0530
Message-ID: <20160308103242.GG20953@dhcppc3.redhat.com>
References: <cover.1457425628.git.panand@redhat.com>
 <20160308093400.GB8155@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160308093400.GB8155-0VdLhd/A9Pl+NNSt+8eSiB/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Hi Dave,

On 08/03/2016:05:34:00 PM, Dave Young wrote:
> On 03/08/16 at 02:14pm, Pratyush Anand wrote:
> > -- Removed creation of tmp/active-watchdogs. modinfo will be helpful for
> > kexec-tools.
> 
> Kdump still need save a previous added wdt somewhere so that it can rebuild
> initrd if necessary. I'm not sure where can we store the state, do you have
> some thoughts about it?

modinfo is able to help out here. See following kexec implementation, which I
still need to cleanup (as per coding style feedback received for dracut
patches), But I have tested it and it works.

https://github.com/pratyushanand/kexec-tools/blob/watchdog_fmaster/kdumpctl#L341

~Pratyush
