From: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>
Subject: Re: No stdout when using dash
Date: Sat, 23 May 2009 14:51:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0905231450240.2058@gate.bb.dicp.net>
References: <Pine.LNX.4.58.0905231331400.2058@gate.bb.dicp.net>
 <1243081747.29452.38.camel@sentry-no.us.dell.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1243081747.29452.38.camel-76q0VzFBGGqhmyxYjSZgiRL4W9x8LtSr@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sat, 23 May 2009, Victor Lowther wrote:

> > I just triggered an update to dash in fedora F11 and rawhide fixing this 
> > behaviour.
> > This should make the emergency shell much easier to work with.
> Can you also post the fix upstream?  That way those of us who are not
> developing on Fedora can also benefit. :)

No need. The patch has been pulled from upstream git.There just hasn't 
been a new upstream release:

commit fcc4134a7b76d82d39dea635c41ec593a41d6d19
Author: Herbert Xu <herbert-lOAM2aK0SrRLBo1qDEOMRrpzq4S04n8Q@public.gmane.org>
Date:   Sun Feb 22 19:29:48 2009 +0800


regards,
 andreas
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
