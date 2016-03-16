From: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V5 dracut 3/3] watchdog: ensure that module is loaded as
 early as possible
Date: Wed, 16 Mar 2016 09:48:29 +0530
Message-ID: <56E8DE95.4090308@redhat.com>
References: <cover.1458099200.git.panand@redhat.com>
 <2751555c29f26f69a63888745513edeceb39d416.1458099200.git.panand@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2751555c29f26f69a63888745513edeceb39d416.1458099200.git.panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>



On Wednesday 16 March 2016 09:09 AM, Pratyush Anand wrote:
> It is expected that a watchdog module will disable an active watchdog when
> its probe is called ie, when it is loaded. So an early load of the module
> will help to disable it earlier.
> This can be helpful in some corner cases where kdump and watchdog daemon
> both are active.
>
> Testing:
>      -- When watchdog kernel modules were added
> 	# dracut --no-hostonly initramfs-test.img -a watchdog
> 	# lsinitrd initramfs-test.img -f etc/cmdline.d/04-watchdog.conf

Sorry, please ignore this patch and take "resend" if there is not any 
further comment.

~Pratyush
