From: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dracut 008 luks key in external device - still broken
Date: Sun, 20 Mar 2011 09:29:57 +0300
Message-ID: <AANLkTi=WLnW3u40asnRLeNpyW4yA1nSCGff+4juvp6+D@mail.gmail.com>
References: <AANLkTi=w7BiyjDa2e5NJVr96q37kZPb2L=BxL1-He=PD@mail.gmail.com>
	<1300544966-sup-1505@ittemni>
	<AANLkTikifPgn4N1mF67o4Cm3TPBGDfS-TF7RgTXb7NfZ@mail.gmail.com>
	<1300577445-sup-6446@ittemni>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/1vZyQekWqVh727j3yiHIN/O3aS7wgXtvoKM8unYSC0=;
        b=uRRFSv0DKNKGoZYOk87aDkN9HUL2oSmcj8LVjINKDo88h7lXsTZR221b5PiUl7Ld21
         xGBhxYtjCDrkp0i4PlAGzoOZ/By6gKOIZwznv16ie1ePGyKyRLm2nzORagYDqjzvPGKu
         eOSDlfC0D4ncK2IUkpF6cjHgcBLlMoonxT/ko=
In-Reply-To: <1300577445-sup-6446@ittemni>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: =?ISO-8859-2?Q?Amadeusz_=AFo=B3nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, jaivuk <jaivuk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

2011/3/20 Amadeusz =C5=BBo=C5=82nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>:
> Excerpts from jaivuk's message of Sun Mar 20 00:14:56 +0100 2011:
>> > It re queues cryptroot-ask for after udev queue is settled if key =
is
>> > not available initially. If device is still not available at this
>> > point, I am not sure what can be done sensibly.
>>
>> I think it should ask for password. And if it does so it would be go=
od
>> if I could still connect the key during the password prompt as I
>> explained...
>
> First of all I haven't taken into consideration fact, that one can wa=
nt
> to use dracut for mounting something more than root.

Remembering recent discussion about separate /usr, it seems quite possi=
ble :)

> That's why there's
> only key or only password. But it probably would be possible to
> optionally ask for password, too. I will have to think of cases with
> multiple devices to be decrypted and improve the module.
>

 I think this can be combined with below. If keydev was not found
after udevsettle, fall through to password request, combined with
request to insert key if respective kernel option was present.

>> So in case an attempt to open another luks partition failes, then ye=
s
>> in my view it would be best if user can either enter key manually or
>> insert the USB stick with the key (in case rd.luks.key was specified=
).
>
> Hm, might be good idea.

Yep. Currently if user forgot to plug in stick before booting it is
"Oops, I forgot to attach my key" and reboot. Stop there (after udev
settle) and give user chance to still plug in device,
