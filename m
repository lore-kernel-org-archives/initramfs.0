From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Does dracut need start watchdog?
Date: Mon, 5 Aug 2013 18:19:29 +0800
Message-ID: <20130805101929.GA26184@dhcp-16-252.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Harald,

Since some drivers do the soft kicking. That is if BIOS has enabled
watchdog, then kernel driver kicks the hardware till user space watchdog
daemon comes along. This can help sove the problem in kdump which kdump
kernel reboot before vmcore saving is finished. That problem is
triggered because watchdog started in 1st kernel and timeout because of
stopping being kicked.

I noticed in 04watchdog the watchdog.sh will start watchdog if
/dev/watchdog exists. I am just wondering if it's needed to start
watchdog by accessing /dev/watchdog. If starting watchdog is not needed,
I want to make some code change of watchdog.sh.

What's your suggestion?

Baoquan
Thanks a lot
