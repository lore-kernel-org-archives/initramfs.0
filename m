From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Passing dhclient leases through switch_root
Date: Mon, 01 Jun 2009 18:02:28 -0400
Message-ID: <4A244FF4.9040905@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

cp /var/lib/dhclient/dhclient.leases /sysroot/dev/.dhclient-$dev.leases

mkinitrd for a while has copied the leases file to /dev, because it is 
the only directory that survives switch_root.  The system then can have 
the entire leases file for whatever needed purposes.

Any objections to doing this in dracut?

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
