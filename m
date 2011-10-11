From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] explicitly verify bash version
Date: Tue, 11 Oct 2011 09:39:13 +0200
Message-ID: <4E93F2A1.3060802@redhat.com>
References: <1318283885-1792-1-git-send-email-soltys@ziu.info> <1318283885-1792-3-git-send-email-soltys@ziu.info>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1318283885-1792-3-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10.10.2011 23:58, Michal Soltys wrote:
> A simple check in main dracut script.
> 
> Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
> ---
>  dracut |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/dracut b/dracut
> index 63d4ea6..205f5d1 100755
> --- a/dracut
> +++ b/dracut
> @@ -418,6 +418,13 @@ else
>      exit 1
>  fi
>  
> +# Verify bash version, curret minimum is 3.1
> +if (( ${BASH_VERSINFO[0]} < 3 ||
> +    ( ${BASH_VERSINFO[0]} == 3 && ${BASH_VERSINFO[1]} < 1 ) )); then
> +    dfatal 'You need at least Bash 3.1 to use dracut, sorry.'
> +    exit 1
> +fi
> +
>  dracutfunctions=$dracutbasedir/dracut-functions
>  export dracutfunctions
>  

pushed
