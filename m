From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Live module for root=nfs using Aufs
Date: Wed, 10 Nov 2010 15:28:47 +0100
Message-ID: <4CDAAC1F.6060308@redhat.com>
References: <AANLkTi=7coxwNNu22um=qO7Tz18QZj_N7h3=G5ABnjqV@mail.gmail.com>	<4CD7B293.8050809@bfh.ch> <AANLkTinNFeT8kuoe5FRJig=un76kE6bLoU4BzJKxp4OY@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTinNFeT8kuoe5FRJig=un76kE6bLoU4BzJKxp4OY-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>

On 11/08/2010 08:03 PM, Jon Ander Hernandez wrote:
> 2010/11/8 Seewer Philippe<philippe.seewer-omB+W0Dpw2o@public.gmane.org>:
>
>> I just had a quick look over the patch and in itself it looks ok. Although
>> I'm not sure if having the aufs at this stage is necessary. What if you just
>> mount it later inside the rootfs? (Background: I'm using aufs overlays for
>> our read only nfs-roots, and I just put the necessary aufs mounts inside
>> fstab)
>
> I have to say that I haven't thought about it before.... It is really
> a good idea, and is probably better than have a specific module. :-)
>
> But something that worries me, is if the init process will cause
> problems, since we will be mounting a new root over the old one once
> we have processes which have previously opened files on the old /.
>
> Regards,
>
> Jon Ander.

So, do you still need this dracut module? Or is it good enough, to do this in 
the real root?
