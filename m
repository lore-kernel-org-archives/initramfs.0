From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: qemu -hda /dev/null
Date: Thu, 18 Jun 2009 15:09:00 -0400
Message-ID: <4A3A90CC.7070309@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

     # Need this so kvm-qemu will boot (needs non-/dev/zero local disk)
     if ! dd if=/dev/zero of=client.img bs=1M count=1; then
         echo "Unable to make client sda image" 1>&2
         return 1
     fi

     $testdir/run-qemu -hda client.img -m 128M -nographic \

Technically this isn't true.  You can use -hda /dev/null and it will 
boot just fine.  But I guess we need that disk as a means to pass the 
nfs-OK messages?

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
