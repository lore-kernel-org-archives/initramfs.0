From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/5] Even more dracut functionality
Date: Thu, 12 Feb 2009 01:21:09 +0100
Message-ID: <20090212002109.GE21052@nb.net.home>
References: <255e595fd4f868ab0f6e085deb0bfd4a2afc8ae7.1234395178.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <255e595fd4f868ab0f6e085deb0bfd4a2afc8ae7.1234395178.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


 I know, that's nit-picking, but I cannot resist ;-)

On Wed, Feb 11, 2009 at 03:41:56PM -0800, Victor Lowther wrote:
> +find_binary() {
> +    local binpath="/bin /sbin /usr/bin /usr/sbin" p
> +    [[ ${1##*/} = $1 ]] || { echo $1; return 0; }
> +    for p in $binpath; do
> +	[[ -x $p/$1 ]] && { echo "$p/$1"; return 0; }
> +    done
> +    return 1
> +}

[...]

> +    local src=$(find_binary "$1") || {

   PATH="/bin:/sbin:/usr/bin:/usr/sbin"
   local src=$(type -Pa "$1")


    Karel

-- 
 Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
