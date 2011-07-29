From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Q: How to add more modules when -H is specified?
Date: Fri, 29 Jul 2011 17:44:31 +0800
Message-ID: <CAM_iQpWGqM6S-S-oj+YfgF9uZGFdeqx--+Mn6Fjw+1wwpop3jA@mail.gmail.com>
References: <j0tsl5$2kj$2@dough.gmane.org>
	<4E327C58.1000406@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=6PWH6TVr4IFFLL/VjZMu9ZK169iudpgHN707pxpJao4=;
        b=sss4K7x+kLV/qzxbfHYuvyZ1qSwAb1q8EYO+WB0ysMEMLFvfgqRbx/zHyuWxVDtm3E
         4BUfQlDBVtoLnq3KiizpCoxAxroit2I0AubijvTVH8kKf/nDt48hgN1uyeDAjv6gqHux
         rrHX6LycrRLHGOqDmwpKeSknAy11+PQPv8/jU=
In-Reply-To: <4E327C58.1000406-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, Jul 29, 2011 at 5:24 PM, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote=
:
> On 29.07.2011 10:57, WANG Cong wrote:
>>
>> Hi, dracut people,
>>
>> I am not sure about the expected behaviour when I specify both
>> -H and --add foo (where module foo is not automatially added
>> by -H). It looks like with -H specified, --add foo will not
>> take any effect?
>>
>> At least `-H --add nfs` doesn't work if my rootfs is not nfs,
>> I see the following check in modules.d/95nfs/module-setup.sh,
>>
>> =C2=A0 =C2=A0 [ $hostonly ] && ! egrep -q '/ nfs[34 ]' /proc/mounts =
&& return 1
>>
>> So, is this expected? I mean as long as I specify -H, there is
>> no way to add more modules? Or just the nfs check code is wrong?
>
> Hmm, yes, currently all "add" modules also have the hostonly check.
> Sometimes you want that behaviour, sometimes not..
>
> We might want s.th. like "--force-add" for that use case.

This is exactly what comes into my mind. :-D

>
>>
>> Also, I am looking for a way to add all needed modules for
>> devices mounted in current system, as -H only adds modules
>> needed by rootfs.
>>
>> Thanks!
>>
>
> Not (yet) implemented. I accept patches :-)
>

How about add a new option, e.g. '--all-mounted'?
Anyway, I will try to make some patches.

Thanks!
