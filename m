From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 8/8] Use udev rules to create dmraid /dev/mapper/ devices
Date: Mon, 29 Jun 2015 13:17:04 +0200
Message-ID: <2324088.fyCiPkHzWf@skinner>
References: <1435330557-17685-1-git-send-email-trenn@suse.de> <1435330557-17685-9-git-send-email-trenn@suse.de> <20150627084153.1936a074@opensuse.site>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150627084153.1936a074-stAJ6ESoqRzYCGPCin2YbQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hannes Reinecke <hare-IBi9RG/b67k@public.gmane.org>

On Saturday, June 27, 2015 08:41:53 AM Andrei Borzenkov wrote:
> =D0=92 Fri, 26 Jun 2015 16:55:57 +0200
>=20
> > diff --git a/modules.d/90dmraid/module-setup.sh
> > b/modules.d/90dmraid/module-setup.sh index e8de5f5..b77bbcf 100755
> > --- a/modules.d/90dmraid/module-setup.sh
> > +++ b/modules.d/90dmraid/module-setup.sh
> > @@ -74,6 +74,8 @@ install() {
> >=20
> >      inst "$moddir/dmraid.sh" /sbin/dmraid_scan
> >=20
> > +    inst_rules 64-md-raid.rules 66-kpartx.rules 67-kpartx-compat.r=
ules
> > +
>=20
> Why 64-md-raid.rules is here?

Probably the same reason why it slipped in once:
I mixed up md and dm and thought it is a dmraid rule which should
get in again if kpartx rules are used.

Thanks for finding this, the rule is already added at the right place:
modules.d/90mdraid/module-setup.sh
and should not show up here again.

I repost this one.

     Thomas

