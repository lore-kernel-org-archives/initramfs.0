From: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Current status of dracut.
Date: Mon, 2 Feb 2009 17:01:20 -0500
Message-ID: <20090202220120.GA16418@redhat.com>
References: <20090202163708.GA27474@redhat.com> <20090202214143.GA12625@stro.at>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090202214143.GA12625-U9r9yeDMy7A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, Feb 02, 2009 at 10:41:43PM +0100, maximilian attems wrote:
 > On Mon, 02 Feb 2009, Dave Jones wrote:
 > 
 > > The current code at git://fedorapeople.org/~katzj/dracut.git
 > > is just over 600 lines of shell script, and manages to generate an
 > > initramfs capable of mount root filesystems on raw disk (/dev/sda etc),
 > > and lvm (/dev/mapper/..)
 > 
 > btw why do we need dracut at all?
 > your blog has vague allusion against initramfs-tools,
 > which is much better tested and has seen the field.
 > 
 > beside having more features and flexibility it does not hardcode udev usage,
 > nor bash, why should it not be considered at first!?
 > 
 > # initramfs-tools repo
 > git clone git://git.debian.org/kernel/initramfs-tools.git
 >  
 > -- 
 > maks
---end quoted text---

"why not use the ubuntu one?"
"why not use the suse one?"

they all have some good and bad tradeoffs. Distro X has feature Y
which no-one else does. etc.

When the project began we spent some time looking at what everyone
else already does, and "lets start over and hope others participate"
seemed more attractive than taking an existing one and bending it to fit.

	Dave

-- 
http://www.codemonkey.org.uk
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
