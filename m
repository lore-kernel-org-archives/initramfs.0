From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH 0/2] dracut, udev and complicated netboot cases
Date: Sat, 14 Mar 2009 13:52:55 +0100
Message-ID: <49BBA8A7.4010903@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hello all

The following two patches add udev driven network configuration support 
and a basic nfsroot handler.

As describe earlier, there can be many weird and complicated netboot 
cases. The requirement that it should be udev driven doesn't make it any 
easier. At least at first glance.

The current solution actually makes use of udev for speed up. The idea 
is based on Victor Lowther's first implementation which forked off 
dhclients after the udev event fired. By modifying ifup and the 
dhclient-script we can synchronize back by using a simple (blocking) 
FIFO. Interfaces which are ready are upped and tested FIFO-style by 
reading one out of the fifo, and handing over the the actual 
mount-script. If it succeeds, all is well. If it fails or times out, we 
try (or wait for) the next interface.

The whole interface configuration part tries to behave as much like the 
current implementation inside the kernel as possible, with a few 
extensions:
- I'm assuming that if there's a network driver inside the initrd the 
user wants something. So no ip= option is treated like ip=dhcp
- Instead of only relying on the first interface that pops up or the one 
that first receives a dhcp reply we try all interfaces that have a 
useable configuration.


Patches apply on top of Harald Hoyers merge tree
(git://git.surfsite.org/pub/git/dracut.git)

Regards,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
