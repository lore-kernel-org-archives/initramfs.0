From: Alexandr Gluzskiy <sss-qO4y48a2ZxUwyC7LCg2Ifw@public.gmane.org>
Subject: dracut hook after udev and udev rules initialized
Date: Thu, 23 Jan 2014 01:49:07 +0200
Message-ID: <affef1a49697bc7f2e7ab8b5c6d41f66@sss.chaoslab.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Good day. i have problem with dracut. i need to do some custom actions 
in initramfs after udev started and all rules are running. i have no 
luck at all, i have read dracut documentation and found pre-trigger hook 
is closest one to what i need, but it running before udev rules are 
initialized, so i still do not have required devices at that time.
is there any way to achieve what i need ?
