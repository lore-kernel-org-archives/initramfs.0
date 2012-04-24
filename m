From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] ifcfg: write DNS1=... for nameserver= args (RHBZ#815369)
Date: Tue, 24 Apr 2012 12:23:25 -0400
Message-ID: <1335284605.24859.18.camel@samus.usersys.redhat.com>
References: <1335212725-20178-1-git-send-email-wwoods@redhat.com>
	 <4F968443.8020403@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F968443.8020403-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 2012-04-24 at 12:45 +0200, Harald Hoyer wrote:

> Hmm, I have this in my queue (different location):
>
> diff --git a/modules.d/45ifcfg/write-ifcfg.sh b/modules.d/45ifcfg/write-ifcfg.sh
> index c072a13..b81ac39 100755
> --- a/modules.d/45ifcfg/write-ifcfg.sh
> +++ b/modules.d/45ifcfg/write-ifcfg.sh
> @@ -138,6 +138,11 @@ for netif in $IFACES ; do
>              } >> /tmp/ifcfg/ifcfg-$ethname
>          fi
>      fi
> +    i=1
> +    for ns in $(getargs nameserver); do
> +        echo "DNS${i}=${ns}" >> /tmp/ifcfg/ifcfg-$netif
> +        i=$((i+1))
> +    done
>  done
> 
>  # Pass network opts

The code is actually equivalent, although I find this version confusing
since it comes after all the other special cases (I thought it was part
of the 'if [ -n "$bridge" ]' block at first!)

I'm sending an amended patch that puts it right next to all the other
unconditional stuff near the top of the loop - I think that's clearest.

-w
