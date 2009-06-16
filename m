From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Some netboot doc cleanups
Date: Tue, 16 Jun 2009 13:32:44 -0400
Message-ID: <4A37D73C.80100@redhat.com>
References: <4A36B285.2080905@redhat.com> <4A3759D2.2040101@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A3759D2.2040101-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/16/2009 04:37 AM, Seewer Philippe wrote:
>>> Network =B6
>>>
>>> * ip=3D[dhcp|on|any]
>>> o get ip from dhcp server from all interfaces
>>> o If root=3Ddhcp, loop sequentially through all interfaces (eth0, e=
th1,
>>> ...) and use the first with a valid DHCP root-path.
>>
>> dhcp and any seem to do the same thing. Get rid of any?
>
> This is "legacy" from kernel nfsroot. We should keep this for
> compatibility.
>
>>
>>> * ip=3D<interface>:[dhcp|on|any]
>>> o get ip from dhcp server on a specific interface
>>> * ip=3D[none|off]
>>> o no TCP/IP network
>>
>> What is the point of this? When is this ever useful?
>
> ip=3D[none|off] doesn't make any sense at all. Can be removed IMHO.
>

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
blob;f=3DDocumentation/filesystems/nfsroot.txt

ip none and off are mentioned here as well, although it seems ambiguous=
=20
as to the purpose.

Warren
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
