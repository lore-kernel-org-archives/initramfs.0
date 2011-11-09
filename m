From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] 99base/init: avoid using cp -t
Date: Wed, 09 Nov 2011 10:08:55 +0100
Message-ID: <4EBA4327.5040907@redhat.com>
References: <20111108211140.3E57D9D401E@zog.reactivated.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111108211140.3E57D9D401E-k/4jFdqg8LLlyo9zxV8I99HuzzzSOjJt@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 08.11.2011 22:11, schrieb Daniel Drake:
> -t is not supported by busybox's cp.
> 
> Signed-off-by: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
> ---
>  modules.d/99base/init |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/modules.d/99base/init b/modules.d/99base/init
> index 36b2152..e0e2630 100755
> --- a/modules.d/99base/init
> +++ b/modules.d/99base/init
> @@ -133,7 +133,7 @@ fi
>  if ! ismounted /run; then
>      mkdir -m 0755 /newrun
>      mount -t tmpfs -o mode=0755,nosuid,nodev tmpfs /newrun >/dev/null 2>&1
> -    cp -a -t /newrun /run/*
> +    cp -a /run/* /newrun
>      mount --move /newrun /run
>      rm -fr /newrun
>  fi

gah... fix busybox... patch applied.
