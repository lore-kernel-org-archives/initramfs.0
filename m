From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] add default values in fstab_lines
Date: Fri, 28 Feb 2014 12:11:14 +0100
Message-ID: <53106ED2.4080607@redhat.com>
References: <20140227024423.GA20712@dhcp-16-126.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140227024423.GA20712-je1gSBvt1TcFLmT5oZ11vB/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 02/27/2014 03:44 AM, Dave Young wrote:
> It's useful for passing a full fstab line including like fs_passno so fsck
> can take effect.
> 
> Previously it's assumed that there's no fs_freq and fs_passno in fstab lines
> so original code just append "0 0" at the end of each fstab lines.
> 
> Improve this issue by assign default value in case they are not passed in.
> Three field are handled here:
> fs_mntops: default to "defaults"
> fs_freq: default to "0"
> fs_passno: default to "2" 
> 
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  dracut.8.asc |   10 +++++++---
>  dracut.sh    |    6 +++++-
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> --- dracut.orig/dracut.sh
> +++ dracut/dracut.sh
> @@ -1299,7 +1299,11 @@ if [[ $kernel_only != yes ]]; then
>      [[ $kernel_cmdline ]] && printf "%s\n" "$kernel_cmdline" >> "${initdir}/etc/cmdline.d/01-default.conf"
>  
>      while pop fstab_lines line; do
> -        printf "%s\n" "$line 0 0" >> "${initdir}/etc/fstab"
> +        line=($line)
> +        [ -z "${line[3]}" ] && line[3]="defaults"
> +        [ -z "${line[4]}" ] && line[4]="0"
> +        [ -z "${line[5]}" ] && line[5]="2"
> +        echo "${line[@]}" >> "${initdir}/etc/fstab"
>      done
>  
>      for f in $add_fstab; do
> --- dracut.orig/dracut.8.asc
> +++ dracut/dracut.8.asc
> @@ -311,9 +311,13 @@ provide a valid _/etc/fstab_.
>  **--add-fstab** _<filename>_::
>      Add entries of _<filename>_ to the initramfs /etc/fstab.
>  
> -**--mount** "_<device>_ _<mountpoint>_ _<filesystem type>_ _<filesystem options>_"::
> -    Mount _<device>_ on _<mountpoint>_ with _<filesystem type>_ and _<filesystem
> -    options>_ in the initramfs
> +**--mount** "_<device>_ _<mountpoint>_ _<filesystem type>_ [_<filesystem options>_ [_<dump frequency>_ [_<fsck order>_]]]"::
> +    Mount _<device>_ on _<mountpoint>_ with _<filesystem type>_ in the
> +    initramfs. _<filesystem options>_, _<dump options>_ and _<fsck order>_ can
> +    be specified, see fstab manpage for the details.
> +    The default _<filesystem options>_ is "defaults".
> +    The default _<dump frequency>_ is "0".
> +    the default _<fsck order>_ is "2".
>  
>  **--add-device** _<device>_ ::
>      Bring up _<device>_ in initramfs, _<device>_ should be the device name.
> 
> 

Thanks! Pushed.
