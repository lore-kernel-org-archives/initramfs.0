From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: root=dhcp dhclient segfaulting on F-11
Date: Thu, 18 Jun 2009 09:32:39 +0200
Message-ID: <4A39ED97.8040503@bfh.ch>
References: <4A391744.4040607@redhat.com> <4A3923F7.6000900@bfh.ch> <4A3924B9.2090303@redhat.com> <4A398A7C.40003@redhat.com> <4A39A3D1.4070404@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A39A3D1.4070404-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



Warren Togami wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=506626
> 
> Filed the dhclient segfault here.  I've been trying to debug this for 
> the past 5 hours straight.  I'm perplexed.
> 
> Backing out to 1a945a576c0016c47f983d27727443ac33c5b6a8 prior to 
> Phillippe's patch series dhclient does not crash.

That is weird. I have no problems at all with isc-dhclient-V3.1.1

Question: Does it segfault in the test-suites as well?

> 
> dhcpd.conf contains:
> option root-path "172.31.100.254:/opt/ltsp/i386";
> 
> Here's something curious...
> 
> sh-4.0# dhclient -v eth0
> Internet Systems Consortium DHCP Client 4.1.0
> Copyright 2004-2008 Internet Systems Consortium.
> All rights reserved.
> For info, please visit http://www.isc.org/sw/dhcp/
> 
> Listening on LPF/eth0/52:54:00:12:34:56
> Sending on   LPF/eth0/52:54:00:12:34:56
> DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 5
> DHCPOFFER from 172.31.100.254
> DHCPREQUEST on eth0 to 255.255.255.255 port 67
> DHCPACK from 172.31.100.254
> DHCPDECLINE on eth0 to 255.255.255.255 port 67
> dhclient[616]: segfault at 4a39a266 ip 0806fd4d sp bfa4eed0 error 4 in 
> dhclient[8048000+84000]
> 
> DHCPDECLINE?  Haven't seen that before.

See here: http://www.freesoft.org/CIE/RFC/2131/25.htm

Regards,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
