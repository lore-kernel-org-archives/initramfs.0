From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Make kill-dhclient.sh more readable
Date: Fri, 05 Jun 2009 13:06:46 +0200
Message-ID: <4A28FC46.8070201@redhat.com>
References: <4A28E91D.1000006@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A28E91D.1000006-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/05/2009 11:45 AM, Seewer Philippe wrote:
> Checking for existing file is more readable than string comparison
>
> ---
> diff --git a/modules.d/40network/kill-dhclient.sh
> b/modules.d/40network/kill-dhclient.sh
> index 19f258a..fcebd32 100755
> --- a/modules.d/40network/kill-dhclient.sh
> +++ b/modules.d/40network/kill-dhclient.sh
> @@ -1,5 +1,5 @@
> #!/bin/sh
>
> for f in /tmp/dhclient.*.pid; do
> - [ "$f" != "/tmp/dhclient.*.pid" ] && kill $(cat $f)
> + [ -e $f ] && kill $(cat $f)
> done

but it involves a disk access :)
for the sake of speed :) (not that it matters much here.. )
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
