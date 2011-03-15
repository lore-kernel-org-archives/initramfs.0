From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut 005 question
Date: Tue, 15 Mar 2011 12:24:45 +0100
Message-ID: <4D7F4C7D.1040205@redhat.com>
References: <AANLkTimG_vvX-qDQ7+hUA7LjrWBmJU6uA1OY0ZHMA+VG@mail.gmail.com> <AANLkTikhgLdM_x_UHgCDQYqD=ekVE2G+aY+YNyuwXD75@mail.gmail.com> <1300101485-sup-8139@ittemni> <AANLkTik9Q+ga+nvjawVOc4gYdHohwwEN7FYC02Kdmi4H@mail.gmail.com> <1300181816-sup-175@ittemni>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1300181816-sup-175@ittemni>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Am 15.03.2011 11:43, schrieb Amadeusz =C5=BBo=C5=82nowski:
> Excerpts from jaivuk's message of Tue Mar 15 10:25:06 +0100 2011:
>> Let me tell you what I want to achieve here - I have a host with
>> several luks partitions using the same key and I want them to be
>> unlocked by plugging USB stick with the key during the boot and not
>> typing the key via the keyboard at any stage.
>>
>> I managed to install F14 with dracut-006-6.fc14 and I configured
>> second key and I assumed it will work. But it didn't. To my surpsire=
 I
>> do not see rd_LUKS_KEYDEV_UUID anywhere in the 90crypt/* folder. I
>> searched whole modules.d and I did not find it either. So it looks t=
o
>> me this version of dracut actually dropped support of key on externa=
l
>> device entirely?
>=20
> I don't know how Fedora releases the packages, but support for keys o=
n
> external device *started* with 007 [0]. And with 008 [1] parameters
> names have changed. With 008 logic of probing devices for key has
> changed. You might want to try how it behaves for your case.
>=20
>=20
>> What I would like to do now is to install dracut 008 (or the latest
>> version) in my F14 and try my USB key with it. I checked dracut 006
>> has dependency on plymouth-scripts, can you please advise me if it i=
s
>> the same for dracut 008? Do I have to install latests plymouth-scrip=
ts
>> or is it optional?
>> And can you please give me any hint what is the best way of upgrade
>> from 006 to the latest one?
>=20
> You can try using source package from sf.net.
>=20
>=20
> [0]
> http://sourceforge.net/projects/dracut/files/dracut-007.tar.bz2/downl=
oad
>=20
> [1]
> http://sourceforge.net/projects/dracut/files/dracut-008.tar.bz2/downl=
oad

=46edora 15 has dracut-008 ... should work on older systems, too
