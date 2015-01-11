From: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [systemd-devel] Second (erroneous) check of rootfs?
Date: Sun, 11 Jan 2015 14:57:58 +0300
Message-ID: <20150111145758.243f1be5@opensuse.site>
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
	<CAJCQCtS1tGwp4iELnNp8R3gHY=uS+HFnk_J7k_CUxNX3Ga6upQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mwgEcDWz2lb0XGCAq5ZLMdSJtsxxfrnzf7ILD+QEPwM=;
        b=0iT+xsxC2qRmoragVPvLe1vZYMEPOWKmiswHFtPApvAYbKiDyiDggpRhfKQQNkjSzT
         FfaWTp9B5dQTd0TArOBsDewdN1Dain4eq3AGVJrTHx8cEDDT5H4AvsJPmObocoSzddt5
         jT0lDy7NFO9vEkpXX1AiEonOOPQLFZ3bKVNBr+pzdKIR5atX0XghKldoE/NnCjsDLhqb
         2CU6oVvzvhd23w7QcmHvZNBc1NVbO8Tl3pYo39SlxqoU3seBrEoviJxhfZdxLVjhIftN
         fzh2NquqgCvPFAqJLYKuzuQd8WPrXKiToQGIIY2n/uE3JnsYQFw39A0S5dNKVrLvsf2T
         Wpig==
In-Reply-To: <CAJCQCtS1tGwp4iELnNp8R3gHY=uS+HFnk_J7k_CUxNX3Ga6upQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Chris Murphy <lists-zXQU9YWDTqjmlV4oE/1sFAC/G2K4zDHf@public.gmane.org>
Cc: Nikolai Zhubr <n-a-zhubr-o+MxOtu4lMCHXe+LvDLADg@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

=D0=92 Sun, 11 Jan 2015 04:15:41 -0700
Chris Murphy <lists-zXQU9YWDTqjmlV4oE/1sFAC/G2K4zDHf@public.gmane.org> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> On Sun, Jan 11, 2015 at 4:11 AM, Andrei Borzenkov <arvidjaar-Re5JQEeQqe8@public.gmane.org=
m> wrote:
> > =D0=92 Sun, 11 Jan 2015 13:43:34 +0300
> > Nikolai Zhubr <n-a-zhubr-o+MxOtu4lMCHXe+LvDLADg@public.gmane.org> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >
> >> >
> >> > Uh. Why not simply mount rootfs rw in initrd then?
> >>
> >> I'm not against generally. But it'd mean that this first mount is
> >> actually a real mount, the fs will start up in full. Then I'd supp=
ose it
> >> is definitely a must to supply all necessary mount options (from f=
stab)
> >> at this stage already. I don't easily see how to do this currently=
, at
> >> least on my opensuse system.
> >>
> >
> > By adding all needed options to rootflags=3D"..." (modify
> > GRUB_CMDLINE_LINUX_DEFAULT and possibly GRUB_CMDLINE_LINUX_RECOVERY
> > in /etc/default/grub; you can use yast for it).
> >
> > Otherwise it is functional gap between non-systemd and systemd
> > enabled dracut. Without systemd dracut will actually mount root
> > read-only, then fetch mount options from real root /etc/fstab and t=
hen
> > remount real root read-write using correct options. This all got lo=
st
> > when converting to systemd.
>=20
>=20
> Not true on Fedora even still with 21. The kernel parameter ro is
> present, so dracut mounts root read-only, then reads fstab, then does
> a remount. Fedora is a systemd OS of course.
>=20
>=20

Does it using systemd *inside* of initrd? From upstream dracut:

    if ! dracut_module_included "systemd"; then
        inst_hook cmdline 95 "$moddir/parse-block.sh"
        inst_hook pre-udev 30 "$moddir/block-genrules.sh"
        inst_hook mount 99 "$moddir/mount-root.sh"
                                    ^^^^^^^^^^^^^ here it does it
    fi

Do you have Fedora specific patches to do it differently?
