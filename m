From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] provide name based nbd connects
Date: Wed, 21 Mar 2012 13:07:20 +0100
Message-ID: <4F69C478.6090301@gmail.com>
References: <CAKzfqkf5Vn_RijjJ0Vames6zAsypTbNUJ+tqxD4A8S3XA-qbqw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=zqGKEJhN3PwbbOvnShJBWv3SPziSEb9XAREo+qXngHA=;
        b=Fr5dMKQRUEqKp7ujkxVTbP0NWWapxaeH3pLF9hY8t7TQ+6kQA9A2ZFQTKrRWhusekv
         /tfML1OXZcApObbOhEAq00MSDIdlbO1Slg8L2O4V6UU7ViWBa8uJXTXD+gA4WxYpQbnJ
         cTdFctUu8N4cZDS+JhVkmUM1IuWwv7P1XC91z3UNz3TjJ7klhrCeoMsgAYYECp+vii8K
         mKbEhlGKEa7PEcvy1PvSgtt2tPr8JdHF//8s7162TzF09i1eKMhMx4aZB1jeHZ1Sqmq0
         hGetba7bG/hl29ri1e05E5Qfl5GtvaFSrTuCARedO09WcxNCYD3SEHUr3C6VC8ED8Gs9
         JgIg==
In-Reply-To: <CAKzfqkf5Vn_RijjJ0Vames6zAsypTbNUJ+tqxD4A8S3XA-qbqw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Wim Muskee <wimmuskee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 17.03.2012 12:33, schrieb Wim Muskee:
> Because nbd-server also provides name-based exports instead of
> port-based ones, make it possible to connect to those.
> 
> --- modules.d/95nbd/nbdroot.sh.orig     2012-03-17 12:23:52.988936315 +0100
> +++ modules.d/95nbd/nbdroot.sh  2012-03-17 12:26:12.048798184 +0100
> @@ -30,6 +30,11 @@
>  nbdflags=${root%%:*}
>  nbdopts=${root#*:}
> 
> +# If nbdport not an integer, then assume name based import
> +if [[ $nbdport != [0-9]* ]]; then
> +    nbdport="-N $nbdport"
> +fi
> +
>  if [ "$nbdopts" = "$nbdflags" ]; then
>      unset nbdopts
>  fi
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

pushed
