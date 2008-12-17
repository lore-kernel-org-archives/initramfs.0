From: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: Dracut -- Cross distribution initramfs infrastructure
Date: Wed, 17 Dec 2008 14:07:01 -0500
Message-ID: <20081217190700.GA15377__22118.0711793297$1232286214$gmane$org@infradead.org>
References: <1229540094.28858.150.camel@aglarond.local>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1229540094.28858.150.camel-T9xAYgMuJli44ywRPIzf9A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>, Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, cjwatson-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

On Wed, Dec 17, 2008 at 01:54:54PM -0500, Jeremy Katz wrote:
> As davej started talking about a few months ago at Kernel Summit and
> LPC, there's a lot of duplication between distros on the tools used to
> generate the initramfs as well as the contents and how the initramfs
> works.  Ultimately, there's little reason for this not to be something
> that is shared and worked on by everyone.  Added to this is the fact
> that everyone's infrastructures for this have grown up over a long-ish
> period of time without significant amounts of reworking for the way that
> the kernel and early boot works these days.
> 
> Therefore I've started on a new project, dracut, to try to be a new
> initramfs tool that can be used across various distributions.  From the
> README...

It looks like Hannes has also been working on a new, modular initramfs
for a while:

	http://git.kernel.org/?p=linux/kernel/git/hare/mkinitrd.git;a=summary

I hope you guys can get together and agree on one implementation..
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
