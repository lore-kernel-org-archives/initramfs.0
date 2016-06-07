From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut.sh: fix $tmpfilesdir fallback when systemd-devel
 is not installed.
Date: Tue, 7 Jun 2016 10:50:28 +0200
Message-ID: <e678fe2c-75bf-68a7-0def-593186b32f8c@redhat.com>
References: <20160607081605.1205-1-colin@mageia.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160607081605.1205-1-colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 07.06.2016 um 10:16 schrieb Colin Guthrie:
> Bug introduced in 3a04bddeed in Dec 2014.
> ---
>  dracut.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/dracut.sh b/dracut.sh
> index 8232fa4..a50eaff 100755
> --- a/dracut.sh
> +++ b/dracut.sh
> @@ -1260,8 +1260,8 @@ fi
>      || tmpfilesdir=$(pkg-config systemd --variable=tmpfilesdir 2>/dev/null)
>  
>  if ! [[ -d "$tmpfilesdir" ]]; then
> -    [[ -f /lib/tmpfiles.d ]] && tmpfilesdir=/lib/tmpfiles.d
> -    [[ -f /usr/lib/tmpfiles.d ]] && tmpfilesdir=/usr/lib/tmpfiles.d
> +    [[ -d /lib/tmpfiles.d ]] && tmpfilesdir=/lib/tmpfiles.d
> +    [[ -d /usr/lib/tmpfiles.d ]] && tmpfilesdir=/usr/lib/tmpfiles.d
>  fi
>  
>  export initdir dracutbasedir \
> 

Thanks! Pushed
