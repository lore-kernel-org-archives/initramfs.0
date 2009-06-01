From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 4/9] cmdline: cleanup handling and block: handler
Date: Mon, 01 Jun 2009 04:26:31 -0500
Message-ID: <1243848391.647.13.camel@sentry-no.fnordovax.org>
References: <cover.1243833882.git.dave@thedillows.org>
	 <d15c7a1ab71af9ab4fccd51fa02915e949f39c86.1243833882.git.dave@thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=ueT90GkCJwS3EPrNcpsqt31cAAb/ycQO1qNk+qiSOZo=;
        b=fIU3LEmDm0lrn7OM0IU6EVL5TriJpB9Xtb6oiLKphxLjn3kzPEll3ithTgIZKC22kP
         vlp4ytDh1elG5n6yEz2p9UNs+O9dE3lL6AUNIAs9GtkIU0aXNuyFaQK2sFd5jgMSZLhD
         9P8MnS4hiAQoECY/rqEek3RTJ35GCJ8qPQYkw=
In-Reply-To: <d15c7a1ab71af9ab4fccd51fa02915e949f39c86.1243833882.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, 2009-06-01 at 00:21 -0400, David Dillow wrote:
> Now init checks that we understood the root= option, and can
> act upon it, presenting and error if not. Also, clean up the
> generation of udev rules such that we don't require /bin/echo.
> diff --git a/modules.d/95rootfs-block/block-genrules.sh b/modules.d/95rootfs-block/block-genrules.sh
> index 47083df..5c3f957 100755
> --- a/modules.d/95rootfs-block/block-genrules.sh
> +++ b/modules.d/95rootfs-block/block-genrules.sh
> @@ -1,6 +1,10 @@
> -if [ "${root#/dev/}" != "$root" ]; then
> +#!/bin/bash # for highlighting

Please don't do this.  

> +++ b/modules.d/95rootfs-block/parse-block.sh
> @@ -0,0 +1,16 @@
> +#!/bin/bash # for highlighting

Or this

> diff --git a/modules.d/95rootfs-block/parse-root-opts.sh b/modules.d/95rootfs-block/parse-root-opts.sh
> index 3a8b1a6..dc0ae6d 100755
> --- a/modules.d/95rootfs-block/parse-root-opts.sh
> +++ b/modules.d/95rootfs-block/parse-root-opts.sh
> @@ -1,14 +1,6 @@
> -#!/bin/sh
> +#!/bin/bash # for highlighting

And so on...

Which editor are you using that highlights bash but not sh correctly?

-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
