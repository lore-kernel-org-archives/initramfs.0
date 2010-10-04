From: =?utf-8?q?Amadeusz_=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: NFS root with Dracut not calling nfsroot script
Date: Mon, 04 Oct 2010 13:02:54 +0200
Message-ID: <1286189382-sup-6507@etiriah>
References: <20101002062617.5730102kmedzh6uo@webmail.zoltak.com> <20101004152252.15833xc2gkzz1mdc@webmail.zoltak.com> <4CA9998F.7060701@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <4CA9998F.7060701-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="utf-8"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 10/04/2010 06:22 AM, daniel-2N1FInP7wozQT0dZR+AlfA@public.gmane.org, init.log:
> ifup.eth0.783 + dhclient -4 -1 -q -cf /etc/dhclient.conf -pf /tmp/dhc=
lient.eth0.pid -lf /tmp/dhclient.eth0.lease eth0
> Internet Systems Consortium DHCP Client V3.1.2p1-Gentoo
> Copyright 2004-2009 Internet Systems Consortium.
> All rights reserved.
> For info, please visit http://www.isc.org/sw/dhcp/
> Usage: dhclient [-1dqrx] [-nw] [-p <port>] [-s server]
> [-cf config-file] [-lf lease-file][-pf pid-file] [-e VAR=3Dval]
> [-sf script-file] [interface]

Gentoo? :-)  Are you using Dracut from Git repo or ebuild?  Which
version?  As Harald said you should try dhcp-4.  Don't worry it's
hard-masked under Gentoo - it works where dhcp-3 fails.


Cheers,
--=20
Amadeusz =C5=BBo=C5=82nowski

PGP key: 1024D/C284750D
