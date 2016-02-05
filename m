From: Xunlei Pang <xpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] network/parse-ip-opts.sh: avoid die with multiple "ip="
 dhcp cases
Date: Fri, 5 Feb 2016 10:07:32 +0800
Message-ID: <56B403E4.3040307@redhat.com>
References: <1454574901-6290-1-git-send-email-xlpang@redhat.com>
Reply-To: xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1454574901-6290-1-git-send-email-xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: hkrzesin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kexec-kdump-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Cc more.

https://bugzilla.redhat.com/show_bug.cgi?id=1304069

One worry that I have about the patch is the multiple "ip=???:<interface>:dhcp:???"
with a dhcp device specifed, not too sure about the bootdev in this case.

On 2016/02/04 at 16:35, Xunlei Pang wrote:
> When multiple "ip=" dhcp related commands are specified, dracut
> will die. Two "ip=dhcp" is a simple example.
>
> For kdump cases, when the kernel command line contains "ip=dhcp"
> which is inherited by kdump environment, the network dumping also
> hits this.
>
> To fix it, we can treat multiple dhcp related commands just as one.
>
> Signed-off-by: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/40network/parse-ip-opts.sh | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/modules.d/40network/parse-ip-opts.sh b/modules.d/40network/parse-ip-opts.sh
> index 5779ef8..521f48b 100755
> --- a/modules.d/40network/parse-ip-opts.sh
> +++ b/modules.d/40network/parse-ip-opts.sh
> @@ -22,16 +22,23 @@ fi
>  # Count ip= lines to decide whether we need bootdev= or not
>  if [ -z "$NEEDBOOTDEV" ] ; then
>      count=0
> +    has_dhcp=0
>      for p in $(getargs ip=); do
> -        case "$p" in
> +        ip_to_var $p
> +        case "$autoconf" in
>              ibft)
>                  continue;;
> +            dhcp|dhcp6|on|any)
> +                # Regard multiple dhcp cases as one to avoid die
> +                has_dhcp=1
> +                continue;;


Should we have an extra judgement using $dev here, if NULL then continue?

Regards,
Xunlei

>          esac
>          count=$(( $count + 1 ))
>      done
> +    count=$(( $count + $has_dhcp ))
>      [ $count -gt 1 ] && NEEDBOOTDEV=1
>  fi
> -unset count
> +unset count has_dhcp
>  
>  # If needed, check if bootdev= contains anything usable
>  BOOTDEV=$(getarg bootdev=)
