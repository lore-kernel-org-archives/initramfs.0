From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/6] X86 ACPI: Introduce x86 arch specific arch_reserve_mem_area() for e820 handling
Date: Tue, 25 Sep 2012 17:12:17 +0200
Message-ID: <201209251712.17678.trenn@suse.de>
References: <1348584961-1476-1-git-send-email-trenn@suse.de> <1348584961-1476-3-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1348584961-1476-3-git-send-email-trenn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: hpa@zytor.com
Cc: lenb@kernel.org, initramfs@vger.kernel.org, robert.moore@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, yinghai@kernel.org

On Tuesday, September 25, 2012 04:55:57 PM Thomas Renninger wrote:
> This is needed for ACPI table overriding via initrd. Beside reserving
> memblocks, X86 also requires to flag the memory area to E820_RESERVED or
> E820_ACPI in the e820 mappings to be able to io(re)map it later.
...

> index 4f2a762..bf6a0ad 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -430,4 +430,13 @@ acpi_status acpi_os_prepare_sleep(u8 sleep_state,
>  #define acpi_os_set_prepare_sleep(func, pm1a_ctrl, pm1b_ctrl) do { } while (0)
>  #endif
>  
> +#if CONFIG_X86
> +void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
> +#else
> +static inline void void arch_reserve_mem_area(acpi_physical_address addr,

Argh: ...void void... 
I made sure every single patch compiles, so that no typo slips
in, I haven't compiled it on an other arch and there ... a typo
slipped in.

Can this get manually fixed?
Tell me and I can also resend.

    Thomas

