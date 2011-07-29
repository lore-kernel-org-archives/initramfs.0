From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: 'make rpm' fails
Date: Fri, 29 Jul 2011 17:12:13 +0800
Message-ID: <CAM_iQpWGdyKxbZtMaDmV8oPuxnqjfazYToV6zGPO7yak-8yFLw@mail.gmail.com>
References: <j0tqfa$2kj$1@dough.gmane.org>
	<4E327628.5040604@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MbAQB56NBDR+lBROB2hdGUc5eAjiX5KQJdNtH+6l8tM=;
        b=Fwz6iRdUcZaRVZtUrPJlt1xVK9OrKlIhlJowu2rXZCDnYbqnOkVkusAAqycrNqO04m
         bVe+c3mE08F7dTzlsqJTYJSbdpWfUBouqiSqi9R8Bb6eIrfFMQQHfGIyk8PuFRGqcQIt
         VFiVAOWE/oplvYx+pZpXDwvxBEV75hzDW5shU=
In-Reply-To: <4E327628.5040604-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, Jul 29, 2011 at 4:58 PM, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On 29.07.2011 10:19, WANG Cong wrote:
>> + /bin/cat /root/dracut/rpmbuild/0024-move-debian-to-debian.template-on-
>> request-of-debian-.patch
>> + /usr/bin/patch -s -p1 --fuzz=0
>> /usr/bin/patch: **** Only garbage was found in the patch input.
>> error: Bad exit status from /var/tmp/rpm-tmp.ERlVK0 (%prep)
>>
>
> yes.. patch does not understand git's format for file removals :-/
>

Might convert it to a normal patch? Where removal is diff against
/dev/null.

Thanks!
