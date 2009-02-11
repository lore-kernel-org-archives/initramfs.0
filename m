From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/9] Dracut cleanups, part 2
Date: Wed, 11 Feb 2009 16:35:00 -0600
Message-ID: <921e043f0902111435v54ee1bc1yb44ce3f745459f10@mail.gmail.com>
References: <215b373ce2de8b9c47c7f3bd3550c7fc96a49614.1234351770.git.victor.lowther@gmail.com>
	 <20090211220712.GC21052@nb.net.home>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9tWzz31Md6JixAO4sytwFYApkHB1QDaCPpE0TFiHClE=;
        b=YJLOit5z/aizUAFDg/w/10ELXIlvyL3kqjo6EoD1ukBP4rLd/IRLlWZbjGoN7zKtap
         xnPlPrqGg0T/ZrDVUPy8Xhe9wQ3jol5tqpxbNwIx2pznjbsy2CgJM9ynsTBZj43lYmgC
         qM6KtMCdzSXkKPFWeqgSabVzk9sdVXNXiHYok=
In-Reply-To: <20090211220712.GC21052-sHeGUpI7y9L/9pzu0YdTqQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Feb 11, 2009 at 4:07 PM, Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On Wed, Feb 11, 2009 at 03:46:38AM -0800, Victor Lowther wrote:
>> +# parsing the output of ls is Bad, but until there is a better way...
>> +read x x x x maj min x < <(ls -lH "$resume")
>
>  read maj min < <(stat --format="%t %T" "$resume")

Indeed, but that adds yet another executable to the initrd.

>> +echo "${maj/,/}:$min"> /sys/power/resume
>
>    Karel
>
> --
>  Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
