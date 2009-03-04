From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] Steal rules we need from the latest udev package.
Date: Tue, 03 Mar 2009 18:56:54 -0600
Message-ID: <1236128214.6500.12.camel@sentry-no.fnordovax.org>
References: <d53985b1c536e2fb845e0e3c369edd06d5018011.1236124962.git.victor.lowther@gmail.com>
	 <462be3c3cfdf24ba51bc4d1a1f66cc30b8d29d82.1236124962.git.victor.lowther@gmail.com>
	 <82ecf08e0903031627p2af2ce66s8e777716eff2b823@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=tRpDb/82+YR1jZtGV3gyCdprlAO7cyo8ckpLQ2zK8zo=;
        b=AAXgzXANNDzBjkdCf5gyJFaI7Ug/53/LFpECdu2TVjYDEWY6t8lRRGVuZn91hzl6bC
         Vjleafy7whePH77hf1uAMbgwejwOBVvProvdi1Vrz2ceSOOotG1tVRRrT02u6z7T91sT
         Qzsh8ps4bkvVA50z4oWnQjFVOdcaLUHLE9bH0=
In-Reply-To: <82ecf08e0903031627p2af2ce66s8e777716eff2b823-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 2009-03-03 at 21:27 -0300, Thiago Galesi wrote:
> I'm not sure how udev works, but do we really need ALL the rules??
> Like v4l, printer, floppy!! etc

We probably don't, but I really do not want to get into the business of
maintaining our own dracut-specific set of rules.  These are stolen
directly from the udev git tree without any editing whatsoever.  The
goal would be to import the udev got tree as a submodule of the dracut
udev tree and copy them with cp every time dracut was rebuilt, but I am
too lazy to learn how to do that right now.

> If we're going to import rules and keep it built-in, I would take only
> the bare minimal

In terms of files, I think this is pretty close to it. I am happy to be
proven wrong, however. :)

In terms of lines, there is certainly some fat to be trimmed, but I
don't think we should be in the business of hand-crafting rules beyond
the minimum needed to support cryptoroot, lvm, and networking.

> Thiago Galesi
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
