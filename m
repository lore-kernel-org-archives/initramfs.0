From: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Debian/Ubuntu patches
Date: Fri, 12 Nov 2010 21:54:59 +0100
Message-ID: <AANLkTimOpDrecgXudiY3Yy0GrA3CH1Cjn-LA9jYkRHYP@mail.gmail.com>
References: <AANLkTikEPsCQzMSJbhwuO95Br+7aYJPw9zbVRd4Y8vOC@mail.gmail.com>
	<4CD9102B.7030702@bfh.ch>
	<AANLkTi=EkL7ivKKj6ck3w6RuOOq++cGwtP_pX0HHhVWu@mail.gmail.com>
	<20101109125820.GO19612@vostochny.stro.at>
	<AANLkTimfYTDFkUgk3x0ry6Z1Q_COYyij5CKMs_50t9MK@mail.gmail.com>
	<AANLkTikGCZofdYvX78vw+Rj_XmKyY1FmVcp_NT=_B_fF@mail.gmail.com>
	<20101110195826.GA8486@vostochny.stro.at>
	<AANLkTi=MCfaK5K-ZV3gvrFCzezJdjAMf-WY_VgM64dHA@mail.gmail.com>
	<20101111203031.GB3336@stro.at>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cZmkRXnCW4ePGonqNWWOyXkJoKN1OpkID1aJ5ZJwQO4=;
        b=ci63qtLh0QUYEB5FzphQVCtm8699uwZVruSAQrcf5VpgSQ3Z9KphJ4oDz3+EtNRxCI
         7CBXjF447lfwtsCAwjFsgxQj9Df5PPSKGPAGc5D9cdLeIRhb7KDRtM4fgboAj7TRL+Av
         19vIPKEc9FbtwP2sVIT5UX0E1Dc2G2RIREu4E=
In-Reply-To: <20101111203031.GB3336-U9r9yeDMy7A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

2010/11/11 maximilian attems <max-U9r9yeDMy7A@public.gmane.org>:
> On Wed, 10 Nov 2010, Jon Ander Hernandez wrote:
>
>> 2010/11/10 maximilian attems <max-U9r9yeDMy7A@public.gmane.org>:
>>
>> > yes, but didn't understand your reply and short of time..
>> > this seems like a chicken and egg trouble, please rephrase more co=
herently.
>>
>> I'm sorry, I need to improve my English. :-)
>>
>> I meant that if we ship Dracut with the kernel postinst script
>> (/etc/kernel/postinst), then the next time a linux image is installe=
d,
>> that script will be fired and a Dracut based initramfs will be creat=
ed
>> for that new kernel.
>>
>> But when we install Dracut for the first time, there is not any Drac=
ut
>> based initramfs installed on the system, and Dracut package's postin=
st
>> calls actually only call "dracut-update-initramfs -u" which only
>> updates the initramfs images present in the system (in this case no
>> one). So after installing Dracut you won't get a Dracut based image
>> for the kernel you are using, which is not very consistent with the
>> behaviour of creating the initramfs for any new kernel installed
>> afterwards.
>
> no, no this wrong logic.
> first of all the linux image depends on the a linux initramfs creator
> tool and thus this is installed *before* linux-2.6.
>
>> I understand that is the linux kernel package's mission to call the
>> kernel postinst scripts under /etc/kernel/postinst, but... I think w=
e
>> should do something. Maybe make the current linux kernel package cal=
l
>> the /etc/kernel/postinst scripts, or maybe call
>> dracut-update-initramfs, which was what I was doing in my original
>> patch... =BFWhat could be the best solution?
>
> the proposed create seems really wrong, I would nack any postinst
> in debian or escalate as serious bug.
>
> if you want hostile takeover that is up to the local admin
> and only one command away
> update-intramfs-dracut -t -u -k all

Sorry, I didn't think it would be so problematic. I just wanted to
make it "just work" after being installed. After thinking about it, I
realize that I didn't think about a several scenarios such as in an
install using deboostrap.

Thanks a lot for your patience Maximilian,

Jon Ander
