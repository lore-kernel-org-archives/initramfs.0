From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Why is mixing BOOTIF= and ip= dangerous?
Date: Thu, 16 Aug 2012 17:00:32 -0400
Message-ID: <1345150832.6844.93.camel@samus>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

40network/parse-ip-opts.sh says:

  # Don't mix BOOTIF=macaddr from pxelinux and ip= lines
  getarg ip= >/dev/null && getarg BOOTIF= >/dev/null && \
      die "Mixing BOOTIF and ip= lines is dangerous"

Why is this dangerous? Couldn't we just ignore BOOTIF= if ip= is
present?

Here's why I ask - in anaconda, if the user passes a kickstart file
inside initramfs (common in PXE environments), it can contain a line
like this:

  network --bootproto=static --ip=10.0.2.15 --netmask=255.255.255.0 ...

which anaconda will translate into something like:

  ip=10.0.2.15::10.0.2.1:255.0.0.0:::none

but because there's also BOOTIF=... in the boot args, dracut just die()s
instead. Even if the kickstart says "network --bootproto=dhcp", which
becomes "ip=dhcp" (which is the behavior for BOOTIF=...), it dies.

So. Is this necessary? If so, why? If not, can we remove that check and
just ignore BOOTIF if there's an ip= arg?

-w
