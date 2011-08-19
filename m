From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: Re: build initramfs: uncontrolled LD_LIBRARY_PATH
Date: Fri, 19 Aug 2011 09:18:07 -0700
Message-ID: <4E4E8CBF.1080104@bitwagon.com>
References: <4E4DDD15.30202@bitwagon.com> <4E4DFDB1.9090203@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E4DFDB1.9090203-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

> --- a/dracut
> +++ b/dracut
> @@ -265,6 +265,7 @@ fi
> 
>  PATH=/sbin:/bin:/usr/sbin:/usr/bin
>  export PATH
> +unset LD_LIBRARY_PATH

Also unset LD_PRELOAD, although it's not quite as bad as LD_LIBRARY_PATH.
[See "LD_PRELOAD=/lib64/libreadline.so.6 ldd /bin/date".]

-- 
