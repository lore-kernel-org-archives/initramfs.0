From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] strip "init=" from INIT
Date: Wed, 04 Mar 2009 16:54:10 -0600
Message-ID: <1236207250.6500.49.camel@sentry-no.fnordovax.org>
References: <49AE78AA.8070401@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=YygrLBYvuGDkj4hEbsnm33v/APh/92FSBuEC1dNgV/k=;
        b=H36HSZWyQLH/lECth4l/Lj08ESVazqvQTGAA3CLTyOykMS9y+V56DCM3iio+nWTBMg
         hhMlUlo3evEsp1bARjEEvkOu3KDSk9SMQlIjVb/4ZqecD4lNA4yRVmplUSa/uo9vgjRQ
         KSBgyxCVPQejB5PmbO04QbHwGXPG5z/Oi17Xw=
In-Reply-To: <49AE78AA.8070401-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, 2009-03-04 at 13:48 +0100, Harald Hoyer wrote:
> plain text document attachment (0001-strip-init-from-INIT.patch)
> From 5e043b9fd529b1cfb0358a69f263b84620ffbd1b Mon Sep 17 00:00:00 2001
> From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Date: Wed, 4 Mar 2009 13:45:21 +0100
> Subject: [PATCH] strip "init=" from INIT
> 
> ---
>  init |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/init b/init
> index 581c2b9..9605141 100755
> --- a/init
> +++ b/init
> @@ -90,7 +90,7 @@ ln -s "$root" /dev/root
>  fstype="$(getarg rootfstype)" && fstype="-t ${fstype#rootfstype=}" 
>  mount $fstype -o $rflags /dev/root $NEWROOT || emergency_shell
>  
> -INIT=$(getarg init)
> +INIT=$(getarg init); INIT=${INIT#init=}
>  [ "$INIT" ] || {
>      for i in /sbin/init /etc/init /init /bin/sh; do
>  	[ -x "$NEWROOT$i" ] && { INIT="$i"; break; }

Fixed in the hookify-finding-root patches that I should repost to the
list. :)

-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
