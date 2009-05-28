From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Irrelevant kernel modules
Date: Thu, 28 May 2009 16:12:21 -0400
Message-ID: <4A1EF025.4040102@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

drivers/net/irda/
drivers/net/appletalk/
net/ipv4/netfilter
net/sched/
net/irda/
net/bridge/netfilter/
net/netfilter/
net/phonet
net/dccp/
net/ipv6/netfilter/
net/bluetooth/
net/atm/
net/802/

It seems these (and possibly more) kernel modules are being copied into 
the initrd but are never needed during initrd.  Any ideas of a better 
and more specific way of specifying only network interface drivers?

rm -rf ${initdir}/lib/modules/$kernel/kernel/net/wireless
rm -rf ${initdir}/lib/modules/$kernel/kernel/drivers/net/wireless

In related news, Harald suggested adding this as an ugly hack to get rid 
of wireless drivers.  This immediately after instmods =net didn't work 
for some reason I haven't yet figured out.  It is successfully deleting 
the modules, but something else is copying them back later.  I am hoping 
the $drivers cleanups I just pushed help this situation.

So the other bug involving instmods() firmware handling being broken is 
the reason for wireless .ko modules to be loaded during initrd but 
failing due to missing firmware.  We already agreed on this list earlier 
to exclude wireless in the standard initrd though, so this doesn't 
matter yet.  I guess some SCSI or FC controllers might be more effected 
by the missing firmware.

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
