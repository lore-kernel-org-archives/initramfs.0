From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] added extention to module files
Date: Wed, 18 Feb 2009 10:17:02 -0600
Message-ID: <D603FAB0-F524-4D18-95E3-B745193BC86C@gmail.com>
References: <1234960574-32612-1-git-send-email-ro@duskblue.org> <9594AD60-9303-4345-8FC6-B59FAA2C60EE@gmail.com> <82ecf08e0902180756u2e007426vdd7116c03e72925e@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=LPqh3oaIBytQk0uHUpa12CTVGH+NiB/5z01120lS7gU=;
        b=hoIPYYVlPYtcu/UIMzh52EM6byzyE84Z5/2jZv/gLa65ySx37ReETu98i2WYX/Uav1
         naYh4aQGlvI+B/eGTXVZwWEUMm2d4NJ3+0/VHiP7yGcTEJqYRTSdmIcAK9lWZKfINh+f
         gpaaJ7Y8l24bWSf3soP450ZaaqIr6Qz8U/FFU=
In-Reply-To: <82ecf08e0902180756u2e007426vdd7116c03e72925e-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>





On Feb 18, 2009, at 9:56 AM, Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>  
wrote:

>>
>> You will also need to modify the dracut script to only source  
>> modules with
>> the .sh extension, and make sure the $dracutmodules functionality  
>> still
>> works as expected.
>
> Well, the current match:
>
> # source all our modules
> for f in "$dsrc/modules"/*[^~]; do
>
> Worked for reading the .sh files (but not only the .sh files, of  
> course)
>
> However, I'm not that familiar enough to bash to adapt this match to
> only .sh files (I tried a couple of things)
>

*.sh should do the trick.

> -- 
> -
> Thiago Galesi
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
