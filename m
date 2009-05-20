From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Netboot fails with multiple interfaces, wireless
Date: Tue, 19 May 2009 23:51:24 -0400
Message-ID: <4A137E3C.1040204@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Harald,

I tried your root=dhcp netboot code.

Is it intended that you need both root=dhcp and ip=dhcp?  Surely the 
first implies the second?

So it does successfully mount and NFS root boot, but as I feared it has 
trouble due to the presence of a wireless device.  One thin client I 
have is Intel Atom with e1000e NIC and iwlagn wireless.  It appears to 
dhcp once successfully on the eth0 ethernet, but its event-driven nature 
also tries to launch dhclient again on the wlan0.  dhclient complains 
that dhclient is already running and fails.

dhclient wouldn't have succeeded at all on the iwlagn interface because 
the firmware is lacking from the initrd, and it isn't associated.  Also 
I don't see when it is ever desired to netboot over a wireless interface.

As for excluding wireless interfaces, we should do a few things:
- Do not copy wireless drivers into the initrd.  You suggested using 
/etc/modprobe.d/something.conf to blacklist the driver from loading.  We 
would need a way to blacklist the driver during the initrd without 
blacklisting it on the host system where the initrd is generated.  How?
- Perhaps we should exclude any interfaces named "wlan*" from ifup and 
dhclient.  This works for most devices, but some wireless drivers call 
the wireless interfaces "eth*".
- I have no idea if it is attempting to ifup and dhclient other devices 
that appear like wmaster0.

A separate but related matter is what to do if a machine has more than 
one ethernet interface.  It seems the only sane thing you CAN do is ifup 
and dhclient only on the first interface?

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
