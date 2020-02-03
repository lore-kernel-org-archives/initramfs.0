From: Martin Wilck <mwilck-IBi9RG/b67k@public.gmane.org>
Subject: Re: [PATCH v2] dracut: Verify multipath config_dir option
Date: Mon, 03 Feb 2020 13:59:16 +0100
Message-ID: <89c04b96b10322918b1fce9afda885254556f3af.camel@suse.com>
References: <20200203113034.GA19959@machine1>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200203113034.GA19959@machine1>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Milan P. Gandhi" <mgandhi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On Mon, 2020-02-03 at 17:00 +0530, Milan P. Gandhi wrote:
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
> changes v2:
>  - Removed awk/sed usage to get config_dir path
>  - Added a check to verify if path specifed with
>    config_dir is actual directory
> 
>  modules.d/90multipath/module-setup.sh | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/modules.d/90multipath/module-setup.sh
> b/modules.d/90multipath/module-setup.sh
> index 48a9d09a..7609ff52 100755
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
> +        echo "multipath.conf: config_dir - No such directory
> $config_dir"

I believe new code should use derror or dwarning here instead of plain
echo. Otherwise, it's looking good.

Martin


