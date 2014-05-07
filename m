From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: Re: Intend of hostonly-cmdline?
Date: Wed, 7 May 2014 17:15:27 +0400
Message-ID: <20140507171527.2d826560@work.puleglot>
References: <2263850.UM9clb02rz@skinner>
	<536A19D7.2010405@redhat.com>
	<20140507154733.386369cd@work.puleglot>
	<536A2222.50606@redhat.com>
	<536A22C9.8000007@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date; bh=c+IQQOoLwoSEX3NNr7/2SYfykWZI98Yu9C8uAvRDd0Q=;
	b=RLBbMyyc2glWjOUQ/dETxdl24xQWAvJ7E8ariDqkfEcMSaZegTt/FiSRV+3aTD9AxnNgZCxDFIHQqXaEP7gg0qMCmQV/6kKqN31hxncGVmH3mqp9fnnCMtL43EXjQ2aZkd4taFbSfipMBcuxdQw1JeSrDWtPVyw9WRG0F952Zz4=;
In-Reply-To: <536A22C9.8000007-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="koi8-r"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

=F7 Wed, 07 May 2014 14:10:49 +0200
Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> =D0=C9=DB=C5=D4:

> On 07.05.2014 14:08, Harald Hoyer wrote:
> > On 07.05.2014 13:47, Alexander Tsoy wrote:
> >> Actually hostonly-cmdline is partially broken with systemd in
> >> initramfs. For example systemd-cryptsetup-generator does not
> >> read /etc/cmdline.d/*.conf files, so rd.luks* parameters must be
> >> appended to kernel cmdline anyway.
> >>
> >=20
> > True! Good point!
> > Although /etc/crypttab is included with hostonly.
> >=20
>=20
> Ah, oh.. I forgot, dracut *does* use rd.luks.uuid from the kernel com=
mand line
> and creates /etc/crypttab lines from it in the initramfs.
> So basically it *should* work with systemd.

This doesn't work with full disk encryption. Unit file does not get
generated and I see this message:

[    7.142993] testhost dracut-initqueue[202]: Failed to start systemd-=
cryptsetup@luks\x2d342d2414\x2d159c\x2d48d7\x2da0b7\x2d5b59fa6e27a5.ser=
vice: Unit=20
systemd-cryptsetup@luks\x2d342d2414\x2d159c\x2d48d7\x2da0b7\x2d5b59fa6e=
27a5.service failed to load: No such file or directory.

Probably this is because crypt-run-generator get executed from udev
rules only if *both* of the following conditions are true:
- there is no rd.luks.uuid parameter in both cmdline
and /etc/cmdline.d/*.conf
- rd.auto is enabled

--=20
Alexander Tsoy
