From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Which dracut repo?
Date: Wed, 4 Mar 2009 09:43:01 -0600
Message-ID: <FCD3E723-E711-4D1C-81B0-7C64FBAACD49@gmail.com>
References: <49AE9AE4.8040702@bfh.ch>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=2t0pKc+dyay3EqKtbPwEPqf97PWb+IAykc0Z6U45B04=;
        b=uqfVNHQ8V/h9ZApEDqQ2i49r/VonN+lLC6gYReyglpP0AagwzyMuKgd2ZAlBTLdK+h
         BXJ323eXOygudrVjxqXTGFMtKrRmmwd/ouerapT4mu1pTX8hcfFHKuCiN+EQPclkhWBj
         02CNYJio5bS1JzW2RCjNSxlf9R8UgoN9QsKlE=
In-Reply-To: <49AE9AE4.8040702-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mar 4, 2009, at 9:14 AM, Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>  
wrote:

> Another thing that comes to mind: There's really a lot of Dracut  
> patches floating around at the moment. What repo do I base new stuff  
> on? I'd really like to start testing Dracut for nfsroot come Friday  
> and I'd rather not base my stuff on the wrong set of patches or repo.

Well, my dracut stuff is at http://git.fnordovax.org/dracut/. I rebase  
the branches on it to track upstream, so if you want to test or build  
on my patches the easiest way is to clone whatever branch those  
patches are a part of.

>
> Thanks for the help,
> Philippe
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs"  
> in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
