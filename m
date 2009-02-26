From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/4] Move actually mounting the root filesystem into
	its own series of hooks.
Date: Thu, 26 Feb 2009 13:20:22 +0100
Message-ID: <20090226122022.GA6639@nb.net.home>
References: <40b7db44cbcb49b1fb50445d786cd4851adba14a.1235615253.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <40b7db44cbcb49b1fb50445d786cd4851adba14a.1235615253.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>

On Wed, Feb 25, 2009 at 06:32:36PM -0800, Victor Lowther wrote:
> We now have mount hooks.  They are sourced in an infinite loop until one of
> them actually mounts the real root filesystem.
> 
> This makes it easier to add support for arbitrarily complex schemes to find
> the root filesystem without having to patch the init script.
> 
> This patch series is also avaialble ass the hookify-finding-root branch at 
> http://git.fnordovax.org/dracut
> 
> ---
>  hooks/mount-partition.sh |   30 ++++++++++++++++++++++++++++
>  init                     |   49 ++++++++++++++++-----------------------------
>  modules/90crypt.sh       |    2 +-
>  modules/99base.sh        |    4 +-
>  4 files changed, 51 insertions(+), 34 deletions(-)
> 
> diff --git a/hooks/mount-partition.sh b/hooks/mount-partition.sh
> new file mode 100755
> index 0000000..53a0f4c
> --- /dev/null
> +++ b/hooks/mount-partition.sh
> @@ -0,0 +1,30 @@
> +#!/bin/sh
> +[ "$root" ] || {
> +    root=$(getarg root); root=${root#root=}
> +    case $root in
> +	LABEL=*) root=${root#LABEL=}
> +            root="$(echo $root |sed 's,/,\\x2f,g')"
> +            root="/dev/disk/by-label/${root}" ;;

 Note that this is probably not a proper way how to encode a label
 string. I guess that LABEL= option (e.g. from grub.conf) is in human
 readable format (like in /etc/fstab). The mount(8) also supports
 quoted LABELs and UUIDs (e.g. LABEL="foo").

 Currently we don't have a command line util that supports all these
 features, the problem should be fixed in the next util-linux-ng
 release by blkid(8).
 
    Karel

-- 
 Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
