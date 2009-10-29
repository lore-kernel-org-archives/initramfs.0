From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut-gencmdline: emit "resume="
Date: Thu, 29 Oct 2009 11:02:14 +0100
Message-ID: <4AE96826.4010908@redhat.com>
References: <4AE95FEB.7090304@tuffmail.co.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AE95FEB.7090304-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/29/2009 10:27 AM, Alan Jenkins wrote:
> I haven't tested resume either way, but I can't imagine it working if
> we don't tell it which device to use :-).
>
> diff --git a/dracut-gencmdline b/dracut-gencmdline
> index 978f5a2..625546c 100755
> --- a/dracut-gencmdline
> +++ b/dracut-gencmdline
> @@ -711,5 +711,9 @@ if [ -n "$rootdev" ]; then
>       echo -n "root=$rootdev "
>   fi
>
> +if [ -n "$swsuspdev" ]; then
> +    echo -n "resume=$swsuspdev "
> +fi
> +
>   echo
>   # vim:ts=8:sw=4:sts=4:et
>
>

well, it works, because it finds the suspend signature :-)
