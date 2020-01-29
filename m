From: Martin Wilck <mwilck-IBi9RG/b67k@public.gmane.org>
Subject: Re: [PATCH] dracut: Verify multipath config_dir option
Date: Wed, 29 Jan 2020 10:49:21 +0100
Message-ID: <2c0c0f100442edd43b10085fa47177b54cd6d0c9.camel@suse.com>
References: <20200121120834.GA23866@machine1>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200121120834.GA23866@machine1>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Milan P. Gandhi" <mgandhi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On Tue, 2020-01-21 at 17:38 +0530, Milan P. Gandhi wrote:
> The 90multipath/module-setup.sh file currently does not check the
> dm-multipath config_dir option. This option in multipath.conf file is
> used to specify a custom directory/path that contains the multipath
> configuration files. It's default value is /etc/multipath/conf.d
> 
> Currently install function of module-setup.sh has hardcoded the above
> path, but users could change it with config_dir option. So, adding a
> command to get the directory specified with config_dir option and add
> these configuration files to the initial ram disk image.
> 
> Signed-off-by: Milan P. Gandhi <mgandhi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/90multipath/module-setup.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/modules.d/90multipath/module-setup.sh
> b/modules.d/90multipath/module-setup.sh
> index 1f6a55ec..f7c521c1 100755
> --- a/modules.d/90multipath/module-setup.sh
> +++ b/modules.d/90multipath/module-setup.sh
> @@ -78,6 +78,9 @@ install() {
>          }
>      }
>  
> +    # Include multipath configuration files from path specified with
> config_dir
> +    config_dir=`/usr/sbin/multipath -t|grep -i config_dir|awk
> '{print $2}'|sed -e 's/^"//' -e 's/"$//'`/*

No need to use 'grep -i', multipath configuration directives are case-
sensitive. At least one member of that grep|awk|sed pipe can be
dropped. Actually, all of them, for example like this:

while read _k _v; do 
   if [[ "$_k" = config_dir ]]; then 
       _v=${_v#\"}
       config_dir=${_v%\"}
   fi
done < <(multipath -t)

The path (/usr/sbin/multipath) is inconsistent with what we use in
multipathd.service (/sbin/multipath). I'm not against changing this to
/usr, but we should be consistent.

And: fall back to /etc/multipath/conf.d if the command fails for some
reason?

Martin


> +
>      inst_multiple -o  \
>          dmsetup \
>          kpartx \
> @@ -90,7 +93,7 @@ install() {
>          /etc/xdrdevices.conf \
>          /etc/multipath.conf \
>          /etc/multipath/* \
> -        /etc/multipath/conf.d/*
> +        $config_dir
>  
>      [[ $hostonly ]] && [[ $hostonly_mode = "strict" ]] && {
>          for_each_host_dev_and_slaves_all add_hostonly_mpath_conf


