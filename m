From: Anssi Hannula <anssi-4qZELD6Fgxhg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] load dracut.conf.d before dracut.conf
Date: Sun, 20 Feb 2011 19:29:49 +0200
Message-ID: <4D614F8D.10505@mandriva.org>
References: <201007140205.35944.maarten.vanraes@gmail.com> <4C46DCD0.3020608@redhat.com> <4D280724.8050405@mandriva.org> <4D5E46DC.4020303@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D5E46DC.4020303-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Maarten Vanraes <maarten.vanraes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 18.02.2011 12:15, Harald Hoyer wrote:
> Am 08.01.2011 07:41, schrieb Anssi Hannula:
>> The conffile patch causes dracut to load /etc/dracut.conf first and only
>> then /etc/dracut.conf.d, allowing the latter to override the former.
>>
>> IMO this is backwards. I thought distribution/package default stuff was
>> supposed to be put in /etc/dracut.conf.d/*.conf, and /etc/dracut.conf
>> was the place for the user to override them if they so wished.
>>
>> Is this not the case?
>>
>> If I've indeed misunderstood this, what is the recommended way for a
>> user to override distribution default settings?
>> Create a /etc/dracut.conf.d/zzz-last-user.conf?
>> Wouldn't that make /etc/dracut.conf superfluous? Or is that file indeed
>> intended for distribution defaults instead?
>>
>> Or is there some more important reason to have it this way?
>>
>> I've attached a patch which makes the behaviour sensible to me.
>>
>>
>> For background, the Mandriva package (again, wrongly IMO) currently uses
>> /etc/dracut.conf for distribution defaults and expects any user
>> configuration to be in /etc/dracut.conf.d/*.conf, and that was the
>> reason for the original patch submission; I'll change this behavior in
>> Mandriva (no one was against it on our ml in March) if the attached
>> patch gets OK'd.
>>
> 
> in Fedora, I put distro specific stuff in /etc/dracut.conf.d/01-dist.conf and I
> encourage people to put their config in e.g. /etc/dracut.conf.d/99-myconf.conf

What's the purpose of /etc/dracut.conf then?

If you don't think my previous patch was reasonable, I suggest removing
it completely :)

-- 
Anssi Hannula
