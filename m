From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V2 dracut 2/2] watchdog: install module for active
 watchdog
Date: Fri, 4 Mar 2016 11:13:34 +0800
Message-ID: <20160304031334.GA3592@dhcp-128-65.nay.redhat.com>
References: <cover.1456919929.git.panand@redhat.com>
 <0d7adcfdf08f4eb753a0e65e7e65d5fe0ef22f70.1456919929.git.panand@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0d7adcfdf08f4eb753a0e65e7e65d5fe0ef22f70.1456919929.git.panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Hi, Pratyush

[snip]
> 
> Signed-off-by: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/04watchdog/module-setup.sh | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/modules.d/04watchdog/module-setup.sh b/modules.d/04watchdog/module-setup.sh
> index 7ec757aec032..6232afb0d9ca 100755
> --- a/modules.d/04watchdog/module-setup.sh
> +++ b/modules.d/04watchdog/module-setup.sh
> @@ -32,3 +32,36 @@ install() {
>      inst_multiple -o wdctl
>  }
>  
> +installkernel() {
> +    cd /sys/class/watchdog
> +    for dir in */; do
> +	    cd $dir
> +	    active=`[ -f state ] && cat state`
> +	    if [ "$active" =  "active" ]; then
> +		    # applications like kdump need to know that, which
> +		    # watchdog modules have been added into initramfs
> +		    echo `cat identity` >> "$initdir/tmp/active-watchdogs"
> +		    # device/modalias will return driver of this device

Seems I do not find where the identiy being used..

OTOH if we use it in kdump module, we should find it in kdump module code instead
of depending on the tmp file created by wdt module.

Thanks
Dave
