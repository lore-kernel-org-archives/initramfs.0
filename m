From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] busybox: fix installation from /sbin/busybox
Date: Wed, 26 Sep 2012 11:50:33 +0200
Message-ID: <5062CFE9.1050102@redhat.com>
References: <20120925224228.25BC8FAABE@dev.laptop.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120925224228.25BC8FAABE-2+9YHz4BXxlLDiiyqF6/jw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 26.09.2012 00:42, schrieb Daniel Drake:
> "inst busybox" no longer seems to work when busybox is at
> /sbin/busybox. Reproduced on Fedora 18 (dracut-023-39.git20120910).
> 
> Use type -P to find the full path to busybox to solve this problem.
> ---
>  modules.d/05busybox/module-setup.sh | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/modules.d/05busybox/module-setup.sh b/modules.d/05busybox/module-setup.sh
> index 2e9ead8..e0ef178 100755
> --- a/modules.d/05busybox/module-setup.sh
> +++ b/modules.d/05busybox/module-setup.sh
> @@ -13,9 +13,10 @@ depends() {
>  }
>  
>  install() {
> -    local _i _progs _path
> -    inst busybox /usr/bin/busybox
> -    for _i in `/sbin/busybox | sed -ne '1,/Currently/!{s/,//g; s/busybox//g; p}'`
> +    local _i _progs _path _busybox
> +    _busybox=$(type -P busybox)
> +    inst $_busybox /usr/bin/busybox
> +    for _i in `$_busybox | sed -ne '1,/Currently/!{s/,//g; s/busybox//g; p}'`
>      do
>          _progs="$_progs $_i"
>      done
> 

Thanks! Pushed.
