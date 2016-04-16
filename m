From: "Alexander E. Patrakov" <patrakov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] dracut: add support for updating the CPU microcode
Date: Sat, 16 Apr 2016 20:20:10 +0500
Message-ID: <5712582A.2090502@gmail.com>
References: <1460762332.3054.2.camel@trentalancia.net>
 <5711D522.3090907@gmail.com> <1460814862.4296.4.camel@trentalancia.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=y1e+Wjj5QtRQjKAV0b+lxuKQolGKtx8oCgkH0Xu/Bn0=;
        b=V01JMQZHTatYq09iOUrTg+otqj/zK6PZM/NfXMW0QT4+8n0szweZ9JIwc04RIw8a6R
         9yoZNObIT0Gh+XMLFpIfvl9mHFXPeTUQNBVPQfczJywvhb/0n2EjkYGsk1GI8ZsaQNQ7
         SeQGr7789n2Kw4PE622j83KOS1Dy92xcusfFrJ6KZrxf5Sw8DRvLhyLtIP0Cu+7UPUEh
         rdDOe0CLvFtj6/A+3fkXhvvvsI6x4ku+c9bzE0c6nWrknkbou2FtiYUtWRYogY4PH8WR
         JNdj9/OreCK3wmPywCwMEb+LK8hVhixThI9afeVUGH/lxnbtBfPpwNXhyAEBTUyLHYmh
         tjCg==
In-Reply-To: <1460814862.4296.4.camel-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>, Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

16.04.2016 18:54, Guido Trentalancia =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Hello Andrei,
>
> thanks for getting back on this...
>
> On Sat, 16/04/2016 at 09.01 +0300, Andrei Borzenkov wrote:
>> 16.04.2016 02:18, Guido Trentalancia =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> This is the initial version of a new "microcode" dracut module
>>> that can be used to update the microcode on Intel(R) CPUs.
>>>
>>
>> ??? dracut already supports early microcode loading, why it is not
>> enough and what problem this patch solves?
>
> To be honest, I didn't notice it. I was expecting such support, if
> available, to be a module and I couldn't find it, so I wrote it.
>
> However, I have noticed it is much simpler than the actual
> implementation. It doesn't differentiate between Intel and AMD (why i=
t
> should ?), it just loads the microcode in the standard location as
> defined by the microcode update utility.

The microcode update utility stopped working when a Haswell microcode=20
update got released that makes some CPU instructions illegal (because=20
they didn't work properly in the first place). Please see=20
http://bugs.debian.org/762195

Sure, glibc no longer uses these instructions, but now (exactly to avoi=
d=20
repetition of this bug) the only supported way to update the microcode=20
is to place it in the initcpio so that "early microcode update" in the=20
kernel loader notices it.

--=20
Alexander E. Patrakov
