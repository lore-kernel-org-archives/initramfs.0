From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Fix boot with user suspend and no resume= kernel argument
Date: Thu, 04 Mar 2010 14:07:23 +0100
Message-ID: <4B8FB08B.6070903@redhat.com>
References: <20100301181026.16229.93268.stgit@cooker>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100301181026.16229.93268.stgit@cooker>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 03/01/2010 07:10 PM, Andrey Borzenkov wrote:
> Mandriva bug https://qa.mandriva.com/show_bug.cgi?id=57924. Check
> if dracut got resume= argument before calling /usr/sbin/resume
>
> Signed-off-by: Andrey Borzenkov<arvidjaar-JGs/UdohzUI@public.gmane.org>
>
> ---
>
>   modules.d/95uswsusp/resume-uswsusp.sh |    4 +++-
>   1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/modules.d/95uswsusp/resume-uswsusp.sh b/modules.d/95uswsusp/resume-uswsusp.sh
> index 9b18567..ce0e3d2 100755
> --- a/modules.d/95uswsusp/resume-uswsusp.sh
> +++ b/modules.d/95uswsusp/resume-uswsusp.sh
> @@ -8,4 +8,6 @@ case "$splash" in
>       ;;
>   esac
>
> -/usr/sbin/resume $a_splash "$resume"
> +if [ -n "$resume" ]; then
> +    /usr/sbin/resume $a_splash "$resume"
> +fi
>
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

pushed
