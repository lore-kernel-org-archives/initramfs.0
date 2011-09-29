From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: rdshell and rdbreak
Date: Thu, 29 Sep 2011 14:43:50 +0800
Message-ID: <4E8413A6.2090804@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

For kernel developers sometimes boot-test need a minimal initrd, so just
drop into a shell is a nice feature.

The first impression of param 'rdshell' to me is it will drop me into a
shell, but It doesn't. It drop into shell only when initramfs fails.

The rdbreak is more near what I want, but it still fails when no root
args set in cmdline.

IMO initrd can provide such options at least: dropping into shell
without mount rootfs, user can mount by himself or do other things.

Thus, if it make sense how about add a:
rdbreak=force

OTOH, rdshell can be merged into rdbreak as:
rdbreak=fail

Any comments about this?
-- 
Thanks
Dave
