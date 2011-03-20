From: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dracut 008 luks key in external device - still broken
Date: Sun, 20 Mar 2011 09:23:05 +0300
Message-ID: <AANLkTi=JFPaoX6gmp2NZaU+P+qa7fLSUeBj-0Mv1+m-s@mail.gmail.com>
References: <AANLkTi=w7BiyjDa2e5NJVr96q37kZPb2L=BxL1-He=PD@mail.gmail.com>
	<1300544966-sup-1505@ittemni>
	<AANLkTikifPgn4N1mF67o4Cm3TPBGDfS-TF7RgTXb7NfZ@mail.gmail.com>
	<1300577445-sup-6446@ittemni>
	<AANLkTinL5H7rdTeW=gRrtvpuToP368uQw=m5xNONbr26@mail.gmail.com>
	<AANLkTimAf=rYGhqFEPwrFBJH6TkrinUw-gBE6aqh-Fou@mail.gmail.com>
	<AANLkTin9K2C2795xg=bjdPr66CUkBsONj7AFMULqBDcD@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=P5hrvTLpGkNpBkQ+DSPegX2GzRFWs3txlR/FbfljnBw=;
        b=xcNeIAGRZq0BMXD3NMrNAHazZ7LswJWxz0W7fAYxTyljnWwCkljDtAwCE5yV9oMIyw
         xKui9TAQpAJqkAg2ngPxPZuAGq9yL0YggB/LPVDmp3XFm4f9NDF8PnxURPTBosfM4Obo
         T6Kq/YjqyUud6Bw1knnWz2R6VVEJB7qQcn2m0=
In-Reply-To: <AANLkTin9K2C2795xg=bjdPr66CUkBsONj7AFMULqBDcD-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: jaivuk <jaivuk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?ISO-8859-2?Q?Amadeusz_=AFo=B3nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

2011/3/20 Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> 2011/3/20 Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>> 2011/3/20 jaivuk <jaivuk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>>> 2011/3/20 Amadeusz =AFo=B3nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>:
>>>> First of all I haven't taken into consideration fact, that one can=
 want
>>>> to use dracut for mounting something more than root. That's why th=
ere's
>>>> only key or only password. But it probably would be possible to
>>>> optionally ask for password, too. I will have to think of cases wi=
th
>>>> multiple devices to be decrypted and improve the module.
>>>
>>> Anaconda by added swap as well, and other things can be added manua=
lly
>>> as a kernel parameter...
>>>
>>>> What happens? Doesn't decrypt anything? Or just one of devices?
>>> Apparently anything.
>>>
>> [...]
>>>> 4) dmesg
>>> http://pastebin.com/nA4qVFcZ
>>>
>>
>> It shows that no additional device was seen by dracut. Have you
>> connected your USB key before booting?
>>
>
> Oops, sorry :(
>
> [ =A0 =A09.326667] dracut: Probing /dev/sdc1 for /mykey...
> [ =A0 13.161241] dracut: Found /mykey on /dev/sdc1
>

[    3.272805] dracut: dracut-008-7.fc15

Key file parsing was fixed in current master:

commit b20ff981c4b31d650ac0b2e5227f4d6f6eb459e2
Author: Amadeusz =AFo=B3nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Date:   Mon Mar 7 13:48:02 2011 +0100

    crypt-lib.sh: moved IFS=3D: from before 'read' to before 'while'

so you need updated modules.d/90crypt/crypt-lib.sh. May be you could
open a bug report in fedora to request update. I confirm that this bug
also happens with dash we have here.
