From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [BUGFIX Patch] fix a wrong usage of vinfo in init.sh
Date: Tue, 29 May 2012 16:28:32 +0800
Message-ID: <CAM_iQpVxAXOF9wL+kza9o4HA3ZAzaFh98Onvu=78gTWh5whDQQ@mail.gmail.com>
References: <1338278814-8603-1-git-send-email-amwang@redhat.com>
	<4FC486B4.8090506@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ubajF7wZ6d5v37y8A8VUIJNXMqXSYT+eqpC2SEfANP0=;
        b=znzXL8a82LqJ+CJMo1mXjhLfyvdQiQukjvetIUHTg8mlI7eM5QugcVwMcGufJA6DcC
         H8KJlc0oapoTSG12nK7YdNAAvVzkgVeKjrvuQn1o9/fi7BvFvHM8tWeD4Mypx5cPzJyK
         82B0ES9xy3yiz5TNeYQ2zZYEFF4U5vkktrHxlTXgSCJwi76OqAmMhf2AeCM9RG5m+pfU
         P3tButdrtSXHVAV8Dhkdn066be1lcKq21NLyMAwaAtO+rzLK26nK4dOs5MrUtLzqJWY+
         yYVvHACj9yh8vrNBRA+YKfBcYDTb7FGT/wIq8IWDCdyh9NFwEl2fKFy1OEcfAMMMiZZq
         OsNw==
In-Reply-To: <4FC486B4.8090506-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, May 29, 2012 at 4:20 PM, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote=
:
> Am 29.05.2012 10:06, schrieb Cong Wang:
>> =C2=A0[ -f /etc/initrd-release ] && . /etc/initrd-release
>> -[ -n "$VERSION" ] && vinfo "dracut-$VERSION"
>> +[ -n "$VERSION" ] && echo "dracut-$VERSION" | vinfo
>>
>> =C2=A0source_conf /etc/conf.d
>>
>
> Thanks! even simpler:
>
> -[ -n "$VERSION" ] && vinfo "dracut-$VERSION"
> +[ -n "$VERSION" ] && info "dracut-$VERSION"

Yeah.. please go ahead to commit it. This blocks my testing.

Thanks!
