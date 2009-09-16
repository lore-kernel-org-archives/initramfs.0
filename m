From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/3] Document that MAC addresses must be lowercase
Date: Wed, 16 Sep 2009 17:45:21 +0200
Message-ID: <4AB10811.8040108@redhat.com>
References: <1252921374-2798-1-git-send-email-hdegoede@redhat.com> <1252921374-2798-2-git-send-email-hdegoede@redhat.com> <1252921374-2798-3-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1252921374-2798-3-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 09/14/2009 11:42 AM, Hans de Goede wrote:
> ---
>   dracut.8 |    4 +++-
>   1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/dracut.8 b/dracut.8
> index 322f879..32d2e5b 100644
> --- a/dracut.8
> +++ b/dracut.8
> @@ -228,7 +228,8 @@ will read the iscsi parameter from the BIOS firmware
>   .TP
>   .B netroot=fcoe:<interface|MAC>:<dcb|nodcb>
>   Try to connect to a FCoE SAN through the NIC specified by<interface>  or<MAC>,
> -for the second argument, currently only nodcb is supported.
> +for the second argument, currently only nodcb is supported. Note letters in
> +the MAC-address must be lowercase!
>
>   .SH NBD
>   .TP
> @@ -256,6 +257,7 @@ explicit network configuration
>   .TP
>   .B ifname=<interface>:<MAC>
>   Assign network device name<interface>  (ie eth0) to the NIC with MAC<MAC>.
> +Note letters in the MAC-address must be lowercase!
>   Note that if you use this option you \fBmust\fR specify an ifname= argument
>   for all interfaces used in ip= or fcoe= arguments
>

applied and pushed
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
