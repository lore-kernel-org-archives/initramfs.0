From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: NFS root with Dracut not calling nfsroot script
Date: Mon, 4 Oct 2010 13:28:12 +0200
Message-ID: <4CA9BA4C.1010101@bfh.ch>
References: <20101002062617.5730102kmedzh6uo@webmail.zoltak.com> <20101004152252.15833xc2gkzz1mdc@webmail.zoltak.com> <4CA9998F.7060701@redhat.com> <20101004222036.53485185m6mhh11c@webmail.zoltak.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101004222036.53485185m6mhh11c-2RFepEojUI3Y3UUic/vCjNBPR1lH4CV8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "daniel-2N1FInP7wozQT0dZR+AlfA@public.gmane.org" <daniel-2N1FInP7wozQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hy Daniel

On 10/04/2010 01:20 PM, daniel-2N1FInP7wozQT0dZR+AlfA@public.gmane.org wrote:
> Thanks Harald.
> 
> Quoting Harald Hoyer<harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
> 
>> So, it seeems like your dhclient does not support one of the options
>> (most likely "-4").
>> You might want to try dhclient version>  4 or modify
>> /usr/share/dracut/modules.d/40network/ifup and remove "-4" from
>> "do_dhcp -4".
> 
> I've updated the dhclient to 4.10. I've attached a new init.log. It's
> still not working. There appears to be an error around the same point.

Actually the dhclient version inside your image is still 3.1.2p1:
[quote]
ifup.eth0.783 + dhclient -4 -1 -q -cf /etc/dhclient.conf -pf /tmp/dhclient.eth0.pid -lf /tmp/dhclient.eth0.lease eth0
Internet Systems Consortium DHCP Client V3.1.2p1-Gentoo
Copyright 2004-2009 Internet Systems Consortium.
All rights reserved.
For info, please visit http://www.isc.org/sw/dhcp/
Usage: dhclient [-1dqrx] [-nw] [-p <port>] [-s server]
[-cf config-file] [-lf lease-file][-pf pid-file] [-e VAR=val]
[-sf script-file] [interface]
[/quote]

Im running dracut NFSroot on debian with dhclient 3.1.1 without errors. Just remove the -4 in ifup and everything should (hopefully) work out.

Regards,
Philippe
