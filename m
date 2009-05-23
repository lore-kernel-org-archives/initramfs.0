From: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Subject: Re: No stdout when using dash
Date: Sat, 23 May 2009 15:26:49 +0200
Message-ID: <ac3eb2510905230626k5a8b3d25l5c4de0c9017b9c80@mail.gmail.com>
References: <Pine.LNX.4.58.0905231331400.2058@gate.bb.dicp.net> 
	<1243082881.29452.45.camel@sentry-no.us.dell.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1243082881.29452.45.camel-76q0VzFBGGqhmyxYjSZgiRL4W9x8LtSr@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sat, May 23, 2009 at 14:48, Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> +getarg ramfsdebug && set -x

Btw, "ramfs" is a well known kernel filesystem type, I don't think we
should use that name here.

The kernel parameter which binary to start in initramfs is "rdinit",
unlike "init" which is the binary to start in the real rootfs. Maybe
we just keep the rd-prefix for such variables?

Thanks,
Kay
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
