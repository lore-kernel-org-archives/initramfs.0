From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 1/2]: dracut: 95resume: avoid possible symbolic link
 creation error on bootup
Date: Fri, 15 Apr 2016 10:39:14 +0200
Message-ID: <5710A8B2.60704@redhat.com>
References: <1460387473.2670.20.camel@trentalancia.net>
 <1460390439.2670.24.camel@trentalancia.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460390439.2670.24.camel-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11.04.2016 18:00, Guido Trentalancia wrote:
> Avoid symbolic link creation error (should apply to latest dracut version).
> 
> Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
> ---
>  modules.d/95resume/parse-resume.sh |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- dracut-044/modules.d/95resume/parse-resume.sh	2015-11-25 14:22:28.000000000 +0100
> +++ dracut-044-95resume-force-symlink/modules.d/95resume/parse-resume.sh	2016-04-11 17:53:20.664983390 +0200
> @@ -67,7 +67,7 @@ if ! getarg noresume; then
>              printf -- '%s\n' ' RUN+="/sbin/initqueue --finished --unique --name 00resume echo %M:%m  > /sys/power/resume"'
>          } >> /etc/udev/rules.d/99-resume.rules
>  
> -        printf '[ -e "%s" ] && { ln -s "%s" /dev/resume 2> /dev/null; rm -f -- "$job" "%s/initqueue/timeout/resume.sh"; }\n' \
> +        printf '[ -e "%s" ] && { ln -sf "%s" /dev/resume 2> /dev/null; rm -f -- "$job" "%s/initqueue/timeout/resume.sh"; }\n' \
>              "$resume" "$resume" "$hookdir" >> $hookdir/initqueue/settled/resume.sh
>  
>          {
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

patching file modules.d/95resume/parse-resume.sh
patch: **** malformed patch at line 8:              printf -- '%s\n' ' RUN+="/sbin/initqueue --finished --unique --name 00resume
echo %M:%m  > /sys/power/resume"'

anyway.. applied by hand and pushed.
