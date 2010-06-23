From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: dracut ip= parameter and static IP configuration
Date: Wed, 23 Jun 2010 17:40:41 +0200
Message-ID: <4C222AF9.1040208@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Radek Vykydal <rvykydal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Hi Harald et all,

The dracut man page says:

        ip=<client-IP>:[<server-id>]:<gateway-IP>:<netmask>:<clienthostname>
        :<interface>:{none|off}
               explicit  network  configuration.  If  you want do define a IPv6
               address, put it in brackets (e.g. [2001:DB8::1]).  This  parame-
               ter can be specified multiple times.

Which suggests that static ipv6 configuration is supported, but what to do
with the prefix versus netmask ? ipv6 addresses do not use netmasks but instead
always use the prefix notation, for example:

2001:aaaa::3/64

Regards,

Hans
