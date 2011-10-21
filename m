From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] make livenet module optional
Date: Fri, 21 Oct 2011 13:16:45 +0200
Message-ID: <4EA1549D.50104@gmail.com>
References: <1319133444-27980-1-git-send-email-wwoods@redhat.com> <1319133444-27980-2-git-send-email-wwoods@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=MC02HT7GlBvXEww9HacA47XW9p4Y73luilKsFt4SOwU=;
        b=r7yKZ1w1Fmmg1UfElX5F6WQM3zyUkNx6A3QrZohDDO4zJq7Rjieb2Y6V4G7tm5QSbN
         imyIuVQl59GsVlQ99X6kkOnRQX7VDnoaZ09RUd37IMW+URW6CzsFn06wqm4ZVaVrN4RT
         2MtFePQHODc0VDsvb6qITlLQvlJtUHACd94W8=
In-Reply-To: <1319133444-27980-2-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 20.10.2011 19:57, Will Woods wrote:
> The livenet module was intended to be optional, so its check() function
> in module-setup.sh should return 255, not 0.
> 
> This was causing systems without 'wget' to fail to build initramfs, as
> in RHBZ#747632.
> ---
>  modules.d/90livenet/module-setup.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/modules.d/90livenet/module-setup.sh b/modules.d/90livenet/module-setup.sh
> index 3ee7521..613a225 100755
> --- a/modules.d/90livenet/module-setup.sh
> +++ b/modules.d/90livenet/module-setup.sh
> @@ -5,7 +5,7 @@ check() {
>      # a live, host-only image doesn't really make a lot of sense
>      [[ $hostonly ]] && return 1
>      command -v wget || return 1
> -    return 0
> +    return 255
>  }
>  
>  depends() {

already fixed, thanks!
