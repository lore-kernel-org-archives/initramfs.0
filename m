From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] return proper value in function dracut_install
Date: Tue, 16 Oct 2012 17:19:44 +0200
Message-ID: <507D7B10.1000507@redhat.com>
References: <20121008094008.GA19986@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121008094008.GA19986-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 08.10.2012 11:40, schrieb Dave Young:
> dracut_install should return the real return value, so module install function
> can detect the install failure.
> 
> Such as below in 99base:
> dracut_install switch_root || dfatal "Failed to install switch_root"
> 
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  dracut-functions.sh |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> --- dracut.orig/dracut-functions.sh
> +++ dracut/dracut-functions.sh
> @@ -563,9 +563,12 @@ if [[ $DRACUT_INSTALL ]]; then
>      }
>  
>      dracut_install() {
> +        local ret
>          #dinfo "initdir=$initdir $DRACUT_INSTALL -l $@"
>          $DRACUT_INSTALL ${initdir+-D "$initdir"} -a ${DRACUT_RESOLVE_DEPS+-l}  ${DRACUT_FIPS_MODE+-H} "$@"
> -        (($? != 0)) && derror $DRACUT_INSTALL ${initdir+-D "$initdir"} -a ${DRACUT_RESOLVE_DEPS+-l}  ${DRACUT_FIPS_MODE+-H} "$@" || :
> +        ret=$?
> +        (($ret != 0)) && derror $DRACUT_INSTALL ${initdir+-D "$initdir"} -a ${DRACUT_RESOLVE_DEPS+-l}  ${DRACUT_FIPS_MODE+-H} "$@" || :
> +        return $ret
>      }
>  
>      inst_library() {
> 

https://admin.fedoraproject.org/updates/dracut-024-1.fc18
