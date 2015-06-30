From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut-functions.sh: move early mkdir code to dracut.sh
Date: Tue, 30 Jun 2015 09:53:32 +0800
Message-ID: <20150630015332.GA9752@localhost.localdomain>
References: <20150625020802.GA20085@dhcp-128-31.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150625020802.GA20085-0VdLhd/A9PkMZ+PoPUf8/x/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/25/15 at 10:08am, Dave Young wrote:
> Move early mkdir code to dracut.sh so that dracut-fuctions.sh can
> be used by other components.
> 
> For example Fedora kdump mkdumprd uses several functions which were
> copied from dracut-functions.sh, with this patch applied dracut-functions.sh
> contains only functions so that we can remove the duplicate code in kdump.
> 
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  dracut-functions.sh |   11 -----------
>  dracut.sh           |   11 +++++++++++
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> Index: dracut/dracut-functions.sh
> ===================================================================
> --- dracut.orig/dracut-functions.sh
> +++ dracut/dracut-functions.sh
> @@ -19,17 +19,6 @@
>  #
>  export LC_MESSAGES=C
>  
> -if [[ $DRACUT_KERNEL_LAZY ]] && ! [[ $DRACUT_KERNEL_LAZY_HASHDIR ]]; then
> -    if ! [[ -d "$initdir/.kernelmodseen" ]]; then
> -        mkdir -p "$initdir/.kernelmodseen"
> -    fi
> -    DRACUT_KERNEL_LAZY_HASHDIR="$initdir/.kernelmodseen"
> -fi
> -
> -if [[ $initdir ]] && ! [[ -d $initdir ]]; then
> -    mkdir -p "$initdir"
> -fi
> -

self NACK, will repost and export DRACUT_KERNEL_LAZY_HASHDIR earlier
Also I need reuse push/pop functions in multipath module so I will repost
another patch series later.

Thanks
Dave
