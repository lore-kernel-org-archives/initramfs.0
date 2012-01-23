From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/5 branch usrmove v2] change root home dir to /root
Date: Mon, 23 Jan 2012 12:03:52 +0100
Message-ID: <4F1D3E98.2010006@redhat.com>
References: <20111226062918.GA3145@darkstar.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111226062918.GA3145-4/PLUo9XfK+sDdueE5tM26fLeoKvNuZc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, soltys-R61QfzASbfY@public.gmane.org

Am 26.12.2011 07:29, schrieb Dave Young:
> ssh need to read knownhosts from home directory, so change root home to /root
> 
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/99base/module-setup.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/modules.d/99base/module-setup.sh b/modules.d/99base/module-setup.sh
> index 03058b1..fad6c50 100755
> --- a/modules.d/99base/module-setup.sh
> +++ b/modules.d/99base/module-setup.sh
> @@ -23,7 +23,7 @@ install() {
>      fi
>  
>      #add common users in /etc/passwd, it will be used by nfs/ssh currently
> -    egrep '^root:' "$initdir/etc/passwd" 2>/dev/null || echo  'root:x:0:0::/:/bin/sh' >> "$initdir/etc/passwd"
> +    egrep '^root:' "$initdir/etc/passwd" 2>/dev/null || echo  'root:x:0:0::/root:/bin/sh' >> "$initdir/etc/passwd"
>      egrep '^nobody:' /etc/passwd >> "$initdir/etc/passwd"
>      # install our scripts and hooks
>      inst "$moddir/init" "/init"

pushed
