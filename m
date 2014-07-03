From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Installing an OS with VLAN enabled to an ISCSI LUN (from ibft)
Date: Thu, 03 Jul 2014 14:17:09 +0200
Message-ID: <53B549C5.50500@redhat.com>
References: <ABF506AF5815F54BB6579628C0CD9F9956345880E3@AUSX7MCPS310.AMER.DELL.COM>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ABF506AF5815F54BB6579628C0CD9F9956345880E3-aIqoxSDCDny0d/9xeFN5lgVY21JRvFwKV6yJEvX+wlw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Praveen_Paladugu-DYMqY+WieiM@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10.06.2014 17:35, Praveen_Paladugu-DYMqY+WieiM@public.gmane.org wrote:
> 
> When installing OS to a VLAN enabled iscsi LUN (extracted from iBFT), "/tmp/net.{xyz}.has_ibft_config" is not being set properly. 
> 
> Then anaconda installer requires 'BOOTPROTO="ibft"' populated in ifcfg of the vlan interface (ex: ibft0.20), for it to properly populate the kernel parameters post installation. The setting 'BOOTPROTO="ibft"' is populated by write-ifcfg.sh script only if the corresponding interface has a file /tmp/net.{xyz}.has_inft_config
> 
> 
> To get around this issue, in ibft_to_cmdline() function in net-lib.sh file, I made the following changes to populate the has_ibft_config file for the vlan interface(ex: ibft0.20):
> 
> diff -up dracut-033/modules.d/40network/net-lib.sh.old dracut-033/modules.d/40network/net-lib.sh
> --- dracut-033/modules.d/40network/net-lib.sh.old	2014-06-10 10:21:32.326572725 -0500
> +++ dracut-033/modules.d/40network/net-lib.sh	2014-06-10 10:24:28.523422425 -0500
> @@ -248,15 +248,19 @@ ibft_to_cmdline() {
>                     case "$vlan" in
>                         [0-9]*)
>                             echo "vlan=$dev.$vlan:$dev"
> +                           echo $mac > /tmp/net.${dev}.${vlan}.has_ibft_config
>                             ;;
>                         *)
>                             echo "vlan=$vlan:$dev"
> +                           echo $mac > /tmp/net.${dev}.has_ibft_config

shouldn't that be:
echo $mac > /tmp/net.${vlan}.has_ibft_config

>                             ;;
>                     esac
>                 fi
> +            else
> +                echo $mac > /tmp/net.${dev}.has_ibft_config
> +                
>              fi
>  
> -            echo $mac > /tmp/net.${dev}.has_ibft_config

what if vlan==0? I would not do this hunk, but only the first one.
