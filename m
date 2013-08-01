From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] 95terminfo: install vt102
Date: Thu, 01 Aug 2013 12:59:29 +0200
Message-ID: <51FA3F91.6@redhat.com>
References: <20130801105455.GA4121@dhcp16-109.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130801105455.GA4121-ALckc1lQpMDv8MId6FTy5BcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 08/01/2013 12:54 PM, WANG Chao wrote:
> systemd uses vt102 as default term for tty:
> 
> commit acda6a0
> Author: Lennart Poettering <lennart-mdGvqq1h2p+GdvJs77BJ7Q@public.gmane.org>
> Date:   Sun Apr 22 02:45:39 2012 +0200
> 
>     default to v102 everywhere, instead of vt100, to synchronize with agetty
> 
> Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/95terminfo/module-setup.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/modules.d/95terminfo/module-setup.sh b/modules.d/95terminfo/module-setup.sh
> index ecd4395..4656cd3 100755
> --- a/modules.d/95terminfo/module-setup.sh
> +++ b/modules.d/95terminfo/module-setup.sh
> @@ -10,7 +10,7 @@ install() {
>      done
>  
>      if [ -d ${_terminfodir} ]; then
> -        for i in "l/linux" "v/vt100" "v/vt220"; do
> +        for i in "l/linux" "v/vt100" "v/vt102" "v/vt220"; do
>              inst_dir "$_terminfodir/${i%/*}"
>              cp --reflink=auto --sparse=auto -prfL -t "${initdir}/${_terminfodir}/${i%/*}" "$_terminfodir/$i"
>          done
> 

Thanks.. pushed
