From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/5 branch usrmove v2] deal common part of etc passwd in 99base
Date: Thu, 29 Dec 2011 18:04:05 +0800
Message-ID: <CAM_iQpWPiYpLU0FEt-qm-vsfZdqGpbq-gGcJXisE22oCX-d-Aw@mail.gmail.com>
References: <20111226062910.GA3141@darkstar.nay.redhat.com>
	<jdcb3i$9bf$1@dough.gmane.org>
	<4EFBD882.2090707@redhat.com>
	<jdhbpl$s87$1@dough.gmane.org>
	<4EFC36CD.8040205@redhat.com>
	<CAM_iQpX6kWGPB_mGUWOaywQgxeWEC+Og6WjOZmknS+FPGuA0xQ@mail.gmail.com>
	<4EFC3A2E.6020606@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=E74u49/AMsY4lQvQCGijpFbif2h1YB4IWeuj8FEn91U=;
        b=rr5ujZKPCuec0FNkVDenjcH5M5EJ29EFIx2QpGdmTCxBVlJbvEADDFONtCd4jk+WzB
         Mvkr8T88OT74oIRfWlPOc4d/hD16OzCVIA5+jQ0BPw7+S4ylUCzs7cJUjRXeZ4vU1KHA
         na61mVzL8vPpmW2b6WDEo9sQHU55ZCcboyhfY=
In-Reply-To: <4EFC3A2E.6020606-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Dec 29, 2011 at 6:00 PM, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On 12/29/2011 05:48 PM, Cong Wang wrote:
>
>> On Thu, Dec 29, 2011 at 5:45 PM, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrot=
e:
>>> On 12/29/2011 05:27 PM, Cong Wang wrote:
>>>> The nfs module still uses "/" as home of root, while ssh module us=
es
>>>> "/root". With you patches, you changed to "/root" for both nfs and
>>>> ssh, which *maybe* a problem for nfs module since you didn't test =
it.
>>>
>>>
>>> I tested nfs boot as well, it works ok with $HOME=3D/root
>>
>> Ok, will change to "/root" too.
>>
>>>
>>> Also if you add both ssh-client and nfs, what's the result of /etc/=
passwd?
>>
>> If the line "root:" exists before,
>>
>> =C2=A0egrep -q '^root:' "$initdir/etc/passwd" 2>/dev/null || echo
>> 'root:x:0:0::/:/bin/sh' >> "$initdir/etc/passwd"
>>
>> egrep will succeed and echo will not be executed...
>
>
>
> Yes, but who knows which module will be added firstly, maybe there's
> other module do this in future.
>
> But if nfs also use /root as HOME it will be ok currently
>

Yeah, it is in git now.
