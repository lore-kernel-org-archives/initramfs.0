From: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut vs vanilla kernel: requires
	/lib/modules/$kernel/module.block
Date: Tue, 3 Feb 2009 14:11:38 -0500
Message-ID: <20090203191138.GC2631@nostromo.devel.redhat.com>
References: <e9c3a7c20902031048u4d41036cj6761baace60ed6e1@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e9c3a7c20902031048u4d41036cj6761baace60ed6e1-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Dan Williams (dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org) said: 
> Is this something that should be added to dracut, or upstreamed into Kbuild?

The idea is that we don't want to include every single module, but we
want to include every module that might define a block device to boot
from, or a network device to network boot from. Having it in the upstream
kernel would be helpful, although how it's generated now is obviously
a hack.

Doing it at runtime in dracut would work, but would be obviously slow.

Bill
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
