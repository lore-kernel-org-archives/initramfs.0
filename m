From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Netboot test suite: PXE instead of qemu -kernel?
Date: Tue, 23 Jun 2009 13:11:00 -0400
Message-ID: <4A410CA4.8030506@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Just a quick thought.

The netboot tests currently create a server and client qemu image.

Why are we using -kernel and -initrd on the client-side qemu?  Wouldn't 
testing PXE with the dhcp + tftp server on the server-side be more 
realistic?

Additionally we could use -net tap* instead of -net socket, which would 
allow brctl setfd of a large value like 20 seconds to simulate the link 
delay in the test suite.

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
