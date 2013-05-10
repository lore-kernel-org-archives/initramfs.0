From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch] 01fips/module-setup.sh: add libssl.so.10 to make kdump
 work with fips mode
Date: Fri, 10 May 2013 11:24:41 +0800
Message-ID: <518C6879.5070204@redhat.com>
References: <bccc4bdfbdbdb14122cf83819a7ba16334348acc.1368088634.git.bhe@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <bccc4bdfbdbdb14122cf83819a7ba16334348acc.1368088634.git.bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 05/09/2013 04:38 PM, Baoquan He wrote:
> FIPS can work well in 1st kernel, but failed in kdump kernel. the
> libssl.so.10 and related hmac file are needed. Now add it and it
> works.

This patch looks good to me.

Explain a bit about why do we need this extra libssl.so.10:

libcrypto.so dlopens libssl.so.10 only in FIPS mode, so ldd does now
show the dependency automaticlly.



> 
> Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/01fips/module-setup.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/modules.d/01fips/module-setup.sh b/modules.d/01fips/module-setup.sh
> index a7f5be8..6013318 100755
> --- a/modules.d/01fips/module-setup.sh
> +++ b/modules.d/01fips/module-setup.sh
> @@ -38,7 +38,7 @@ install() {
>  
>      inst_libdir_file libsoftokn3.so libsoftokn3.so \
>          libsoftokn3.chk libfreebl3.so libfreebl3.chk \
> -        libssl.so 'hmaccalc/sha512hmac.hmac'
> +        libssl.so 'hmaccalc/sha512hmac.hmac' libssl.so.10
>  
>      dracut_install -o prelink
>  }
> 


-- 
Thanks
Dave

