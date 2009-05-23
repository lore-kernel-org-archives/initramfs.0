From: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>
Subject: Re: No stdout when using dash
Date: Sat, 23 May 2009 15:06:37 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0905231458100.2058@gate.bb.dicp.net>
References: <Pine.LNX.4.58.0905231331400.2058@gate.bb.dicp.net>
 <1243082881.29452.45.camel@sentry-no.us.dell.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1243082881.29452.45.camel-76q0VzFBGGqhmyxYjSZgiRL4W9x8LtSr@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sat, 23 May 2009, Victor Lowther wrote:

> In the meantime, though...

That patch is unneeded for the current functionality.
/dev/tty cannot be opened, even though you're creating it.

strace gives:
open("/dev/tty", O_RDWR) = -1 ENXIO (No such device or address)

Thus reshuffling the set -x call later doesn't do any good.

Furthermore: tty is not needed for basic shell functionality at all.

regards,
 andreas
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
