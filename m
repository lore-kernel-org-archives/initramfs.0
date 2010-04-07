From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: help about dracut
Date: Wed, 07 Apr 2010 11:59:06 +0200
Message-ID: <4BBC576A.2020104@redhat.com>
References: <p2t69b8237b1004060511w87a32eb3qc6f4c273bd6bb121@mail.gmail.com>	 <4BBC4D45.90801@redhat.com> <i2u69b8237b1004070252s1254e5e2l3d083b0671c70828@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <i2u69b8237b1004070252s1254e5e2l3d083b0671c70828-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
To: Tony Wan <visual2me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 07.04.2010 11:52, schrieb Tony Wan:
> Thank you very much. But I still have a question -- can I specify 2 o=
r
> more crypto_LUKS partitions after "rd_LUKS_UUID=3D"?

you can specify rd_LUKS_UUID several times

>
> On Wed, Apr 7, 2010 at 5:15 PM, Harald Hoyer<harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>  wrot=
e:
>> Am 06.04.2010 14:11, schrieb Tony Wan:
>>>
>>> Hi List,
>>>
>>> Sorry for interrupt. I'm totally a newbie for dracut and have no id=
ea
>>> how to make a customized initramfs with it on Fedora Core 12. I hav=
e a
>>> luks-crypted partition, but I don't want to mount it at boot time, =
so
>>> there's no need to ask for the password during the boot process. My
>>> question is how to disable dracut to auto-detect crypto_LUKS
>>> partitions and ask for the password during boot (or just for a
>>> specific partition with a UUID). Anyone can give me help, since it'=
s
>>> really difficult to find a tutorial for dracut on internet. Thanks =
in
>>> advance.
>>
>>
>> $ man dracut
>>
>> crypto LUKS
>>        rd_NO_LUKS
>>           disable crypto LUKS detection
>>
>>        rd_LUKS_UUID=3D<luks uuid>
>>           only activate the LUKS partitions with the given UUID Any
>>           "luks-" of the LUKS UUID is removed before comparing to
>>           <luks uuid>.  The comparisons also matches, if<luks uuid> =
 is
>>           only the beginning of the LUKS UUID, so you don=92t have t=
o
>>           specify the full UUID.
>>
>>
>
>
>
