From: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Subject: Re: [ANNOUNCE] dracut 034
Date: Mon, 28 Oct 2013 15:23:50 +0000
Message-ID: <l4lvht$4jh$1@ger.gmane.org>
References: <5253DD0C.7050506@redhat.com>	<l4dk8e$fv8$1@ger.gmane.org>	<526A7412.8030804@redhat.com> <20131028134216.049c6a01@work.puleglot>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131028134216.049c6a01-d/9N6kaejYfpx9ONITL1FA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

'Twas brillig, and Alexander Tsoy at 28/10/13 09:42 did gyre and gimble=
:
> =D0=92 Fri, 25 Oct 2013 15:37:22 +0200
> Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>=20
>> On 10/25/2013 01:22 PM, EatDirt wrote:
>>> On 08/10/13 12:23, Harald Hoyer wrote:
>>>> Here comes a new dracut version. Thanks to all who have contribute=
d to this
>>>> release.
>>>
>>> Hi guys,
>>> sorry if this is not the right place to post, but we have some prob=
lems with mga
>>> distributed dracut-034
>>>
>>> For users having two partitions / and /usr; specified in their /etc=
/fstab,
>>> without including systemd module, dracut does not automatically inc=
ludes the
>>> necessary usrmount module.
>>>
>>> Without usrmount, the initrd yields a kernel panics at boot time. I=
 naively
>>> though that dracut would automatically take care of the partitions =
specified in
>>> /etc/fstab and therefore "sees" that without systemd added, usrmoun=
t must be
>>> present.
>>>
>>> Do you think it is a dracut bug, or we should take care of this at =
the "distro"
>>> packaging level?
>>>
>>> Thanks for your help!
>>>
>>> cheers,
>>> chris.
>>>
>>>
>>> PS: the mga full bug report is there (check the last posts):
>>>
>>> https://bugs.mageia.org/show_bug.cgi?id=3D11292
>>>
>>
>> Hmmm, the usrmount module is automatically included, if /sbin/init i=
s on /usr.
>> If it is not on /usr, normally /sbin/init can mount /usr via fstab.
>>
>=20
> But this logic breaks systems with separate (not merged) /usr. Accord=
ing
> to [1], /usr should be always mounted inside initramfs. For example,
> openrc in Gentoo launches udev before mounting filesystems via fstab.

I think you're ultimately correct, but keep in mind that if you do have
a separate /usr with a non-merged system, you need to have udev and all
it's components in / anyway (i.e. /lib, /sbin etc) such that udev could
be started prior to mounting /usr. Of course when this happens you run
into a whole manner of knock on problems such as helper binaries from
udev rules not yet being available, missing firmware and similar - i.e.
a big pile of problems.

This was indeed one of the issues pointed out during the eudev talk at
=46OSDEM by the likes of Grek KH, Kay and co. There was some vague talk
about developing a mechanism to delay the actual handling of such rules
when /usr is not mounted but the resounding suggestion from the audienc=
e
was to "just let the initramfs handle /usr mounting!!"


So I think you're probably reading a bit too much into Harald's
statement above. In theory it's possible to have /sbin/init mount /usr =
-
but it's something I think everyone versed in the issues would highly
discourage!


That being the case, I would propose that the usrmount module be
automatically included when /usr is a mount point regardless of on whic=
h
partition init lives?

Col

--=20

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited http://www.tribalogic.net/
Open Source:
  Mageia Contributor http://www.mageia.org/
  PulseAudio Hacker http://www.pulseaudio.org/
  Trac Hacker http://trac.edgewall.org/
