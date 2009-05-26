From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: modules.d/40nfsroot/install questions
Date: Tue, 26 May 2009 14:44:57 -0400
Message-ID: <4A1C38A9.80405@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

bash-4.0# ./dracut -l -f /boot/initrd-2.6.29.4-162.fc11.i586.img 
2.6.29.4-162.fc11.i586
E: Failed to install strace

# XXX debug stuff
dracut_install rpcinfo ping strace dmesg nc free df

So I realize this is only temporary, but it is preventing it from 
working.  Is there a long-term plan to make these debug stuff non-fatal?

Also why is nc included in this list?  Nothing appears to use it in the 
initramfs.

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
