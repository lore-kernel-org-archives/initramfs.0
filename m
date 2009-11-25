From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/4] Make sure and get all the multipath related modules.
Date: Wed, 25 Nov 2009 11:23:05 +0100
Message-ID: <4B0D0589.6080909@redhat.com>
References: <1259092378-14143-1-git-send-email-pjones@redhat.com> <4B0C40C7.7010206@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B0C40C7.7010206-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Hi,

On 11/24/2009 09:23 PM, Peter Jones wrote:
> Install all modules that are any of:
> - scsi device handler
> - dm log handler
> - dm path selector
> - dm target
>
> It would be nice if we could tell which log handlers and targets are
> multipath related, but we really can't.
> ---
>   modules.d/90multipath/installkernel |    9 ++++++++-
>   1 files changed, 8 insertions(+), 1 deletions(-)
>
> diff --git a/modules.d/90multipath/installkernel b/modules.d/90multipath/installkernel
> index 50c7d6a..4a596f0 100755
> --- a/modules.d/90multipath/installkernel
> +++ b/modules.d/90multipath/installkernel
> @@ -1 +1,8 @@
> -instmods dm-multipath dm-round-robin multipath
> +#!/bin/bash
> +
> +mp_mod_test() {
> +    local mpfuncs='scsi_register_device_handler|dm_dirty_log_type_register|dm_register_path_selector|dm_register_target'
> +    nm -uPA "$1" | egrep -q "$mpfuncs"
> +}
> +
> +instmods $(filter_kernel_modules mp_mod_test)

Looks good to me, ack.

Regards,

Hans
