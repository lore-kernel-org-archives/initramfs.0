From: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Use dhclient.conf instead of -R
Date: Fri, 5 Jun 2009 12:02:53 -0400
Message-ID: <20090605160253.GJ5107@nostromo.devel.redhat.com>
References: <4A293933.80601@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4A293933.80601-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Seewer Philippe (philippe.seewer-omB+W0Dpw2o@public.gmane.org) said: 
> diff --git a/modules.d/40network/install b/modules.d/40network/install
> index 836c57f..eb6cbcc 100755
> --- a/modules.d/40network/install
> +++ b/modules.d/40network/install
> @@ -13,6 +13,7 @@ done
>  inst "$moddir/ifup" "/sbin/ifup"
>  inst "$moddir/netroot" "/sbin/netroot"
>  inst "$moddir/dhclient-script" "/sbin/dhclient-script"
> +inst "$moddir/dhclient.conf" "/sbin/dhclient.conf"

We have a /etc on the initramfs ... conf files should go there.

Bill
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
