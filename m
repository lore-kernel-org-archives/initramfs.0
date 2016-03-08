From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V4 dracut 0/3] Install kernel module for active watchdog
Date: Tue, 8 Mar 2016 17:34:00 +0800
Message-ID: <20160308093400.GB8155@dhcp-128-65.nay.redhat.com>
References: <cover.1457425628.git.panand@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cover.1457425628.git.panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Hi, Pratyush

On 03/08/16 at 02:14pm, Pratyush Anand wrote:
> Changes since V3:
> -- Incorporated changes suggested by Harald for V2 patches
> 
> Changes since V2:
> -- Added one more patch to update rd.driver.pre with watchdog module name,
> so that they are loaded into kernel as early as possible.
> -- Removed creation of tmp/active-watchdogs. modinfo will be helpful for
> kexec-tools.

Kdump still need save a previous added wdt somewhere so that it can rebuild
initrd if necessary. I'm not sure where can we store the state, do you have
some thoughts about it?

Thanks
Dave 
