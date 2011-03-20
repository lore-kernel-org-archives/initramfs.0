From: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dracut 008 luks key in external device - still broken
Date: Sun, 20 Mar 2011 08:57:11 +0300
Message-ID: <AANLkTimAf=rYGhqFEPwrFBJH6TkrinUw-gBE6aqh-Fou@mail.gmail.com>
References: <AANLkTi=w7BiyjDa2e5NJVr96q37kZPb2L=BxL1-He=PD@mail.gmail.com>
	<1300544966-sup-1505@ittemni>
	<AANLkTikifPgn4N1mF67o4Cm3TPBGDfS-TF7RgTXb7NfZ@mail.gmail.com>
	<1300577445-sup-6446@ittemni>
	<AANLkTinL5H7rdTeW=gRrtvpuToP368uQw=m5xNONbr26@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EeiKNbB+tIzTD4Mb8nBqTpo155BStIrFnO+W8Ymk6VU=;
        b=lJmahFuVa2vKdOYqJRk0Q7ejBezILGCsb9nafkSKGJu3ZxdBbsKdB4jPOLYeIT92nV
         Sg2aPFzB64m4MjIrwU/fS3Oz0EToDDTIv59lpUbj7r0ekTXQ5/z++aEf7Ik53EQgKLvQ
         X0vfLq/PTW34o/xEKsF/qH72VB8bxX+ZO28Wc=
In-Reply-To: <AANLkTinL5H7rdTeW=gRrtvpuToP368uQw=m5xNONbr26-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: jaivuk <jaivuk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?ISO-8859-2?Q?Amadeusz_=AFo=B3nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

2011/3/20 jaivuk <jaivuk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> 2011/3/20 Amadeusz =C5=BBo=C5=82nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>:
>> First of all I haven't taken into consideration fact, that one can w=
ant
>> to use dracut for mounting something more than root. That's why ther=
e's
>> only key or only password. But it probably would be possible to
>> optionally ask for password, too. I will have to think of cases with
>> multiple devices to be decrypted and improve the module.
>
> Anaconda by added swap as well, and other things can be added manuall=
y
> as a kernel parameter...
>
>> What happens? Doesn't decrypt anything? Or just one of devices?
> Apparently anything.
>
[...]
>> 4) dmesg
> http://pastebin.com/nA4qVFcZ
>

It shows that no additional device was seen by dracut. Have you
connected your USB key before booting?

[...]
> I added four more points:
> 6) To prove my key is OK, I tried below from dracut shell: (I'm sure
> key for other partitions is fine as well)
> #mkdir /mnt
> #mkdir /mnt/USB
> #mount /dev/sdc1 /mnt/USB
> (successful)
>
> #cryptsetup -d "/mnt/USB/mykey" luksOpen /dev/md1
> luks-6508ce25-91d1-469a-9423-7b10ef00754e
> (successful)
>
> #ls /dev/mapper
> control
> luks-6508ce25-91d1-469a-9423-7b10ef00754e
>

Could please paste dmesg *after* you have done it?
