From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: --include functionality?
Date: Wed, 20 May 2009 14:09:40 -0500
Message-ID: <7969D0E7-3BC0-46AC-A75B-1EEFA85DAE67@gmail.com>
References: <Pine.LNX.4.58.0905201806160.7805@gate.bb.dicp.net>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=NMdXOfmHzLCuiaGPeDEHst0dV8r53VbLHKC9506B6+U=;
        b=Y9pmEUjGGiKtfK6YhgfEr+F9L8yVLqjEmPe5a5RgTyQUUYyfn7YG7T+su9KfFM00UZ
         UFzVVkDSLcmtCa5Xhz9Sgg9VBWSKDdCsYHctDVU8b1LL/Ow5ftxxBd0U78eehlRKVVcY
         ZeItpylcysYPwHED8fRoYKuPdUf1TQ5DANpjw=
In-Reply-To: <Pine.LNX.4.58.0905201806160.7805-bvJ793YqIODNUDpmljszgg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>





On May 20, 2009, at 11:22 AM, Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>  
wrote:

>
> Dracut currently has a "--include a b" switch which does copy a/* into
> initrd/b/.
>
> Is there a real-world use case for this?
>
> Otherwise I'd like to recycle --include to accept a list of files  
> which
> are dracut-install()ed into the initrd image.
> This would allow simple one-shot inclusion of tools such as strace  
> without
> having to modify modules such as 95debug.
>
> If there's a real-world use case for the original --include  
> functionality,
> I'd have to come up with a differently named switch.
>

The test framework uses it to inject the files needed for the root  
filesystem.

> regards,
> andreas
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs"  
> in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
