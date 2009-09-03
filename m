From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ls to stat patch
Date: Thu, 3 Sep 2009 10:14:20 -0500
Message-ID: <2C8691D2-389B-4F15-A406-AD4D51B9D0D4@gmail.com>
References: <4A9F6345.4050003@gmail.com>
Mime-Version: 1.0 (iPhone Mail 7A341)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=d80f3vpopnO//osmT2bIDeumWwg7dP97G7W5vd5PPEk=;
        b=jvDKRMXCtm+NjujRmvdZEAULny2cONs76kydwBcGlLzmKi/V/xWeVGkcbpfT/gm1hm
         jwcHvGE6HBCPKkQXVXb20OwVB82QBYHME3XAJXHyy3EvZr6Fzp5Gt4+LUbIrzw3vRyY6
         KhKiCbT7NsR4Xkkb+VTGx8GMLavJcjbhAmn6k=
In-Reply-To: <4A9F6345.4050003-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Joe Pelkey <pelkeyj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Sep 3, 2009, at 1:33 AM, Joe Pelkey <pelkeyj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Hi,
> I was randomly looking through the git repository and came across
> modules.d/95resume/resume.sh and its comment about not liking the  
> use of
> ls.  I modified it to use stat instead, and since stat has been in
> coreutils since at least late 2005, I assume it's safe to use.

<snip patch>

We had a patch that did that initally, but dropped it because it adds  
another binary to the initramfs.

> Thanks
>
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
