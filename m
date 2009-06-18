From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: root=dhcp dhclient segfaulting on F-11
Date: Wed, 17 Jun 2009 20:29:48 -0400
Message-ID: <4A398A7C.40003@redhat.com>
References: <4A391744.4040607@redhat.com> <4A3923F7.6000900@bfh.ch> <4A3924B9.2090303@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A3924B9.2090303-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Harald applied fixes.  Now with root=dhcp it is failing to boot because 
dhclient is segfaulting.

ifup.eth0.561.out contains:
...
+ ip=
+ '[' -z '' ']'
+ do_dhcp
+ dhclient -1 -q -cf /etc/dhclient.conf -pf /tmp/dhclient.eth0.pid -lf 
/tmp/dhclient.eth0.lease eth0
/sbin/ifup: line 26:   563 Segmentation fault
...

dhclient.eth0.564.out contains only:
+ '[' -f /tmp/net..up ']'
+ netif=eth0
+ case $reason in
+ ip link set eth0 up
+ exit 0

dhclient.eth0.567.out contains:
+ '[' -f /tmp/net..up ']'
+ netif=eth0
+ case $reason in
+ setup_interface
... (and it sets it up properly via DHCP)...
... (but eth0 is not configured by the time it hits the shell)...

The following is a segfault at the emergency_shell when I have manually 
run "dhclient eth0".

Program terminated with signal 11, Segmentation fault.
#0  0x0806fd4d in add_timeout (when=0x4a3986b2, where=0x8056a20 
<send_discover>, what=0x95fc5d0, ref=0, unref=0) at dispatch.c:143
143		q -> when . tv_sec = when -> tv_sec;
(gdb) bt
#0  0x0806fd4d in add_timeout (when=0x4a3986b2, where=0x8056a20 
<send_discover>, what=0x95fc5d0, ref=0, unref=0) at dispatch.c:143
#1  0x08056dd7 in state_init (cpp=0x95fc5d0) at dhclient.c:1213
#2  0x080580f8 in bind_lease (client=0x95fc5d0) at dhclient.c:1494
#3  0x08058b72 in dhcpack (packet=0x95fcef8) at dhclient.c:1460
#4  0x080547cf in dhcp (packet=0x95fcef8) at dhclient.c:1693
#5  0x0807ae63 in do_packet (interface=0x95d4608, packet=0xbfdf25a4, 
len=300, from_port=17152, from={len = 4, iabuf = 
"\254\37d\376a)\n\b\2\0\0\0\0\0\0"}, hfrom=0xbfdf35ba) at options.c:3732
#6  0x0806db8f in got_one (h=0x95d4608) at discover.c:1393
#7  0x080a763e in omapi_one_dispatch (wo=0x0, t=0xbfdf39c8) at 
dispatch.c:473
#8  0x0806fed0 in dispatch () at dispatch.c:92
#9  0x0805aa2c in main (argc=2, argv=0xbfdf3c54) at dhclient.c:971

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
