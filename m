From: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] init: Introduce early initrd files through uncompressed
 cpio passing
Date: Sat, 21 Jul 2012 08:21:26 -0700
Message-ID: <500AC8F6.4010802@zytor.com>
References: <1342607764-66747-1-git-send-email-trenn@suse.de> <1342607764-66747-2-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1342607764-66747-2-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

On 07/18/2012 03:36 AM, Thomas Renninger wrote:
> cpio parsing code comes from  H. Peter Anvin.
> The CONFIG_EARLY_INITRD feature is architecture independent, but
> for now only enabled/called for X86.
> The problem is that initrd_start must be valid, but there is no
> architecture independent reserve_initrd() call in init/main.c or
> similiar.
> + * Add here new callback functions and the path relevant files show up in an
> + * uncompressed cpio
> + */
> +static __initdata struct initrd_early_data initrd_early_callbacks[] =
> +{
> +	{
> +		.namesp = NULL,
> +	}
> +};
> +

I don't like your callback interface at all.  In fact, it is actively 
broken, because it assumes that all early users are runnable at the same 
time, which is trivially shown false -- the microcode work that Fenghua 
Yu is working on needs access to its early data much, much earlier than 
your ACPI code.

So big NAK on this change.  Instead we should stick to the imperative 
interface that I had in my original code (call the search function with 
a filename and let it return a pointer if found.)

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
