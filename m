From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Harden check for used modules in hostonly mode
Date: Wed, 04 Aug 2010 18:31:58 +0200
Message-ID: <4C5995FE.2010009@redhat.com>
References: <20100509182358.3768.89142.stgit@cooker>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100509182358.3768.89142.stgit@cooker>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

pushed

On 05/09/2010 08:23 PM, Andrey Borzenkov wrote:
> Make sure that we do not accept module name which is substring of
> some other module name. This resulted in piix being mistakenly loaded
> together with ata_piix. It completely broke DVD access here.
>
> Signed-off-by: Andrey Borzenkov<arvidjaar-JGs/UdohzUI@public.gmane.org>
>
> ---
>
>   dracut-functions |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/dracut-functions b/dracut-functions
> index fdcfb7e..ebf09c0 100755
> --- a/dracut-functions
> +++ b/dracut-functions
> @@ -502,7 +502,7 @@ instmods() {
>   	        [[ -f $initdir/$1 ]]&&  { shift; continue; }
>   		# If we are building a host-specific initramfs and this
>   		# module is not already loaded, move on to the next one.
> -		[[ $hostonly ]]&&  ! grep -q "${mod//-/_}" /proc/modules&&  \
> +		[[ $hostonly ]]&&  ! grep -qe "\<${mod//-/_}\>" /proc/modules&&  \
>   	        ! echo $add_drivers | grep -qe "\<${mod}\>"&&	{
>   		    shift; continue;
>   		}
>
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
