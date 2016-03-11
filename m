From: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V4 dracut 2/3] watchdog: install module for active
 watchdog
Date: Fri, 11 Mar 2016 09:16:56 +0530
Message-ID: <20160311034656.GA15230@dhcppc4.redhat.com>
References: <cover.1457425628.git.panand@redhat.com>
 <0c1909217f5714663d1fd1841c19b00dc68031b2.1457425628.git.panand@redhat.com>
 <20160308092912.GA8155@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160308092912.GA8155-0VdLhd/A9Pl+NNSt+8eSiB/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Hi Harald,

On 08/03/2016:05:29:12 PM, Dave Young wrote:
> On 03/08/16 at 02:14pm, Pratyush Anand wrote:
> > +	    active=$(< "$dir/state")
> > +	    ! [[ $hostonly ]] || [[ "$active" =  "active" ]] || continue
> 
> Even if for devices which is not active it is still a hostonly device because
> it being detected by kernel running on the host? 
> 
> But I will not stick to this issue, I'm fine if Harald is ok with it because I do
> not know how to handle non hostonly in a proper way ..

Please let me know if you have any further input for these patches. Otherwise, I
will send a V5 with the update in patch 3/3 incorporating Dave's comment for
change in Watchdog command line file name.

~Pratyush
