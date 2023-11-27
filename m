Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547AF32C8D
	for <initramfs@vger.kernel.org>; Mon, 27 Nov 2023 19:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ki33V8ML"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE31C433C7;
	Mon, 27 Nov 2023 19:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701113226;
	bh=F9EBD6IEQ0O4FIpIRy6hyskfS8464DXijGhXc8h3o64=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ki33V8MLajaRO/HJ0JiPjesFMG6RIVtoxM44kK/bo4BVTuPrIJM2zMfCGhEXoJSy/
	 uJOqqNZmEYZtwgRwMnmGN6QkfY8WgyRRgBplMpON1MJKYNDxgmyd95Qp0vQ7NCg3sr
	 OJpMfeuKAbzpQZULnOUC2z+oHVqlAVnl3NQNpFlI=
Date: Mon, 27 Nov 2023 11:27:05 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Emily Shepherd <emily@redcoat.dev>
Cc: initramfs@vger.kernel.org
Subject: Re: [PATCH] initramfs: Support unpacking directly to tmpfs
Message-Id: <20231127112705.a77ea26ca0749fafe676b5f9@linux-foundation.org>
In-Reply-To: <CACHV8XpuC=RsvCqB3LMzxQFRnQB15-0fb4gr7b_EzUpOisrLsA@mail.gmail.com>
References: <CACHV8XpuC=RsvCqB3LMzxQFRnQB15-0fb4gr7b_EzUpOisrLsA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Nov 2023 15:40:40 +0000 Emily Shepherd <emily@redcoat.dev> wrote:

> For systems which run directly from initramfs, it is not possible to use
> pivot_root without first changing root. This is because of the
> intentional design choice that rootfs, which is where initramfs is
> unpacked to, cannot be unmounted.
> 
> pivot_root is an important feature for creating containers and the
> alternative (mounting the new root over the top of the old with MS_MOVE
> and then calling chroot) is not favoured by most container runtimes
> [1][2].
> 
> The general work around, when running directly from initramfs, is to
> have init mount a new tmpfs, copy everything out of rootfs, and then
> switch_root [3]. This is only required when running directly from the
> initramfs as all other methods of acquiring a root device (having the
> kernel mount a root device directly via the root= parameter, or using
> initramfs to mount and then switch_root to a new root) leave an empty
> rootfs at the top of the mount stack.
> 
> This commit adds a new build option - EMPTY_ROOTFS, available when
> initrd/initramfs is enabled. When selected, rather than unpacking the
> in-built / bootloader provided initramfs directly into rootfs, the kernel
> will mount a new tmpfs/ramfs over the top of the rootfs and unpack to
> that instead, leaving an empty rootfs at the top of the stack. This
> removes the need to have init copy everything as a workaround.

Nice changelog.  Can you please find more people to cc?  Al Viro,
people who have recently worked on this.  Also other interested
parties, not necessarily from the kernel side of things - people who
might use this feature.



> +#ifdef CONFIG_EMPTY_ROOTFS
> +int __init overmount_rootfs() {
> +    int err;

Please use tabs to indent, like the surrounding code.

> +    err = init_mkdir("/root", 0700);
> +    if (err != 0)
> +        goto out;
> +
> +    err = init_mount("rootfs", "/root", is_tmpfs ? "tmpfs" : "ramfs", 0, NULL);
> +    if (err != 0)
> +        goto out;
> +
> +    init_chdir("/root");
> +    init_mount(".", "/", NULL, MS_MOVE, NULL);
> +    init_chroot(".");
> +
> +    return 0;
> +
> +out:
> +    printk(KERN_WARNING "Failed to mount over rootfs\n");
> +    return err;
> +}
> +#endif /* CONFIG_EMPTY_ROOTFS */
> diff --git a/init/do_mounts.h b/init/do_mounts.h
> index 15e372b00ce70..7cbb8af460f22 100644
> --- a/init/do_mounts.h
> +++ b/init/do_mounts.h
> @@ -41,3 +41,9 @@ static inline bool initrd_load(char *root_device_name)
>      }
> 
>  #endif
> +
> +#ifdef CONFIG_EMPTY_ROOTFS
> +int __init overmount_rootfs(void);
> +#else
> +static inline int __init overmount_rootfs(void) { return 0; }
> +#endif
> diff --git a/init/initramfs.c b/init/initramfs.c
> index 8d0fd946cdd2b..76525108a39d2 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -19,6 +19,8 @@
>  #include <linux/task_work.h>
>  #include <linux/umh.h>
> 
> +#include "do_mounts.h"
> +
>  static __initdata bool csum_present;
>  static __initdata u32 io_csum;
> 
> @@ -688,6 +690,8 @@ static void __init populate_initrd_image(char *err)
> 
>  static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
>  {
> +    overmount_rootfs();

If the return value is ignored, overmount_rootfs() should return void
type.  Or should the return value be used in some fashion?
