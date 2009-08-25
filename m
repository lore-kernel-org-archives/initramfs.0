From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 19/18] Modify nbd hostonly checking to use check_block_and_slaves.
Date: Tue, 25 Aug 2009 11:00:34 -0400
Message-ID: <4A93FC92.1010305@redhat.com>
References: <1a4c4015bc85feeb9fbf95a9d1e9adfb2de8e897.1250465033.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1a4c4015bc85feeb9fbf95a9d1e9adfb2de8e897.1250465033.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 08/16/2009 07:24 PM, Victor Lowther wrote:
> +# if an nbd device is not somewhere in the chain of devices root is mounted on,
> +# fail the hostonly check.
> +[ "$1" = "-h" ]&&  {
> +    rootdev=$(find_root_block_device)
> +    [[ -b /dev/block/$rootdev ]] || exit 1
> +    check_block_and_slaves is_nbd "$rootdev" || exit 1
> +}

When will this ever work?  More often than not you would be generating a 
netboot in a chroot of the image.  You almost never generate the initrd 
on the running netbooted system.

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
