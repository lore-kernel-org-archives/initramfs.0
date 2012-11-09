From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [patch RFC 5/6 resend] Get ifaces for udev rule use
Date: Fri, 09 Nov 2012 09:42:53 +0800
Message-ID: <509C5F9D.8010202@redhat.com>
References: <20121108095856.GA24413@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121108095856.GA24413-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Please ignore this. Last post 5/6 got received as well.

They were rejected by vger.kernel.org maybe because I use local postfix
sendmail. After adding a relay server they were sent out finally..

On 11/08/2012 05:58 PM, Dave Young wrote:

> Get ifaces for udev rule use
> 
> In case without BOOTIF, but /tmp/ifaces are already created.
> net-genrule.sh will fall to bring up all net interfaces.
> 
> Fix by reading from /tmp/ifaces before generating rules instead.
> 
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/40network/net-genrules.sh |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- dracut.orig/modules.d/40network/net-genrules.sh
> +++ dracut/modules.d/40network/net-genrules.sh
> @@ -19,6 +19,8 @@ if [ -z "$netroot" ] && [ ! -e "/tmp/net
>      return
>  fi
>  
> +[ -e /tmp/net.ifaces ] && read IFACES < /tmp/net.ifaces
> +
>  # Write udev rules
>  {
>      # bridge: attempt only the defined interface
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
