From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] Final fixups to make the full testsuite work.
Date: Tue, 26 May 2009 07:15:42 -0500
Message-ID: <1243340142.4005.8.camel@sentry-no.us.dell.com>
References: <151d32e89583815962af8d721b17d0b320f80a2f.1243306326.git.victor.lowther@gmail.com>
	 <4A1BB5DE.3090206@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=7wrm2HjDQ53LZMvSHOBjgZ29sf76LbERLnAbIL5Gnm4=;
        b=k0x8z6kMgED+658iRUDC2njeRkB9jyML6Vu2sGuqP9oCjOOZrE2yEV7KLb/RZEBG8V
         93vX9x909hssC3FxmEV3X+HGpyIWdBaYfqNXYXvozOj5IBzyMnfPWaBpctPo/4szL0+v
         1A6+mXi2h1BArUSfmtobpv5OUaGf99DLkAs3I=
In-Reply-To: <4A1BB5DE.3090206-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 2009-05-26 at 11:26 +0200, Harald Hoyer wrote:
> On 05/26/2009 04:57 AM, Victor Lowther wrote:
> > test-10 now completes sucessfully.  What has changed:
> 
> hmm, it completed sucessfully on Fedora 11 without any problems..

Ah, distro issues.  I have been doing all my recent work using Ubuntu
9.04 x86_64.

I suppose that brings up another rather fundamental question -- what
degree of cross-distro compatibility should we be building into dracut
from the beginning?  I try to write things so that dracut will work on
anything whose udev rules are reasonably in line with upstream -
everything but Debian, these days

Is anyone besides me testing dracut on something that isn't Fedora?

-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
