From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut.sh: Fix [no-]early-microcode parameter and add
 documentation.
Date: Mon, 19 Aug 2013 11:02:38 -0400
Message-ID: <20130819150238.GG7185@konrad-lan.dumpdata.com>
References: <1376687775-31272-1-git-send-email-farbing@web.de>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1376687775-31272-1-git-send-email-farbing-S0/GAf8tV78@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Schaal <farbing-S0/GAf8tV78@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, Aug 16, 2013 at 11:16:15PM +0200, Daniel Schaal wrote:
> [no-]early-microcode was missing from getopt argument list.
> 
> Let arguments passed by command line override config files.

Ooh, didn't even realize those needed to be changed. Thank you!
> ---
>  dracut.8.asc      | 6 ++++++
>  dracut.conf.5.asc | 3 +++
>  dracut.sh         | 8 ++++++--
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/dracut.8.asc b/dracut.8.asc
> index 714ba85..ee9d8de 100644
> --- a/dracut.8.asc
> +++ b/dracut.8.asc
> @@ -225,6 +225,12 @@ example:
>  **--no-kernel**::
>      do not install kernel drivers and firmware files
>  
> +**--early-microcode**::
> +    Combine early microcode with ramdisk
> +
> +**--no-early-microcode**::
> +    Do not combine early microcode with ramdisk
> +
>  **--print-cmdline**::
>      print the kernel command line for the current disk layout
>  
> diff --git a/dracut.conf.5.asc b/dracut.conf.5.asc
> index df876cc..89beeb1 100644
> --- a/dracut.conf.5.asc
> +++ b/dracut.conf.5.asc
> @@ -117,6 +117,9 @@ If chrooted to another root other than the real root device, use --fstab and pro
>  *no_kernel=*"{yes|no}"::
>      Do not install kernel drivers and firmware files (default=no)
>  
> +*early_microcode=*"{yes|no}"::
> +    Combine early microcode with ramdisk (default=no)
> +
>  *stdloglvl*="__\{0-6\}__"::
>      Set logging to standard error level.
>  
> diff --git a/dracut.sh b/dracut.sh
> index d0d1c11..7071d05 100755
> --- a/dracut.sh
> +++ b/dracut.sh
> @@ -346,6 +346,8 @@ TEMP=$(unset POSIXLY_CORRECT; getopt \
>      --long printsize \
>      --long regenerate-all \
>      --long noimageifnotneeded \
> +    --long early-microcode \
> +    --long no-early-microcode \
>      -- "$@")
>  
>  if (( $? != 0 )); then
> @@ -388,8 +390,8 @@ while :; do
>          --kernel-only) kernel_only="yes"; no_kernel="no";;
>          --no-kernel)   kernel_only="no"; no_kernel="yes";;
>          --print-cmdline) print_cmdline="yes"; hostonly_l="yes"; kernel_only="yes"; no_kernel="yes";;
> -        --early-microcode) early_microcode="yes";;
> -        --no-early-microcode) early_microcode="no";;
> +        --early-microcode) early_microcode_l="yes";;
> +        --no-early-microcode) early_microcode_l="no";;
>          --strip)       do_strip_l="yes";;
>          --nostrip)     do_strip_l="no";;
>          --hardlink)    do_hardlink_l="yes";;
> @@ -665,6 +667,8 @@ stdloglvl=$((stdloglvl + verbosity_mod_l))
>  [[ $show_modules_l ]] && show_modules=$show_modules_l
>  [[ $nofscks_l ]] && nofscks="yes"
>  [[ $ro_mnt_l ]] && ro_mnt="yes"
> +[[ $early_microcode_l ]] && early_microcode=$early_microcode_l
> +[[ $early_microcode ]] || early_microcode=no
>  # eliminate IFS hackery when messing with fw_dir
>  fw_dir=${fw_dir//:/ }
>  
> -- 
> 1.8.4.rc2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
