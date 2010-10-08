From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: dracut requires router
Date: Fri, 8 Oct 2010 16:17:19 +0200
Message-ID: <4CAF27EF.80301@bfh.ch>
References: <4CAEF060.8030701@draigBrady.com> <4CAF1D02.6060701@bfh.ch> <4CAF23BA.4010605@draigBrady.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CAF23BA.4010605-V8g9lnOeT5ydJdNcDFJN0w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 10/08/2010 03:59 PM, P=C3=A1draig Brady wrote:
> On 08/10/10 14:30, Seewer Philippe wrote:
>> On 10/08/2010 12:20 PM, P=C3=A1draig Brady wrote:
>>> My terminals just failed to boot because the router
>>> was (temporarily) unavailable. Seems this is on purpose?
>>>
>>> http://dracut.git.sourceforge.net/git/gitweb.cgi?p=3Ddracut/dracut;=
a=3Dcommit;h=3D98f25e96
>>>
>>>
>>> I don't know what the above is trying to do exactly.
>>
>> What this does ist simply try and give a possible router enough time=
 to
>> update its STP caches (See
>> http://en.wikipedia.org/wiki/Spanning_tree_protocol) so that subsequ=
ent
>> mount attempts don't fail because the router isn't ready.
>>
>> So yes, it is on purpose if the available IP information contains ro=
uters.
>>
>> I Hope this helps
>
> Thanks for the info, but.
> Is it right to do this synchronously with such a long timeout?
It has to be done synchronously, sorry. We have to be sure the router i=
s=20
there and ready if the rootserver is behind the router.

As for the timeout: STP can take between 30-60 seconds. (There's a=20
reason why there's newer protocols like RSTP etc).

> Is it right to die if we can't contact the router?
Usually yes. Either because the rootserver is behind the router or if=20
you supplied routing information it's safe to assume that later you wan=
t=20
it to work anyway.

But yes, usually. I would have preferred to somehow a subnet check on=20
the rootserver to decide what or if to check. But alas, not all netroot=
=20
variants know the ip of their rootserver at that point.

I'm always open for ideas on how to improve this.

Regards,
Philippe
