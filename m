From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [PATCH 02/10] output everything to /dev/kmesg and add dmesg
 for the emergency_shell
Date: Fri, 03 Jul 2009 14:11:26 -0400
Message-ID: <1246644686.13823.5.camel@obelisk.thedillows.org>
References: <1246639520-3094-1-git-send-email-harald@redhat.com>
	 <1246639520-3094-3-git-send-email-harald@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1246639520-3094-3-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, 2009-07-03 at 18:45 +0200, Harald Hoyer wrote:

> diff --git a/modules.d/99base/init b/modules.d/99base/init
> index 701706d..b49ba21 100755
> --- a/modules.d/99base/init
> +++ b/modules.d/99base/init
> @@ -7,6 +7,8 @@
>  
>  emergency_shell()
>  {
> +    exec >/dev/console 2>&1 </dev/console
> +    getarg rdinitdebug || dmesg

Ugh, please no. If I want dmesg output in my emergency shell, I can type
'dmesg'. Doing it for me means I may push valuable information from
rdinitdebug out of my scrollback buffer before I've had a chance to
review it and write it down.

Also, this adds a dependency on dmesg to a stripped down install, which
is counter to (my) goal of a smaller initramfs over time.

> -getarg rdinitdebug && set -x
> +if getarg rdinitdebug; then
> +    set -x
> +else
> +    exec >/dev/kmsg 2>&1
> +fi

I'm really not happy about polluting the kernel message source with
dracut messages. I know it is convenient, but in my opinion, dmesg
should only show me kernel messages, not a mixture of kernel and
userspace.

At the very least, we need to add an indication that the message is from
dracut, not the kernel.


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
