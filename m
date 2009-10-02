From: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Subject: Re: handling mdmon in the initramfs
Date: Fri, 2 Oct 2009 07:29:30 +0200
Message-ID: <ac3eb2510910012229q592f95a4l19d5c1172779042e@mail.gmail.com>
References: <4AC53A0D.6060806@intel.com> <19141.24565.657477.284252@notabene.brown> 
	<4AC56AF1.5030801@intel.com> <19141.29719.815785.550499@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19141.29719.815785.550499-wvvUuzkyo1EYVZTmpyfIwg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Neil Brown <neilb-l3A5Bk7waGM@public.gmane.org>
Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Ciechanowski, Ed" <ed.ciechanowski-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Labun, Marcin" <Marcin.Labun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Danecki, Jacek" <jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Patelczyk, Maciej" <maciej.patelczyk-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

On Fri, Oct 2, 2009 at 05:31, Neil Brown <neilb-l3A5Bk7waGM@public.gmane.org> wrote:
> On Thursday October 1, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org wrote:
>> Neil Brown wrote:
>> >> Two strategies for this situation are to stop mdmon after mountin=
g the
>> >> rootfs, or just let it be terminated as a result of starting a ne=
w
>> >> instance from the final rootfs. =C2=A0The latter approach brings =
up the
>> >> question of how to communicate with the initramfs-mdmon-instance =
to make
>> >> sure we do not end up with two mdmon instances servicing the same
>> >> container. =C2=A0The proposed solution here is to switch to
>> >> abstract-namespace-sockets removing the need to drop a socket fil=
e.
>> >
>> > What exactly do you mean by "abstract-namespace-sockets"??
>>
>> Harald pointed me to this. =C2=A0It's the hack that udev uses for it=
s control
>> socket [1]. =C2=A0You create a unix domain socket as usual but make =
the first
>> character of the file name a NULL byte.
>
> ooohhhh..... that is soooo ugly!
> And given that anyone can bind to any 'abstract' name, there is room
> for a local denial-of-service attack there too.
>
> I guess we could use it if we really had to, but I'd rather avoid it
> if possible.

Right, you can only do that, if you are 100% sure, that the service
always runs and binds the socket before any other user can log in,
like udev does.

Kay
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
