From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Copy dhclient.leases before switchroot?
Date: Tue, 19 May 2009 17:50:26 -0400
Message-ID: <4A1329A2.4030001@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

mkinitrd does this after dhclient, before switchroot:
cp /var/lib/dhclient/dhclient.leases /sysroot/dev/.dhclient-$dev.leases

/etc/sysconfig/network-scripts/ifup-eth contains:

# copy any lease obtained by the initrd
if [ -f /dev/.dhclient-${DEVICE}.leases ] ; then
     mv -f /dev/.dhclient-${DEVICE}.leases /var/lib/dhclient/dhclient-${DEVICE}.leases
     [ -x /sbin/restorecon ] && restorecon /var/lib/dhclient/dhclient-${DEVICE}.leases > /dev/null 2>&1
fi

I personally have never needed this, but some networks might need dhclient to refresh the lease after bootup?

Implementing this would be Red Hat specific, and I'm not sure how valuable it is.  Any opinions?

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
