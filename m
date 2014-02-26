From: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
Subject: Re: [PATCH] dracut.sh: add legacy flag (-l) to lz4
Date: Wed, 26 Feb 2014 12:12:30 +0100
Message-ID: <0067BAB6-F3BF-4831-940E-3C0D1F1F17DD@dominion.thruhere.net>
References: <E1WIbkL-0000mN-Ao@secretive.ru>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Transfer-Encoding: 8BIT
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E1WIbkL-0000mN-Ao-7GBPmfXo8GgjmsMGrRdz4w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


Op 26 feb. 2014, om 11:20 heeft Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org> het volgende geschreven:

> Linux kernel does not support the new default lz4 format.
> 
> https://bugs.gentoo.org/show_bug.cgi?id=502102
> ---
> dracut.sh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/dracut.sh b/dracut.sh
> index 5267af5..49077fd 100755
> --- a/dracut.sh
> +++ b/dracut.sh
> @@ -782,7 +782,7 @@ case $compress in
>     xz)    compress="xz --check=crc32 --lzma2=dict=1MiB -T0";;
>     gzip)  compress="gzip -9"; command -v pigz > /dev/null 2>&1 && compress="pigz -9";;
>     lzo)   compress="lzop -9";;
> -    lz4)   compress="lz4 -9";;
> +    lz4)   compress="lz4 -l -9";;

Does the magic number need updating as well?

regards,

Koen--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
