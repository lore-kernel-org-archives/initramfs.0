From: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Subject: Re: [PATCH 3/4] Steal rules we need from the latest udev package.
Date: Wed, 4 Mar 2009 11:12:14 +0100
Message-ID: <ac3eb2510903040212m5d68d812kbce03d831e8c3d12@mail.gmail.com>
References: <d53985b1c536e2fb845e0e3c369edd06d5018011.1236124962.git.victor.lowther@gmail.com>
	 <462be3c3cfdf24ba51bc4d1a1f66cc30b8d29d82.1236124962.git.victor.lowther@gmail.com>
	 <20090304002535.GB96609@redhat.com>
	 <1236129369.6500.18.camel@sentry-no.fnordovax.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1236129369.6500.18.camel-76q0VzFBGGr21HsLBtNmTckMGDeJXHgy@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Mar 4, 2009 at 02:16, Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=
 wrote:
> On Tue, 2009-03-03 at 19:25 -0500, Jeremy Katz wrote:
>> On Tuesday, March 03 2009, Victor Lowther said:
>> > This should arguably be done by importing the udev git repo as a s=
ubmodule,
>> > but I am too lazy to figure out how to do that right now.
>> >
>> > I suppose this could also be done by rewriting the 95udev-rules.sh=
 module
>> > for each distribution, but that is something best left to the dist=
ro
>> > maintainers once we acheive some sort of widespread adoption. =C2=A0=
Until then,
>> > stealing rules from upstream udev seems like the most portable sol=
ution.
>>
>> Stealing rules, though, means that they're almost certain to be out =
of
>> date as soon as they're present.

Exactly. And they will break horribly next month, when we e.g. switch
from vol_id to blkid.

> Yep. =C2=A0This is intended to be a quick and dirty hack for those of=
 us who
> prefer not to delve into the nuances of how each distro does things.

Don't do that. There is no need to know how "distros" work, you only
need to know about Debian. :)

> Out of date does not mean as much to the initramfs, IMAO -- as long a=
s
> we can find and mount root, it does not matter how out of date the ru=
les
> are.

Oh, no. That will never work. The main udev rules cannot be
disconnected from the udev daemon and the udev tools in /lib/udev/,
they are tight together and have strong dependencies in the shipped
tools and the tool calling options. That's why the tools are in an
"application private directory" and not in /sbin. You will end up with
several versions of the rules in the dracut repo, and need to select
them based on the installed udev version. The current default udev
rules will not even work correctly on the "ancient" udev package
Debian ships today.

>> The right fix here is for distros not
>> to go off and think that they know better than upstream on how to wr=
ite
>> udev rules.  But I'll let Kay chime in if he really wants to here ;-=
)

All other distros work together and ship a set of rules which is the
result of a merge of all the distro stuff. They all ship an identical
setup today. There is only one left, which thinks it can do better,
and I would not like to see broken workarounds for everybody in the
dracut repo. It should be a "Debian dracut module to work around their
weird idea of upstream", and not a "pain to maintain default" for all
other users. :)

> Mmmm... sweet scent of politics. =C2=A0I get the feeling that many ki=
lobytes
> have been spent flaming^Wdiscussing this topic.

Yeah, it seems hard for some kids to share their toys. :) But it's
pretty much over, there is not much to discuss anymore. We all ship
the same stuff, and share the same bugs. If you want "Debian" use
Ubuntu. It's part of the upstream development, ships recent versions
which other stuff can develop against, and can depend on. :)

Thanks,
Kay
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
