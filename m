From: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] 90crypt: probe for keydev asynchronously; changed
 kernel arg
Date: Mon, 15 Nov 2010 19:50:50 +0300
Message-ID: <AANLkTin4CecwByk3-EkGQHOGNN3=jrnjwWrh4YzEzC9Q@mail.gmail.com>
References: <1289553710-7568-1-git-send-email-aidecoe@aidecoe.name>
	<1289553710-7568-2-git-send-email-aidecoe@aidecoe.name>
	<AANLkTimg81mVgKeJ93y_J52Kud_NaUSB6RLT3wFst7fN@mail.gmail.com>
	<1289838915-sup-9150@ittemni>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Zm6d61wmpMwIGs2GjU1Sf+c0IxzXxKsF+9KYpLLRUe8=;
        b=fDu/DH6vPur7LCwxaFHxPyf3aGGSVSDuFPxk2klouzznmm7kZBDREdPr1dNf1ID7+f
         LjNzYthUKcGrpfgXRELvKZApYNM+hoRuHWOlBmElu+M+nZOY7tPAVoqkL36HkfMb6b1+
         D2EjNxlqfsOfjtARR+h5XFze0NEGjEe1/azKA=
In-Reply-To: <1289838915-sup-9150@ittemni>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: =?ISO-8859-2?Q?Amadeusz_=AFo=B3nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

2010/11/15 Amadeusz =C5=BBo=C5=82nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>:
> Excerpts from Andrey Borzenkov's message of Sat Nov 13 09:50:54 +0100=
 2010:
>> 2010/11/12 Amadeusz =C5=BBo=C5=82nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>:
>> [...]
>> > diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90cryp=
t/cryptroot-ask.sh
>> [...]
>> > =C2=A0inst "$moddir"/cryptroot-ask.sh /sbin/cryptroot-ask
>>
>> As you are currently working on it, could you look into making
>> cryptroot coexist with plymouth? Currently they fight for
>> /sbin/cryptroot-ask; I thought about adding minimal plugin support
>> (i.e. something like /cryptroot-ask.d where modules can drop their
>> implementation; they will be tried is sequence until some succeeds).
>> Then /sbin/cryptroot-ask could be moved to base and be simple wrappe=
r
>> around this directory.
>>
>> Unfortunately I do not currently have ready-to-use infrastructure to
>> test this implementation.
>
> OK. =C2=A0Thanks for reporting that. =C2=A0Matt Smith has already mer=
ged
> cryptroot-ask from plymouth to crypt module and it worked well until
> that my new patch. =C2=A0I'll try to fix the problem.

Actually I missed this patch, sorry. I'm still not sure how it behaves
if plymouth binary is available but plymouthd itself is not active/not
showing splash.
