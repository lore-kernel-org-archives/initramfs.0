From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: /dev/.initramfs copy state before switch_root
Date: Mon, 08 Jun 2009 17:27:30 -0400
Message-ID: <4A2D8242.40205@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

I have pushed the following changes.

* If netboot, copy /tmp/net.* to /dev/.initramfs/.  Initscripts of your 
distribution or NetworkManager can read the files in this location to be 
aware of prior configured interfaces.  A distribution may choose to do 
something with this information.

* If you specify kernel cmdline "rdcopystate", then all of /tmp/* is 
copied into /dev/.initramfs/.  This could sometimes be useful for 
post-boot examination or debugging.

* net.<interface name>.lease is written containing the DHCP lease, 
because dcbw asked for this for NetworkManager.  Your own tools could 
choose to do something with it or not.

TODO:

* We need something to write out a file like 
/dev/.initramfs/net.eth0.static in the case of a static IP during 
initrd.  I have never used static IP with initrd before.  Are there 
multiple syntaxes to configure static IP?  Others have touched this part 
of the code.

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
