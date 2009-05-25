From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/5] We create our test image with root as an LVM
 menber.
Date: Mon, 25 May 2009 06:37:22 -0500
Message-ID: <1243251442.4005.0.camel@sentry-no.us.dell.com>
References: <6c901543151c5a664724b70dda6648e239567377.1242874219.git.victor.lowther@gmail.com>
	 <21e5b98500a58b6aa6c9bf290870993c18ed87cc.1242874219.git.victor.lowther@gmail.com>
	 <4A1A5ECE.9000701@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=05WVfqhdibMKZiDwf8JeOMpFEo7WaIhNjTXqbUc37lQ=;
        b=ZUC/j/ARcXh44wbc9Vp25IuhG6qz4+F8FTHRhCNGyDtPEhNsNNk9eIpMtmYXH6bH2E
         nMql8/kSC/6wGLglKO89lrblA7wkJQ6ueolCICbmzhsHlUt/PCJWBPDGf6yWg6XZeFUV
         Qi9GpMBoetygwY+m0D7scXwwN52knU/Mixc0Y=
In-Reply-To: <4A1A5ECE.9000701-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 2009-05-25 at 11:03 +0200, Harald Hoyer wrote:
> On 05/21/2009 04:55 AM, Victor Lowther wrote:
> > -    -append "root=/dev/dracut/root rw rootfstype=ext2 quiet console=ttyS0,115200n81" \
> > +    -append "root=/dev/dracut/root rw rootfstype=ext2 quiet console=ttyS0,115200n81i" \
> 
> typo??

oops, yes.
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
