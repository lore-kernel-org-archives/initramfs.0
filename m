From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut: Override rd.md settings if rd.md.uuid is provided
Date: Thu, 06 Sep 2012 12:14:15 +0200
Message-ID: <50487777.1050502@redhat.com>
References: <20120905212047.GE19749@redhat.com> <20120905212434.GA27154@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120905212434.GA27154-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Am 05.09.2012 23:24, schrieb Vivek Goyal:
> On Wed, Sep 05, 2012 at 05:20:47PM -0400, Vivek Goyal wrote:
>>
>> Currently anaconda provides rd.md=0 on kernel's command line as a boot
>> time optimization if root is not on md device. But this leads to kdump
>> failure. We copy the command line from first kernel and if dump target
>> is on md device, it fails as we never try to assemble md devices as
>> rd.md=0.
> 
> Oops, forgot to refresh the patch before sending. Please ignore the
> previous version. Take this version of patch.
> 
> Thanks
> Vivek
> 
> Currently anaconda provides rd.md=0 on kernel's command line as a boot
> time optimization if root is not on md device. But this leads to kdump
> failure. We copy the command line from first kernel and if dump target
> is on md device, it fails as we never try to assemble md devices as
> rd.md=0.
> 
> We have already set rd.md.uuid though in /etc/cmdlind.d/ dir providing
> dracut the info about what md devices to assemble. So this patch overrides
> rd.md settings if rd.md.uuid is provided.
> 
> This is a stop gap measure to get kdump working on software raid
> devices. Harald seems to have bigger cleanup plans for rd.md. Once
> that happens, this patch will not be needed and things should
> automatically be fixed.
> 
> Signed-off-by: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  lib/dracut/modules.d/90mdraid/parse-md.sh |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> Index: /lib/dracut/modules.d/90mdraid/parse-md.sh
> ===================================================================
> --- .orig/lib/dracut/modules.d/90mdraid/parse-md.sh	2012-04-05 07:54:38.000000000 -0400
> +++ /lib/dracut/modules.d/90mdraid/parse-md.sh	2012-09-05 11:12:10.219001187 -0400
> @@ -1,7 +1,12 @@
>  #!/bin/sh
>  # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
>  # ex: ts=8 sw=4 sts=4 et filetype=sh
> -if ! getargbool 1 rd.md -n rd_NO_MD; then
> +MD_UUID=$(getargs rd.md.uuid rd_MD_UUID=)
> +
> +# If rd.md.uuid or rd_MD_UUID is specified, override rd.md settings.
> +[ -n "$MD_UUID" ] && override_rd_md=1
> +
> +if [ -z "$override_rd_md" ] && [ ! $(getargbool 1 rd.md -n rd_NO_MD) ]; then
>      info "rd.md=0: removing MD RAID activation"
>      udevproperty rd_NO_MD=1
>  else
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


Similar patch comitted upstream
