From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: Re: [PATCH 01/31] Some dracut cleanups and bashification.
Date: Tue, 10 Feb 2009 13:17:45 +0100
Message-ID: <20090210121745.GC15532@stro.at>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com> <20090209171521.GA3646@redhat.com> <7FE9B1BD-31DA-4605-9881-3C42A05075E3@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7FE9B1BD-31DA-4605-9881-3C42A05075E3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, 09 Feb 2009, Victor Lowther wrote:

> Yeah, having the bits that end up in the initrd be posix is a good  
> design constraint.

yep, please test with dash before introducing further bashism.


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
