From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: No stdout when using dash
Date: Sat, 23 May 2009 07:29:07 -0500
Message-ID: <1243081747.29452.38.camel@sentry-no.us.dell.com>
References: <Pine.LNX.4.58.0905231331400.2058@gate.bb.dicp.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=3Nv8js+0zryiSUTCPjSWZJBAZxnwMuzhTa5SxhZA818=;
        b=Qgg7ZFiDBwQJZnmsQccKCtHUuPNuF8By1gkum75jYikj0U8waSe654Jq18Mwjy429u
         4bC676d44BkSk79dV00RQySLhBzk0cUSHfkckm9P2vTOdCF6cFvMyZ6h7EfWMHKGjgRt
         CXN/bcBp6+MRsLIcv38DdK8FZvkV4rYZeRTDY=
In-Reply-To: <Pine.LNX.4.58.0905231331400.2058-bvJ793YqIODNUDpmljszgg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sat, 2009-05-23 at 13:34 +0200, Andreas Thienemann wrote:
> When using the 00dash module in dracut, the emergency_shell currently has 
> no stderr.
> 
> Problem is related to dash closing stderr if opening /dev/tty fails.
> 
> I just triggered an update to dash in fedora F11 and rawhide fixing this 
> behaviour.
> This should make the emergency shell much easier to work with.

Can you also post the fix upstream?  That way those of us who are not
developing on Fedora can also benefit. :)

> regards,
>  andreas
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
