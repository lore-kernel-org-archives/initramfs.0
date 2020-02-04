From: Martin Wilck <mwilck-IBi9RG/b67k@public.gmane.org>
Subject: Re: [PATCH v3] dracut: Verify multipath config_dir option
Date: Tue, 04 Feb 2020 08:51:19 +0100
Message-ID: <133bdc2cab95f128d673d22f7aff53dc1cb03dec.camel@suse.com>
References: <20200204051243.GA7871@machine1>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200204051243.GA7871@machine1>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Milan P. Gandhi" <mgandhi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On Tue, 2020-02-04 at 10:42 +0530, Milan P. Gandhi wrote:
> The 90multipath/module-setup.sh file currently does not check the
> dm-multipath config_dir option. This option in multipath.conf file is
> used to specify a custom directory/path that contains the multipath
> configuration files. It's default value is /etc/multipath/conf.d
> 
> Currently install function of module-setup.sh has hardcoded the above
> path, but users could change it with config_dir option. So, adding
> steps to read the path specified with config_dir option and add
> these configuration files to the initial ram disk image.
> 
> Signed-off-by: Milan P. Gandhi <mgandhi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
> 
> changes v3:
>  - Removed awk/sed usage to get config_dir path
>  - Added a check to verify if path specifed with
>    config_dir is actual directory
>  - Used derror to report invalid config_dir path
> 
>  modules.d/90multipath/module-setup.sh | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Martin Wilck <mwilck-IBi9RG/b67k@public.gmane.org>

> 
> diff --git a/modules.d/90multipath/module-setup.sh
> b/modules.d/90multipath/module-setup.sh
> index 48a9d09a..2f6d1f7a 100755
> --- a/modules.d/90multipath/module-setup.sh
> +++ b/modules.d/90multipath/module-setup.sh
> @@ -79,6 +79,20 @@ install() {
>          }
>      }
>  
> +    # Include multipath configuration files from path specified with
> config_dir
> +    while read _k _v; do
> +        if [[ "$_k" = config_dir ]]; then
> +            _v=${_v#\"}
> +            config_dir=${_v%\"}
> +        fi
> +    done < <(/sbin/multipath -t)
> +
> +    if [ -d "$config_dir" ]; then
> +        config_dir+="/*"
> +    else
> +        derror "multipath.conf: config_dir - No such directory
> $config_dir"
> +    fi
> +
>      inst_multiple -o  \
>          dmsetup \
>          kpartx \
> @@ -91,7 +105,7 @@ install() {
>          /etc/xdrdevices.conf \
>          /etc/multipath.conf \
>          /etc/multipath/* \
> -        /etc/multipath/conf.d/*
> +        $config_dir
>  
>      [[ $hostonly ]] && [[ $hostonly_mode = "strict" ]] && {
>          for_each_host_dev_and_slaves_all add_hostonly_mpath_conf


