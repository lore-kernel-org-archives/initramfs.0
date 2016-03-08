From: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V4 dracut 3/3] watchdog: ensure that module is loaded as
 early as possible
Date: Tue, 8 Mar 2016 15:57:11 +0530
Message-ID: <20160308102711.GF20953@dhcppc3.redhat.com>
References: <cover.1457425628.git.panand@redhat.com>
 <e63d322e2cc3081a616f14f5586998811145931d.1457425628.git.panand@redhat.com>
 <20160308093738.GC8155@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160308093738.GC8155-0VdLhd/A9Pl+NNSt+8eSiB/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Hi Dave,

On 08/03/2016:05:37:38 PM, Dave Young wrote:
> > +    [[ $wdtcmdline = "" ]] || echo "rd.driver.pre=$wdtcmdline" > ${initdir}/etc/cmdline.d/04-watchdog.conf
> 
> It is not necessary to use same number as the dracut module "04".
> Since it is special we want it being loaded as soon as possible move it to 00-watchdog.conf sound better.

OK. Will change.

~Pratyush
