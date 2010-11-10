From: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Live module for root=nfs using Aufs
Date: Wed, 10 Nov 2010 16:40:34 +0100
Message-ID: <AANLkTimLmuCG9S0hAowK3Qo7j_-dNZJzJxuBXXbEQF8N@mail.gmail.com>
References: <AANLkTi=7coxwNNu22um=qO7Tz18QZj_N7h3=G5ABnjqV@mail.gmail.com>
	<4CD7B293.8050809@bfh.ch>
	<AANLkTinNFeT8kuoe5FRJig=un76kE6bLoU4BzJKxp4OY@mail.gmail.com>
	<4CDAAC1F.6060308@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=EtYhHk+lO2SNb6o5BKDhPtwP1ZrXCyTv6ITfp3Q1xY0=;
        b=nsdMzGhkPK3+hPsSy5YYvQJk3Pcostp7f244z7Zi5DbHpyaSk3BIoZUeth6ofuYh3J
         3t5UC60ogduAW55QysclxX73GI0YccwKHDMTLcm11DV6XgbVw328dTKdGRtAq5SyF0uZ
         wW0+KP7ey6MUmcEp7HzLUwUyem3t0fDiiEVkU=
In-Reply-To: <4CDAAC1F.6060308-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

2010/11/10 Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
> On 11/08/2010 08:03 PM, Jon Ander Hernandez wrote:
>>
>> 2010/11/8 Seewer Philippe<philippe.seewer-omB+W0Dpw2o@public.gmane.org>:
>>
>>> I just had a quick look over the patch and in itself it looks ok.
>>> Although
>>> I'm not sure if having the aufs at this stage is necessary. What if you
>>> just
>>> mount it later inside the rootfs? (Background: I'm using aufs overlays
>>> for
>>> our read only nfs-roots, and I just put the necessary aufs mounts inside
>>> fstab)
>>
>> I have to say that I haven't thought about it before.... It is really
>> a good idea, and is probably better than have a specific module. :-)
>>
>> But something that worries me, is if the init process will cause
>> problems, since we will be mounting a new root over the old one once
>> we have processes which have previously opened files on the old /.
>>
>> Regards,
>>
>> Jon Ander.
>
> So, do you still need this dracut module? Or is it good enough, to do this
> in the real root?

The short answer is I still require something which makes the union
mount very early.
The long answer is I don't know if it is feasible to do the union
mount on the fstab or if the initramfs is the only option. The idea
doesn't seem to be so bad, but I find terrible dificul to debug the
result when in that ecuation you have nfs4 and upstart. So I don't
exactly know what is going on before my nodes get freezed...

I'll need to make more tests, and debug a little more.
