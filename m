From: =?GB2312?B?z8TA2g==?= <lei.xia-TJRtMXcVgQTM1kAEIRd3EQ@public.gmane.org>
Subject: how to debug shutdown hooks
Date: Mon, 30 Jun 2014 10:30:05 +0800
Message-ID: <53B0CBAD.5010600@cs2c.com.cn>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello, All

I place a 99eject.sh (eject /dev/sr0) to the
/run/initramfs/usr/lib/dracut/hooks/shutdwon/,

and I run reboot command, but the CD/DVD is not be ejected.

How I to debug this problem.

thanks!
