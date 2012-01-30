From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] split out nfs rpc process startup
Date: Mon, 30 Jan 2012 08:18:40 +0000 (UTC)
Message-ID: <jg5jov$3qk$2@dough.gmane.org>
References: <20120130064350.GA7114@darkstar.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 30 Jan 2012 at 06:43 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Index: dracut/modules.d/95nfs/nfs-start-rpc
>===================================================================
> --- /dev/null
> +++ dracut/modules.d/95nfs/nfs-start-rpc
> @@ -0,0 +1,22 @@
> +#!/bin/sh
> +# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
> +# ex: ts=8 sw=4 sts=4 et filetype=sh
> +
> +nfsstart() {
> +    # Start rpcbind or rpcbind
> +    # FIXME occasionally saw 'rpcbind: fork failed: No such device' -- why?
> +    command -v portmap >/dev/null && [ -z "$(pidof portmap)" ] && portmap
> +    command -v rpcbind >/dev/null && [ -z "$(pidof rpcbind)" ] && rpcbind
> +
> +    if [ "$1" = "nfs4" ]; then
> +        [ ! -d /var/lib/nfs/rpc_pipefs/nfs ] && \
> +             mount -t rpc_pipefs rpc_pipefs /var/lib/nfs/rpc_pipefs
> +
> +        # Start rpc.statd as mount won't let us use locks on a NFSv4
> +        # filesystem without talking to it. NFSv4 does locks internally,
> +        # rpc.lockd isn't needed
> +        [ -z "$(pidof rpc.statd)" ] && rpc.statd
> +
> +        [ -z "$(pidof rpc.idmapd)" ] && rpc.idmapd
> +    fi
> +}
> Index: dracut/modules.d/95nfs/nfsroot
>===================================================================
> --- dracut.orig/modules.d/95nfs/nfsroot
> +++ dracut/modules.d/95nfs/nfsroot
> @@ -84,22 +84,10 @@ getarg rw && nfsrw=rw
>  
>  options=${options:+$options,}$nfsrw
>  
> -# Start rpcbind or rpcbind
> -# FIXME occasionally saw 'rpcbind: fork failed: No such device' -- why?
> -command -v portmap >/dev/null && [ -z "$(pidof portmap)" ] && portmap
> -command -v rpcbind >/dev/null && [ -z "$(pidof rpcbind)" ] && rpcbind
> +. /sbin/nfs-start-rpc
> +nfsstart $nfs

Huh? Why making nfsstart a function and source it here?
Why not just make nfsstart as a script and invoke that script here?
This reads odd to me.
