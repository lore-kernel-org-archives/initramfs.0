From: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>
Subject: Re: --include functionality?
Date: Wed, 20 May 2009 21:38:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0905202135570.7805@gate.bb.dicp.net>
References: <Pine.LNX.4.58.0905201806160.7805@gate.bb.dicp.net>
 <7969D0E7-3BC0-46AC-A75B-1EEFA85DAE67@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7969D0E7-3BC0-46AC-A75B-1EEFA85DAE67-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, 20 May 2009, Victor Lowther wrote:

> The test framework uses it to inject the files needed for the root  
> filesystem.

You sure about that?

--include is not used at all.
What the test scripts do is to source dracut-functions and call 
dracut-install().

That is perfectly okay and I wasn't suggesting changing this. I was 
thinking about the --include command line switch.

regards,
 andreas
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
