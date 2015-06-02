From: Pawel Wieczorkiewicz <pwieczorkiewicz-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 2/4] 40network: Fix race condition when wait for
 networks
Date: Tue, 2 Jun 2015 12:50:16 +0200
Message-ID: <20150602125016.654a912e@linux-kf5h>
References: <1427127138-12932-1-git-send-email-trenn@suse.de>
	<1427127138-12932-3-git-send-email-trenn@suse.de>
	<556D823E.1090104@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <556D823E.1090104-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

On Tue, 02 Jun 2015 12:15:26 +0200
Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> > +            echo "[ -f /tmp/net.*.did-setup ]"
> > >$hookdir/initqueue/finished/wait-network.sh
>=20
> err, if multiple networks are up, [ -f /tmp/net.*.did-setup ] is not
> correct shell syntax.
>=20
> $ [ -e /dev/* ] && echo OK
> bash: [: too many arguments
>=20

Can this condition really occur?
Shouldn't we be done with the wait-network initqueue job condition just
after 1st network is setup (the '*' here just means whatever interface
is up, not multiple interfaces)?

AFAIR each network ifup request is a separate initqueue job and the
condition is evaluated between jobs switches. So first
created /tmp/net.*.did-setup, whatever interface it has, makes this
condition be satisfied.

This way or another, it can be improved to the longer and more
demanding multifiles variant (for file in /tmp/net.*.did-setup loop or
set -- /tmp/net.*.did-setup and $# > 0 evaluation).

--=20
Best Regards,
Pawel Wieczorkiewicz <pwieczorkiewicz-l3A5Bk7waGM@public.gmane.org>, Linux System Developer

SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Dilip Upman=
yu,
Graham Norton, HRB 21284 (AG N=C3=BCrnberg) Maxfeldstra=C3=9Fe 5 / 9040=
9
N=C3=BCrnberg / Germany / Phone: +49-911-740 53 - 613
