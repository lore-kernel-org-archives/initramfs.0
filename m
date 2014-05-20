From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] resume/parse-resume.sh: add missing braces
Date: Tue, 20 May 2014 11:33:47 +0200
Message-ID: <537B217B.2060702@redhat.com>
References: <1397924620-2755-1-git-send-email-farbing@web.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1397924620-2755-1-git-send-email-farbing-S0/GAf8tV78@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Daniel Schaal <farbing-S0/GAf8tV78@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 19.04.2014 18:23, Daniel Schaal wrote:
> ---
>  modules.d/95resume/parse-resume.sh | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/modules.d/95resume/parse-resume.sh b/modules.d/95resume/parse-resume.sh
> index d7b2d7f..a97ef7b 100755
> --- a/modules.d/95resume/parse-resume.sh
> +++ b/modules.d/95resume/parse-resume.sh
> @@ -70,9 +70,10 @@ if ! getarg noresume; then
>          printf '[ -e "%s" ] && { ln -s "%s" /dev/resume; rm -f -- "$job" "%s/initqueue/timeout/resume.sh"; }\n' \
>              "$resume" "$resume" "$hookdir" >> $hookdir/initqueue/settled/resume.sh
>  
> -        printf -- "%s" 'warn "Cancelling resume operation. Device not found.";'
> -        printf -- ' cancel_wait_for_dev /dev/resume; rm -f -- "$job" "%s/initqueue/settled/resume.sh";\n' \
> -            "$hookdir" >> $hookdir/initqueue/timeout/resume.sh
> +	{
> +            printf -- "%s" 'warn "Cancelling resume operation. Device not found.";'
> +            printf -- ' cancel_wait_for_dev /dev/resume; rm -f -- "$job" "%s/initqueue/settled/resume.sh";\n' "$hookdir"
> +        } >> $hookdir/initqueue/timeout/resume.sh
>  
>          mv /lib/dracut/resume.sh /lib/dracut/hooks/pre-mount/10-resume.sh
>      else
> 

Thanks!

http://git.kernel.org/cgit/boot/dracut/dracut.git/commit/?id=636cc1ef634704ffc5e037961b6fb8ede3203977
