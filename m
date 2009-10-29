From: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Subject: Re: [PATCH] dracut-gencmdline: use udevadm info to go from /dev/X
 to /sys/Y
Date: Thu, 29 Oct 2009 10:59:33 +0000
Message-ID: <4AE97595.6020704@tuffmail.co.uk>
References: <4AE9606C.1090008@tuffmail.co.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=1RVFYl6wOGAhTt8MAjUrB1YFN8SKSU8bBxJKXLV1Jkg=;
        b=sI7ecbzWggmxL9l6aE4jA8wA1E4dgolFIeI0OTmy+Ps3YZnN7QDbmLJ7+xutCM5dtK
         j2QZj5C/i5g9LQ6aMh/UWYGoJqmyzFkcvYxB9ZhGx31s3fgf1ZrPfE8RQa06lMtklThP
         j/0clNzKjoaNEX5t9Hv7cqbljx6eI3XgRRwbE=
In-Reply-To: <4AE9606C.1090008-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Alan Jenkins wrote:
> Avoid some manual spelunking in sysfs.  This makes for slightly shorter
> and simpler code.
>   

Argh, please ignore this patch.

> +    path=$(udevadm info --name "$1" --query=path 2>/dev/null

> -        dev=$(for x in /sys/block/* ; do find $x/ -name dev ; done | while read device ; do \
> -              echo "$majmin" | cmp -s $device && echo $device ; done)
> -        if [ -n "$dev" ]; then
> -            dev=${dev%%/dev}
> -            dev=${dev%%/}
> -            echo "$dev"
> -            return 0
> -        fi
>   

Device-mapper was still creating some of it's own device nodes as of
April this year.  So it's not safe to rely on udev knowing about
everything in /dev.
