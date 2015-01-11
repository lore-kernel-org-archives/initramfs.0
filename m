From: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [systemd-devel] Second (erroneous) check of rootfs?
Date: Sun, 11 Jan 2015 14:11:25 +0300
Message-ID: <20150111141125.2d2c1f38@opensuse.site>
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
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rrq6cju1zoIQ+knlxkbm5JOVmxfekGBpMkszQMbhgwA=;
        b=Ujjcn4IwKq1Wa3mI0WXHK0cItOLqjzKtMjKiiWfQuYC19+1lht6eJkZ+s4X9FjvH8q
         OosXLt0a/SzBdUwziTj9+AwKOAPaaBrkVvziaUa+NGmsmJJ/gRia9/rbDKIY0Xkd9KvB
         hgRPNbDdo96TdapT1/sbS9i/NZRj4J+oDltU527sdD7ouqrml4lEQifKn612uR/trpxw
         RR9hsYvBY3z2fkvoqLKbUOS6uPI5+ocwmOEBQt7Ji8mYDAYhIhCdIUZy8QXRRoAKRLbi
         IZoVI6jesJOefzCb9SVmJl2GLSD/Mg317IF403oLiIKbPlLIqMUSYFyiWfQR3DhGyRjN
         RsDw==
In-Reply-To: <54B253D6.9040306-o+MxOtu4lMCHXe+LvDLADg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Nikolai Zhubr <n-a-zhubr-o+MxOtu4lMCHXe+LvDLADg@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

=D0=92 Sun, 11 Jan 2015 13:43:34 +0300
Nikolai Zhubr <n-a-zhubr-o+MxOtu4lMCHXe+LvDLADg@public.gmane.org> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> >
> > Uh. Why not simply mount rootfs rw in initrd then?
>=20
> I'm not against generally. But it'd mean that this first mount is=20
> actually a real mount, the fs will start up in full. Then I'd suppose=
 it=20
> is definitely a must to supply all necessary mount options (from fsta=
b)=20
> at this stage already. I don't easily see how to do this currently, a=
t=20
> least on my opensuse system.
>=20

By adding all needed options to rootflags=3D"..." (modify
GRUB_CMDLINE_LINUX_DEFAULT and possibly GRUB_CMDLINE_LINUX_RECOVERY
in /etc/default/grub; you can use yast for it).

Otherwise it is functional gap between non-systemd and systemd
enabled dracut. Without systemd dracut will actually mount root
read-only, then fetch mount options from real root /etc/fstab and then
remount real root read-write using correct options. This all got lost
when converting to systemd.
