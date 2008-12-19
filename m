From: Bernhard Walle <bwalle-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Dracut -- Cross distribution initramfs infrastructure
Date: Fri, 19 Dec 2008 09:18:41 +0100
Message-ID: <20081219091841.207bc951@kopernikus.site>
References: <1229540094.28858.150.camel@aglarond.local>
	<20081217190700.GA15377@infradead.org>
	<4949FD67.6040906@suse.de>
	<494B5031.5080306@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <494B5031.5080306-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>, Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>, Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, cjwatson-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org, Bernhard Walle <bwalle-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>

* Seewer Philippe [2008-12-19 08:41]:
>
> Hannes Reinecke wrote:
> [snip]
> > If anyone is interested I can give a short overview of it.
> Please do so, would be appreciated.

A good start is the manual page in section 5:
http://git.opensuse.org/?p=projects/mkinitrd.git;a=blob_plain;f=man/mkinitrd.5.txt;hb=7583c3cc047edc3e8f1a06e8b7925bd27ac0228c

(The git.kernel.org and the opensuse.org repos are basically the same,
we just switched to opensuse.org after the internal maintainership has
been transferred from Hannes to myself because it was easier to add
new users there. The opensuse.org git repo site didn't exist when the
kernel.org mkinitrd repo was created.)

Anyway:

The basic idea is to have most stuff not in the main 'mkinitrd' script
but in modules. Each module has (normally) a setup script part that is
executed when the initrd is created, and a boot part that is executed
when the initrd is running. For example, NFS root is in the 'nfs-util'
package, not in 'mkinitrd'. Same for iSCSI. Or the kdump part is
not in the main mkinitrd but in our 'kdump' package [1]. So the main
initrd  package is quite small but still very flexible.

It's also flexible enough to use Busybox as module that resides in the
'busybox' package and can then be enabled with -F busybox (feature)
when building the initrd.

Only documentation is at the current time a bit weak, one has to fiddle
some stuff from the sources when writing new modules. But that's easy
to fix. :-)

Hannes may explain more ...



    Bernhard

[1] hg clone http://freehg.org/u/bwalle/kdump/
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
