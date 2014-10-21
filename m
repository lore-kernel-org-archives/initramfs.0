From: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dracut: qestions about mdraid module
Date: Tue, 21 Oct 2014 19:06:15 +0400
Message-ID: <20141021190615.7177a929@opensuse.site>
References: <5426D606.6020300@gmail.com>
	<5444EBDF.7090004@redhat.com>
	<5446532E.3050304@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CUowZpRaJoqR+LVyeWZ0okAiGNnGlbq1zcUIf/s9aEs=;
        b=dOQgk1pU8aFJYF8yqQiIlQhPduqY8beVoC59iebT3Lak+oTwHc+vK0B8zu+wYMP3+w
         IHbSBP3NEC22re1hqXfZ/+KSCmbdQnbZMTmMxP1yEZym82G+J1rUpUUu61N/2q4tu8ZH
         SsVY6HgLcVx67TuGosIctd8FW3YSR8oKlVc+WRlIqxmM4gk646fEowAonvsc6dhskAeT
         gZKpLxDVRNfhhApb9DjaRFzyvwkKK6wwpew4dDDiHeW7Zzce9RuL+jt6y6x/8BDe9fC0
         RGZU0PIvM3StNMLhluzpB456rayh+4hOjZcDoCQaTA1gm8c/WNM6GGt5iiTV9ekU6pGZ
         ACWA==
In-Reply-To: <5446532E.3050304-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Francis Moreau <francis.moro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

=D0=92 Tue, 21 Oct 2014 14:35:58 +0200
=46rancis Moreau <francis.moro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =D0=BF=D0=B8=D1=88=D0=B5=D1=82=
:

> On 10/20/2014 01:02 PM, Harald Hoyer wrote:
> > On 27.09.2014 17:21, Francis Moreau wrote:
> >> Hello,
> >>
> >> I'm looking at the module 'mdraid' of dracut (0.38) and was wonder=
ing
> >> the purpose of rd.md.uuid=3D parameter.
> >>
> >> I understand it can be used to selectively activate the array matc=
hing
> >> the UUID passed through the parameter but I'm wondering in which c=
ases
> >> it can be useful...
> >>
> >> Also I don't really understand why dracut try to do its own mechan=
ism to
> >> achieve that (by providing its own udev rules which are modified a=
t boot
> >> time) whereas mdadm already provide the infrastructure (through
> >> mdadm.conf) in a cleaner way (IMHO).
> >=20
> >=20
> > If mdadm.conf is not included in the initramfs, you want to have a =
way to
> > prevent automatic assembly of all raids found. With big machines, l=
ots of disk,
> > you only want to assemble those, which you really need.
> >=20
>=20
> Ok but why mdadm.conf wouldn't be included in the initramfs ? If one
> doesn't want to start all arrays during the boot process, it's very
> likely he doesn't start all arrays automatically while the system is
> running, no ?
>=20

This could be generic initrd that does not include any host-specific
mdadm.conf (or any other host specific configuration for that matter).
