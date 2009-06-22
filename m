From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: Re: Bug#533903: initramfs-tools: support different compression
 tools in mkinitramfs
Date: Mon, 22 Jun 2009 23:40:41 +0200
Message-ID: <20090622214041.GE6173@stro.at>
References: <20090621133116.32436.69638.reportbug@grmlvrs>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090621133116.32436.69638.reportbug@grmlvrs>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Prokop <mika-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, 533903-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sun, 21 Jun 2009, Michael Prokop wrote:

> Package: initramfs-tools
> Version: 0.93.3
> Severity: wishlist
> 
> 
> Current kernel versions support different decompression options for
> kernel and initrd:
> 
>   CONFIG_DECOMPRESS_GZIP
>   CONFIG_DECOMPRESS_BZIP2
>   CONFIG_DECOMPRESS_LZMA

i haven't played with those, but yes why not.


do you know what happens if initramfs is in lzma but kernel not?
 
> initramfs-tools currently supports gzip only. I'd like to see
> support for bzip2 and lzma as well, as both of them provide better
> compression (which is especially interesting for live systems).
> 
> IMHO the user should get gzip by default (if unset) but be able to
> choose between gzip, bzip2 and lzma. Something like
> COMPRESSION=[gzip|bzip2|lzma] in /etc/initramfs-tools/initramfs.conf
> should provide that.
> 
> I plan to provide the according code for integration (though I'm
> running out of time right now, so it might need a few days/weeks).
> Please ACK my idea if that's in your interest. If have any special
> configuration variable / implementation wishes please let me know.

adding the dracut guys on cc, afais they haven't implement it
yet too, so maybe we can easily agree:
~/src/dracut$ egrep gzip dracut
( cd "$initdir"; find . |cpio -H newc -o |gzip -9 > "$outfile"; )



--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
