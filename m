From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] silence xen-detect detection
Date: Wed, 17 Mar 2010 11:56:29 +0100
Message-ID: <4BA0B55D.90007@redhat.com>
References: <20100307125208.GA26671@maude.comedia.it>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100307125208.GA26671-hdG+WfPrfN2JmafXlB/IVQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 03/07/2010 01:52 PM, Luca Berra wrote:
> Signed-off-by: Luca Berra <bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org>
> ---
> modules.d/60xen/check | 2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/modules.d/60xen/check b/modules.d/60xen/check
> index 420cdc2..f155582 100755
> --- a/modules.d/60xen/check
> +++ b/modules.d/60xen/check
> @@ -1,7 +1,7 @@
> #!/bin/bash
>
> # No Xen-detect? Boo!!
> -XENDETECT=$(which xen-detect)
> +XENDETECT=$(which xen-detect 2>/dev/null)
> [ -z "$XENDETECT" ] && [ -d "/usr/lib/xen-default" ] &&
> XENDETECT="/usr/lib/xen-default/bin/xen-detect"
> [ -z "$XENDETECT" ] && exit 1
>

pushed
