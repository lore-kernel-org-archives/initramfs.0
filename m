From: Chris Murphy <lists-zXQU9YWDTqjmlV4oE/1sFAC/G2K4zDHf@public.gmane.org>
Subject: Re: [systemd-devel] Second (erroneous) check of rootfs?
Date: Sun, 11 Jan 2015 04:15:41 -0700
Message-ID: <CAJCQCtS1tGwp4iELnNp8R3gHY=uS+HFnk_J7k_CUxNX3Ga6upQ@mail.gmail.com>
References: <54ADD119.2050906@yandex.ru>
	<20150108004352.GA22800@gardel-login>
	<54ADD98D.9080608@opensuse.org>
	<54ADE3A1.6060107@yandex.ru>
	<54ADEA1F.3080908@opensuse.org>
	<20150108091810.500d510f@opensuse.site>
	<54AEA37D.8040008@gmail.com>
	<20150108155548.GA23263@gardel-login>
	<54AEAC69.9050801@gmail.com>
	<20150108203046.6cb52b01@opensuse.site>
	<54AEE948.4060308@gmail.com>
	<54AFA59C.2040301@yandex.ru>
	<CAPWNY8X2X=V2u46fLgvARDbiFws9VkgJVevpFs54FdnsgGcNVg@mail.gmail.com>
	<CAJCQCtTpHAozdGuNXP2bSfB=+ooVLPHa0Bd0BjqU6J7eT2Wn1A@mail.gmail.com>
	<54B12E5C.2060408@yandex.ru>
	<20150111100908.75945b61@opensuse.site>
	<54B253D6.9040306@yandex.ru>
	<20150111141125.2d2c1f38@opensuse.site>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150111141125.2d2c1f38-stAJ6ESoqRzYCGPCin2YbQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Nikolai Zhubr <n-a-zhubr-o+MxOtu4lMCHXe+LvDLADg@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

On Sun, Jan 11, 2015 at 4:11 AM, Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=
 wrote:
> =D0=92 Sun, 11 Jan 2015 13:43:34 +0300
> Nikolai Zhubr <n-a-zhubr-o+MxOtu4lMCHXe+LvDLADg@public.gmane.org> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>
>> >
>> > Uh. Why not simply mount rootfs rw in initrd then?
>>
>> I'm not against generally. But it'd mean that this first mount is
>> actually a real mount, the fs will start up in full. Then I'd suppos=
e it
>> is definitely a must to supply all necessary mount options (from fst=
ab)
>> at this stage already. I don't easily see how to do this currently, =
at
>> least on my opensuse system.
>>
>
> By adding all needed options to rootflags=3D"..." (modify
> GRUB_CMDLINE_LINUX_DEFAULT and possibly GRUB_CMDLINE_LINUX_RECOVERY
> in /etc/default/grub; you can use yast for it).
>
> Otherwise it is functional gap between non-systemd and systemd
> enabled dracut. Without systemd dracut will actually mount root
> read-only, then fetch mount options from real root /etc/fstab and the=
n
> remount real root read-write using correct options. This all got lost
> when converting to systemd.


Not true on Fedora even still with 21. The kernel parameter ro is
present, so dracut mounts root read-only, then reads fstab, then does
a remount. Fedora is a systemd OS of course.


--=20
Chris Murphy
