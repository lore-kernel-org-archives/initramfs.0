From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Add support for installing required keyboard drivers
Date: Thu, 04 Mar 2010 14:08:46 +0100
Message-ID: <4B8FB0DE.4020603@redhat.com>
References: <20100221200702.3353.3442.stgit@cooker>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100221200702.3353.3442.stgit@cooker>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tmb-4qZELD6Fgxhg9hUCZPvPmw@public.gmane.org

On 02/21/2010 09:07 PM, Andrey Borzenkov wrote:
> Thomas Backlund reports that he had no USB keyboard in emergency shell.
> I have verified it using Apple USB keyboard.
> Add module to install required drivers, both for standard
> i8042 and USB one. Patch is based on code from Mandriva mkinitrd.
>
> This patch allows usage of USB keyboard in emergency shell starting
> with initqueue breakpoint. This is probably enough for most real
> life cases; I do not see any easy way to enable optional loading
> of needed modules before cmdline breakpoint; and for pre-udev or
> pre-trigger cases user can pass rdloaddriver.
>
> Signed-off-by: Andrey Borzenkov<arvidjaar-JGs/UdohzUI@public.gmane.org>
>
> ---
>
>   modules.d/95keyboard/install |   12 ++++++++++++
>   1 files changed, 12 insertions(+), 0 deletions(-)
>   create mode 100755 modules.d/95keyboard/install
>
> diff --git a/modules.d/95keyboard/install b/modules.d/95keyboard/install
> new file mode 100755
> index 0000000..14f26e3
> --- /dev/null
> +++ b/modules.d/95keyboard/install
> @@ -0,0 +1,12 @@
> +#!/bin/bash
> +
> +# Host dependencies are automatically handled by instmods
> +
> +# Standard PS/2 type keyboard; should we add also other keyboard
> +# types (sunkbd, ...)?
> +instmods atkbd i8042
> +
> +# USB HID keyboards. Are there more keyboards that has to be added?
> +instmods ehci-hcd ohci-hcd uhci-hcd
> +instmods usbhid
> +instmods hid-apple
>
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

pushed
