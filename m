From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] replace switch_root shell script with binary
Date: Wed, 04 Mar 2009 16:50:01 -0600
Message-ID: <1236207001.6500.44.camel@sentry-no.fnordovax.org>
References: <49AE7A1F.3040508@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=9PgA3yr0BUuGHMg0Tfxj++uA2za5nuoY3VBI0kU7NNg=;
        b=pIjwHNbghfju/0JnzFvRqDId5H+lglO3MOCAcoHDoEituys7Ee0thrkwEylgRsicTZ
         20kemjXs8Jk8anNI/vZLsHO/aifhT9G3st5TFxo+SElp3gb1aT/naVp9o7SsrUXJBnVW
         onMFY1rFRa9EElQBh/sH4nZhJlIGO1eqOCw7Q=
In-Reply-To: <49AE7A1F.3040508-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, 2009-03-04 at 13:54 +0100, Harald Hoyer wrote:
> The switch_root shell script did not work with bash-4.0-2, because
> "exec" gets the real path of the executable which is then
> "/sysroot/lib/ld-linux.so.2" instread of "./lib/ld-linux.so.2".

That is a little odd -- dash does not exhibit that behaviour.  

The only command that tries to use ./lib/ld-linux.so.2 is the final
chroot, and at that point /sysroot does not mean anything anymore
because of the move mount we did.  Is this a bug in bash we can work
around by setting $PWD?

> Also the required chroot binary might live in /usr/bin, which can
> be mounted later.

yeah, but /usr/sbin and /usr/bin are stupid places to have chroot, it is
a core utility anyways. :)

[ patch snipped ]

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
