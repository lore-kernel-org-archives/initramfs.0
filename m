From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [PATCH 4/5] Add DAD do dhclient-script
Date: Wed, 24 Jun 2009 14:39:49 -0400
Message-ID: <1245868789.31775.16.camel@lap75545.ornl.gov>
References: <1245866912-3643-1-git-send-email-philippe.seewer@bfh.ch>
 <1245866912-3643-5-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1245866912-3643-5-git-send-email-philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, 2009-06-24 at 20:08 +0200, Philippe Seewer wrote:
> The manpage for dhclient-script says:
> 
> Before actually configuring the address, dhclient-script should
> somehow ARP for it and exit with a nonzero status if it receives a
> reply.
> 
> By using arping in dracut this is very easy, since arping has a
> specific option to do just that.

> --- a/modules.d/40network/dhclient-script
> +++ b/modules.d/40network/dhclient-script
> @@ -64,6 +64,7 @@ case $reason in
>  	sleep 1
>  	;;
>      BOUND)
> +	arping -q -D -c 2 -I $netif $new_ip_address || exit 1

Where's the addition of arping to 40network/install?


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
