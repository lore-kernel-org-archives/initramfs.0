From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: rd.break=cmdline broken
Date: Fri, 12 Jul 2013 12:37:49 +0800
Message-ID: <20130712043749.GA4867@dhcp16-109.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi, Harald

I find that rd.break=cmdline will cause a dead lock of service
dependencies.

dracut-cmdline.service:
[..]
Before=systemd-vconsole-setup.service

dracut-emergency.service:
[..]
After=systemd-vconsole-setup.service
Wants=systemd-vconsole-setup.service

So it appears to be a dead lock between systemd-vconsole-setup.service
and dracut-cmdline.service if we issue dracut-emergency.service with
rd.break=cmdline.

Because vconsole.conf is generated under cmdline hook, so simply remove
'Before=systemd-vconsole-setup.service' wouldn't be a decent solution.

Wondering if you have any idea how to fix it.

Thanks,
WANG Chao
