From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut options for installing files and drivers
Date: Thu, 10 May 2012 10:10:01 +0800
Message-ID: <4FAB2379.2050504@redhat.com>
References: <4FAA1E44.2090006@redhat.com> <4FAA65B7.9040209@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FAA65B7.9040209-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 05/09/2012 08:40 PM, Harald Hoyer wrote:

> Am 09.05.2012 09:35, schrieb Dave Young:
>> Hi, harald
>>
>> Dracut options '-I' and '-a' both mean optionally install file/ko
> 
> this is wrong
> 
> $ man dracut
> 
> "-a" means
> 
>        -a, --add <list of dracut modules>


modules install happens in modules.d/90kernel-modules/module-setup.sh
but module-setup.sh does not check the return value of instmods, so it
will not fail and exit if no such modules.

Also another problem is there's no check of module install() return status..

>            add a space-separated list of dracut modules to the default set of
> modules. This parameter
>            can be specified multiple times.
> 
>                Note
>                If [LIST] has multiple arguments, then you have to put these in
> quotes. For example:
> 
>                    # dracut --add "module1 module2"  ...
> 
> "-I" means
> 
>        -I, --install <file list>


See below code, dracut_install -o means "optional install", isn't it?
    for item in $install_items; do
        dracut_install -o "$item"
    done


>            install the space separated list of files into the initramfs.
> 
>                Note
>                If [LIST] has multiple arguments, then you have to put these in
> quotes. For example:
> 
>                +
> 
>                    # dracut --install "/bin/foo /sbin/bar"  ...
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
