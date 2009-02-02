From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: Re: Current status of dracut.
Date: Mon, 2 Feb 2009 22:41:43 +0100
Message-ID: <20090202214143.GA12625@stro.at>
References: <20090202163708.GA27474@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090202163708.GA27474-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 02 Feb 2009, Dave Jones wrote:

> The current code at git://fedorapeople.org/~katzj/dracut.git
> is just over 600 lines of shell script, and manages to generate an
> initramfs capable of mount root filesystems on raw disk (/dev/sda etc),
> and lvm (/dev/mapper/..)

btw why do we need dracut at all?
your blog has vague allusion against initramfs-tools,
which is much better tested and has seen the field.

beside having more features and flexibility it does not hardcode udev usage,
nor bash, why should it not be considered at first!?

# initramfs-tools repo
git clone git://git.debian.org/kernel/initramfs-tools.git
 
-- 
maks
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
