From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: Some netboot doc cleanups
Date: Tue, 16 Jun 2009 10:37:38 +0200
Message-ID: <4A3759D2.2040101@bfh.ch>
References: <4A36B285.2080905@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A36B285.2080905-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



Warren Togami wrote:
> https://sourceforge.net/apps/trac/dracut/wiki/commandline
>> Configuration in initrd =B6
>>
>> /conf/conf.d/*
>>     command line options can override values set here
>=20
> What is the intent here?  This is only used from=20
> modules.d/95iscsi/iscsiroot and nowhere else.
>=20
>> Network =B6
>>
>>     * ip=3D[dhcp|on|any]
>>           o get ip from dhcp server from all interfaces
>>           o If root=3Ddhcp, loop sequentially through all interfaces=
=20
>> (eth0, eth1, ...) and use the first with a valid DHCP root-path.
>=20
> dhcp and any seem to do the same thing.  Get rid of any?

This is "legacy" from kernel nfsroot. We should keep this for compatibi=
lity.

>=20
>>     * ip=3D<interface>:[dhcp|on|any]
>>           o get ip from dhcp server on a specific interface
>>     * ip=3D[none|off]
>>           o no TCP/IP network
>=20
> What is the point of this?  When is this ever useful?

ip=3D[none|off] doesn't make any sense at all. Can be removed IMHO.

Regards,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
