From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] resume: fix swap detection in hostonly
Date: Wed, 09 Oct 2013 16:22:29 +0200
Message-ID: <525566A5.20805@gmail.com>
References: <6734e993a6184b487097463179c3dd75357047b2.1381324538.git.alexander@tsoy.me>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=kEyaXdCcXy8ttsr+UnIwsyI9tKR4W25tkDYeAIx0oqQ=;
        b=RMDoIlnXtQ4rMQPjJfFT8B3jN7J66+qI0OOkPOfC6ZSlrnjM2KLe2oYQtR03QuLLOK
         luFfmiAAag1J+P1yFTTIc7pcU6Xup7g9P+pX0MyV7wE9BBdYUliBoiwQCfKrhY39nXp+
         aywraCGAPsD9g8bWj+Y8F2FxTBpatooTCOS1DzrzcBdeqHR+P2NVEGAnb16D4B8hlwzw
         Nh0e90YTsFjKarTWyMC40HtgmDmUflK51LoLL2bZbt75npTXvoQwcU/o8Uoo/zGvhw7d
         erLIa69YZUPx1stHoyrWr7Y4d5vuBmgRCgMX2DWz55KkT5r0N8Rp8k+wL0kh8AHkcymo
         EcxQ==
In-Reply-To: <6734e993a6184b487097463179c3dd75357047b2.1381324538.git.alexander-EP/B3+myoZc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/09/2013 04:39 AM, Alexander Tsoy wrote:
> Check for other possible fs types. This fixes swap detection when using
> TuxOnIce kernel.
> 
> Note that parse-resume.sh generate udev rules with support for
> ID_FS_TYPE=suspend, but we do not include it here, because it is
> libvolume_id thing and host_fs_types is populated using blkid.
> ---
>  modules.d/95resume/module-setup.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/modules.d/95resume/module-setup.sh b/modules.d/95resume/module-setup.sh
> index b6d2c48..8b37616 100755
> --- a/modules.d/95resume/module-setup.sh
> +++ b/modules.d/95resume/module-setup.sh
> @@ -7,7 +7,7 @@ check() {
>      # No point trying to support resume, if no swap partition exist
>      [[ $hostonly ]] || [[ $mount_needs ]] && {
>          for fs in "${host_fs_types[@]}"; do
> -            [[ $fs = swap ]] && return 0
> +            [[ $fs =~ ^(swap|swsuspend|swsupend)$ ]] && return 0
>          done
>          return 255
>      }
> 

Thanks! Pushed both
