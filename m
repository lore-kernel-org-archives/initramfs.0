From: daniel-2N1FInP7wozQT0dZR+AlfA@public.gmane.org
Subject: Dracut NFS root DHCP timeouts
Date: Mon, 11 Oct 2010 13:37:18 +1100
Message-ID: <20101011133718.205549hmcnjzr3a8@webmail.zoltak.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; delsp="Yes"; format="flowed"
To: "nitramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Guys,

I'm getting their with my Dracut setup however I'm having a weird DHCP issue.

I can't get DHCP 4.0.1 or 4.1.0 working with Gentoo and Dracut 007.

I've downgraded to DHCP 3.1.2p1 and removed the -4 flag from the  
Dracut scripts.

The PXEBoot line is:
APPEND bootdev=eth1 ip:eth0:off ip=eth1:dhcp  
root=10.197.170.5:/vol/filerboot/linux/images/live-mon-test:fg,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nfsvers=3,nointr,actimeo=3600,noacl,rw,tcp,sec=sys initrd=initrd-2.6.34-gentoo-r1-dracut  
rw

While the server boots and the interfaces initializers I see:
Sending DHCP requets .....timed out

The following happens 2-3 times

The DHCP server logs report..

Attempt 1:
dhcpd: DHCPREQUEST for 201.0.0.0 (180.0.0.0) from 00:19:b9:eb:3d:4e  
via 10.197.220.241: ignored (not authoritative).
dhcpd: DHCPREQUEST for 201.0.0.0 (180.0.0.0) from 00:19:b9:eb:3d:50  
via eth1: ignored (not authoritative).
dhcpd: DHCPREQUEST for 201.0.0.0 (180.0.0.0) from 00:19:b9:eb:3d:4e  
via 10.197.220.241: ignored (not authoritative).
dhcpd: DHCPREQUEST for 201.0.0.0 (180.0.0.0) from 00:19:b9:eb:3d:50  
via eth1: ignored (not authoritative).
dhcpd: DHCPREQUEST for 201.0.0.0 (180.0.0.0) from 00:19:b9:eb:3d:4e  
via 10.197.220.241: ignored (not authoritative).
dhcpd: DHCPREQUEST for 201.0.0.0 (180.0.0.0) from 00:19:b9:eb:3d:50  
via eth1: ignored (not authoritative).
dhcpd: DHCPREQUEST for 201.0.0.0 (180.0.0.0) from 00:19:b9:eb:3d:4e  
via 10.197.220.241: ignored (not authoritative).
dhcpd: DHCPREQUEST for 201.0.0.0 (180.0.0.0) from 00:19:b9:eb:3d:50  
via eth1: ignored (not authoritative).

Attempts 2:
dhcpd: DHCPREQUEST for 255.255.255.255 (180.0.0.0) from  
00:19:b9:eb:3d:4e via 10.197.220.241: ignored (not authoritative).
dhcpd: DHCPREQUEST for 255.255.255.255 (180.0.0.0) from  
00:19:b9:eb:3d:50 via eth1: ignored (not authoritative).
dhcpd: DHCPREQUEST for 255.255.255.255 (180.0.0.0) from  
00:19:b9:eb:3d:4e via 10.197.220.241: ignored (not authoritative).
dhcpd: DHCPREQUEST for 255.255.255.255 (180.0.0.0) from  
00:19:b9:eb:3d:50 via eth1: ignored (not authoritative).
dhcpd: DHCPREQUEST for 255.255.255.255 (180.0.0.0) from  
00:19:b9:eb:3d:4e via 10.197.220.241: ignored (not authoritative).
dhcpd: DHCPREQUEST for 255.255.255.255 (180.0.0.0) from  
00:19:b9:eb:3d:50 via eth1: ignored (not authoritative).

Just before the pivot DHCP runs again and all works. The DHCP server reports:

dhcpd: DHCPDISCOVER from 00:19:b9:eb:3d:50 via eth1
dhcpd: DHCPOFFER on 10.197.170.30 to 00:19:b9:eb:3d:50 via eth1
dhcpd: Dynamic and static leases present for 10.197.170.30.
dhcpd: Remove host declaration san.n15-pizza1-3 or remove 10.197.170.30
dhcpd: from the dynamic address pool for 10.197.170.0/24
dhcpd: DHCPREQUEST for 10.197.170.30 (10.197.170.42) from  
00:19:b9:eb:3d:50 via eth1
dhcpd: DHCPACK on 10.197.170.30 to 00:19:b9:eb:3d:50 via eth1

Gentoo boots and all seems to be ok except for a weird issue where the  
resolv.conf is not updated correctly.


Any ideas on what the causing the initial DHCP timeouts? It makes the  
boot process take a lot longer!


Thanks



