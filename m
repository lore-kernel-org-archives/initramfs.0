From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Some netboot doc cleanups
Date: Mon, 15 Jun 2009 16:43:49 -0400
Message-ID: <4A36B285.2080905@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

https://sourceforge.net/apps/trac/dracut/wiki/commandline
> Configuration in initrd =B6
>
> /conf/conf.d/*
>     command line options can override values set here

What is the intent here?  This is only used from=20
modules.d/95iscsi/iscsiroot and nowhere else.

> Network =B6
>
>     * ip=3D[dhcp|on|any]
>           o get ip from dhcp server from all interfaces
>           o If root=3Ddhcp, loop sequentially through all interfaces =
(eth0, eth1, ...) and use the first with a valid DHCP root-path.

dhcp and any seem to do the same thing.  Get rid of any?

>     * ip=3D<interface>:[dhcp|on|any]
>           o get ip from dhcp server on a specific interface
>     * ip=3D[none|off]
>           o no TCP/IP network

What is the point of this?  When is this ever useful?

>     * ip=3D<client-IP-number>:<gateway-IP-number>:<netmask>:<client-h=
ostname>:<interface>:[dhcp|on|any|none|off|]
>           o explicit network configuration


> rdbreak=3D[pre-udev|pre-mount|mount|pre-pivot|]
>     drop the shell on defined breakpoint

It isn't clear from this syntax how to make it break in two particular=20
places.  Please clarify.

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
