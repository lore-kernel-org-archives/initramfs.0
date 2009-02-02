From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: Re: Current status of dracut.
Date: Mon, 2 Feb 2009 23:06:05 +0100
Message-ID: <20090202220605.GM2906@baikonur.stro.at>
References: <20090202163708.GA27474@redhat.com> <20090202214143.GA12625@stro.at> <20090202220120.GA16418@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090202220120.GA16418-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, Feb 02, 2009 at 05:01:20PM -0500, Dave Jones wrote:
> 
> "why not use the ubuntu one?"

debian and ubuntu share the same codebase ;D
good question!

> "why not use the suse one?"

haha so you omit nash because it's no fun.
 
> they all have some good and bad tradeoffs. Distro X has feature Y
> which no-one else does. etc.

starting from zero was also the path that initramfs-tools took.
as initrd-tools written by Xu didn't scale up to all the new root ways.
the flexibility and framework is although much better thought,
it seems to me on a quick look.
 
> When the project began we spent some time looking at what everyone
> else already does, and "lets start over and hope others participate"
> seemed more attractive than taking an existing one and bending it to fit.

well
the trouble is dracut is carrying already some design decisions,
that make it currently a big nogo.

beside from formal questions as commit accesses to interested devs.

please be more precise what speaks against initramfs-tools.

-- 
maks
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
