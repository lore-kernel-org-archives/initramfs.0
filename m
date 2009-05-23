From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4] Changed multiline conditional lists to if
 statements in dracut-functions
Date: Sat, 23 May 2009 07:33:59 -0500
Message-ID: <1243082039.29452.43.camel@sentry-no.us.dell.com>
References: <97274286f3d147cdb21897569d71a1cf5ff4eb07.1243045308.git.victor.lowther@gmail.com>
	 <c8c67f682505552375405328bfd7483283507798.1243045308.git.victor.lowther@gmail.com>
	 <1243046464.4217.1.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=kFQ7MceQmaJRjsPQdcWTscp8dlhUUheQMjswreCttuE=;
        b=TwYXQiggQqxobbf3qiuOPKPNU9D5YWYECUqHXGwwIsiccsc6UgryhllVUASD0Fljb5
         kI62DIQ0PMqhvWWsV3fsJxNM75qocEg6WjpqZM0sp9rpCPa8iR1nPfUsGRIbh/pC7IDe
         khnh8WSF0QG/m57Wu6hmuaoyM6mXoYSG8YN1o=
In-Reply-To: <1243046464.4217.1.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, 2009-05-22 at 22:41 -0400, David Dillow wrote:
> On Fri, 2009-05-22 at 19:24 -0700, Victor Lowther wrote:
> > It seems that some people object to multiline conditional lists.
> > Oh, well, no accounting for taste.
> 
> I didn't see the complaints... I prefer the conditional list construct,
> which I've used heavily in my nfsroot patches (cleaning them up as I
> type this).

It was part of a conversation on IRC (#dracut on freenode).

While I prefer conditional lists, I can read and understand the code
just as easily both ways.  

OTOH, if someone proposes using [ instead of [[ for conditionals where
we don't have to be POSIX, there will be a huge argument. :)

> Oh well, I'll post what I have in the current form, and we can talk
> about changing it going forward if needed.

Works for me.

-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
