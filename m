From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: Dracut NFS root DHCP timeouts
Date: Mon, 11 Oct 2010 14:25:21 +0200
Message-ID: <4CB30231.80803@bfh.ch>
References: <20101011133718.205549hmcnjzr3a8@webmail.zoltak.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101011133718.205549hmcnjzr3a8-2RFepEojUI3Y3UUic/vCjNBPR1lH4CV8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "daniel-2N1FInP7wozQT0dZR+AlfA@public.gmane.org" <daniel-2N1FInP7wozQT0dZR+AlfA@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Daniel

On 10/11/2010 04:37 AM, daniel-2N1FInP7wozQT0dZR+AlfA@public.gmane.org wrote:
> While the server boots and the interfaces initializers I see:
> Sending DHCP requets .....timed out
>
> The following happens 2-3 times
>
> The DHCP server logs report..
>
> Attempt 1:
> dhcpd: DHCPREQUEST for 201.0.0.0 (180.0.0.0) from 00:19:b9:eb:3d:4e
> via 10.197.220.241: ignored (not authoritative).
> dhcpd: DHCPREQUEST for 201.0.0.0 (180.0.0.0) from 00:19:b9:eb:3d:50
> via eth1: ignored (not authoritative).
> dhcpd: DHCPREQUEST for 201.0.0.0 (180.0.0.0) from 00:19:b9:eb:3d:4e
> via 10.197.220.241: ignored (not authoritative).
> dhcpd: DHCPREQUEST for 201.0.0.0 (180.0.0.0) from 00:19:b9:eb:3d:50
> via eth1: ignored (not authoritative).
> dhcpd: DHCPREQUEST for 201.0.0.0 (180.0.0.0) from 00:19:b9:eb:3d:4e
> via 10.197.220.241: ignored (not authoritative).
> dhcpd: DHCPREQUEST for 201.0.0.0 (180.0.0.0) from 00:19:b9:eb:3d:50
> via eth1: ignored (not authoritative).
> dhcpd: DHCPREQUEST for 201.0.0.0 (180.0.0.0) from 00:19:b9:eb:3d:4e
> via 10.197.220.241: ignored (not authoritative).
> dhcpd: DHCPREQUEST for 201.0.0.0 (180.0.0.0) from 00:19:b9:eb:3d:50
> via eth1: ignored (not authoritative).
>
> Attempts 2:
> dhcpd: DHCPREQUEST for 255.255.255.255 (180.0.0.0) from
> 00:19:b9:eb:3d:4e via 10.197.220.241: ignored (not authoritative).
> dhcpd: DHCPREQUEST for 255.255.255.255 (180.0.0.0) from
> 00:19:b9:eb:3d:50 via eth1: ignored (not authoritative).
> dhcpd: DHCPREQUEST for 255.255.255.255 (180.0.0.0) from
> 00:19:b9:eb:3d:4e via 10.197.220.241: ignored (not authoritative).
> dhcpd: DHCPREQUEST for 255.255.255.255 (180.0.0.0) from
> 00:19:b9:eb:3d:50 via eth1: ignored (not authoritative).
> dhcpd: DHCPREQUEST for 255.255.255.255 (180.0.0.0) from
> 00:19:b9:eb:3d:4e via 10.197.220.241: ignored (not authoritative).
> dhcpd: DHCPREQUEST for 255.255.255.255 (180.0.0.0) from
> 00:19:b9:eb:3d:50 via eth1: ignored (not authoritative).
>
> Just before the pivot DHCP runs again and all works. The DHCP server reports:
>
> dhcpd: DHCPDISCOVER from 00:19:b9:eb:3d:50 via eth1
> dhcpd: DHCPOFFER on 10.197.170.30 to 00:19:b9:eb:3d:50 via eth1
> dhcpd: Dynamic and static leases present for 10.197.170.30.
> dhcpd: Remove host declaration san.n15-pizza1-3 or remove 10.197.170.30
> dhcpd: from the dynamic address pool for 10.197.170.0/24
> dhcpd: DHCPREQUEST for 10.197.170.30 (10.197.170.42) from
> 00:19:b9:eb:3d:50 via eth1
> dhcpd: DHCPACK on 10.197.170.30 to 00:19:b9:eb:3d:50 via eth1
>
> Gentoo boots and all seems to be ok except for a weird issue where the
> resolv.conf is not updated correctly.

Ummm... Just so that I understand this. The logs for Attempt 1 and 2 are 
after the dracut pivot from the dhcp requests inside the nfs-rooted 
system and the logs and the last one above is from dhcp inside dracut. 
correct?

> Any ideas on what the causing the initial DHCP timeouts? It makes the
> boot process take a lot longer!

BTW: If you are using a recent pxelinux, why don't you try IPAPPEND=3 
and remove all ip-options from dracut? (See 
http://syslinux.zytor.com/wiki/index.php/SYSLINUX#IPAPPEND_flag_val_.5BPXELINUX_only.5D). 
This should cause dracut not to issue any dhcp requests at all. Sorry I 
haven't thought about this earlier.

Regards,
Philippe
