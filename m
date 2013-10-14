From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch] to add support for lzop(1), lz4(1) & INITRD_COMPRESS
Date: Mon, 14 Oct 2013 09:39:16 +0200
Message-ID: <525B9FA4.3020707@redhat.com>
References: <alpine.LFD.2.03.1310112043070.4392@erqung.pbz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LFD.2.03.1310112043070.4392-L4k/hFI9D5Ym7TDOsKvhyg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: P J P <ppandit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/11/2013 06:45 PM, P J P wrote:
>   Hello,
> 
> Attached herein is a patch for the dracut(8) tool. It adds support for the
> lzop(1) & lz4(1) compression algorithms for creating initramfs images. Both
> algorithms are supported by the Linux kernel.
> 
> Linux kernel also exports user's choice of initramfs compression algorithm to a
> shell environment variable: INITRD_COMPRESS.
> 
>  -> http://www.spinics.net/lists/mm-commits/msg100054.html
> 
> The attached patch recognises this variable, but sets it at lower precedence
> than the command line options. Ie. dracut(8) command line options --gzip,
> --bzip2 etc. would override the compression algorithm defined by the
> $INITRD_COMPRESS environment variable.
> 
> Could someone please review this patch?
> 
> Thank you.

Thanks! Applied, added documentation to dracut.8.asc and pushed
