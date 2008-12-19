From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Dracut questions
Date: Fri, 19 Dec 2008 00:16:31 -0500
Message-ID: <494B2E2F.5090203@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

https://fedoraproject.org/wiki/Initrdrewrite
> Probe at runtime instead of buildtime - Include all drivers, not just
> the drivers necessary for the hardware being run. (For storage, the
> common ones will be built-in to the kernel anyway)

This means include all storage drivers and firmware for the storage drivers?

Does this also mean we only add network drivers if the initrd is 
explicitly built for netboot?

How do we plan on dealing with the location of various standard 
utilities being different on other Linux distributions?

Fedora		Debian
/sbin/lspci	/usr/bin/lspci
/sbin/lsmod	/bin/lsmod
(just off the top of my head)

Perhaps use "which" to find it?  But then how do we choose its 
destination path in the initrd chroot if the distributions disagree on 
where they expect a command to go?  Will they disagree?

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
