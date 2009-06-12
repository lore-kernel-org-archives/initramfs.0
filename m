From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] Add "die" and some minor changes in base
Date: Fri, 12 Jun 2009 11:41:23 -0400
Message-ID: <1244821283.15165.2.camel@lap75545.ornl.gov>
References: <4A327035.6060100@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <4A327035.6060100-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Don't have time for a full review at the moment, but this jumped out at
me:

On Fri, 2009-06-12 at 17:11 +0200, Seewer Philippe wrote:
> ---
>  modules.d/99base/dracut-lib         |    6 ++++++
>  modules.d/99base/init               |   14 +++-----------
>  modules.d/99base/parse-root-opts.sh |    1 -
>  3 files changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/modules.d/99base/dracut-lib b/modules.d/99base/dracut-lib

> +die() {
> +    printf "FATAL: $1\n"
> +    printf "Refusing to continue\n"
> +    exit 1
> +}
> +

> --- a/modules.d/99base/init
> +++ b/modules.d/99base/init

> +[ -z "$root" ] && die "No or empty root= argument"
> +[ -z "$rootok" ] && die "Don't know how to handle 'root=$root'"

If you call die, you don't get an emergency shell. Not very friendly...
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
