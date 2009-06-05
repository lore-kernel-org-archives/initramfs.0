From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Don't use absolute path for ip, does not always work
Date: Fri, 5 Jun 2009 12:47:42 -0500
Message-ID: <F96FDD9C-4009-4E3E-AD7D-C8640ECF003C@gmail.com>
References: <4A292D53.9080603@bfh.ch> <20090605155900.GI5107@nostromo.devel.redhat.com> <3EFC8CBF-4F49-4713-9F04-D17977415107@gmail.com> <20090605172727.GB7539@nostromo.devel.redhat.com>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=MmpZ5GeruvsKfZd5JQIfIQOk1nJlK9E6zCHCEt6mV8U=;
        b=JKsg4WJWHh5xhnbxu379lcE1M1/uPcxOE0pkRMrZW0Qw7sHSkqLzheQ66akVyb56vW
         c0dV/5NCPXU+rpwfEboGxjOY8m7mqc4wRIkQ73F9GBlFGIXjMv/f3ycsK47kuc2/s4ee
         2QgRQJoF+pocLaV/5PNTLCtdd6EcMsFZuCovg=
In-Reply-To: <20090605172727.GB7539-Zdt1ptygihhQcNjhGXsBABcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Jun 5, 2009, at 12:27 PM, Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Victor Lowther (victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org) said:
>>> Why does it not always work, unless you're breaking your initramfs?
>>
>> What if your distro does not put ip in /sbin?
>
> I was under the impression that the generation already put it in
> a known place, in which case there's no reason to worry about it
> being elsewhere. I checked again, and that's not the case.

I should hope so, otherwise writing the install code to be as distro  
agnostic as feasible was all for naught. :)

>
> Bill
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
