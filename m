From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V2 dracut 0/2] Install kernel module for active watchdog
Date: Fri, 4 Mar 2016 11:16:33 +0800
Message-ID: <20160304031633.GB3592@dhcp-128-65.nay.redhat.com>
References: <cover.1456919929.git.panand@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cover.1456919929.git.panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Hi, Pratyush

On 03/02/16 at 05:36pm, Pratyush Anand wrote:
> Changes since RFC:
>  -- Added one more patch to take care that dracut does not add watchdog
> hooks when systemd module is included. In that case systemd daemon will
> manage watchdog for kicking.
>  -- Removed --nowdt argument. User can use -o or --omit when wathdog module
> is not needed. Thanks Harald for this suggestion.
>  -- Now I also do not check for "hostonly" to add modules for active
> watchdog. It seems reasonable to add kernel watchdog modules whenever,
> dracut watchdog module has been added.

From my understanding hostonly is a different mode comparing with the default
one which being used for distribution provided initramfs. In the latter case
all possible drivers should be included. But hostonly mode only adding the
drivers being used in this boot. From the code logic we provided it will detect
active wdt module and add the driver, the behavior is just "hostonly", no?

Thanks
Dave
