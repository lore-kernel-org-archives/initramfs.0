From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/4] Add #!/bin/bash for consistency.
Date: Wed, 25 Nov 2009 11:22:10 +0100
Message-ID: <4B0D0552.8090000@redhat.com>
References: <1259092378-14143-1-git-send-email-pjones@redhat.com> <4B0C40E4.6080006@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B0C40E4.6080006-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Hi,

On 11/24/2009 09:24 PM, Peter Jones wrote:
> Most install scripts seem to have it there, may as well make this one
> like the rest...
> ---
>   modules.d/90multipath/install |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/modules.d/90multipath/install b/modules.d/90multipath/install
> index d20ea38..52d69f5 100755
> --- a/modules.d/90multipath/install
> +++ b/modules.d/90multipath/install
> @@ -1,3 +1,5 @@
> +#!/bin/bash
> +
>   if [[ $hostonly ]]; then
>       inst /etc/multipath.conf
>   fi

Ack,

Regards,

hans
