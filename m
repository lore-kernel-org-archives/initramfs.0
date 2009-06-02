From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: crypt lvm broke?
Date: Tue, 02 Jun 2009 00:31:13 -0400
Message-ID: <4A24AB11.2020702@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Somewhere between 4eba843ddeda59d01a074329e28d423d119b8336 and 
e26cb36fcaa9c0e8278d06e806b725ae00e428ad it seems something broke.

/dev/sda1 ext3 /boot
/dev/sda2 encrypted LVM pv which contains:
	/dev/mapper/vg0-rootfs
	/dev/mapper/vg0-swap

At 4eba843ddeda59d01a074329e28d423d119b8336 it seems to successfully 
unlock the encrypted device, then mount my rootfs lv.

e26cb36fcaa9c0e8278d06e806b725ae00e428ad through 
d0c7d42b3e63c0f62b517b1a5e6c2e58b6b93d2d seem to exhibit the following 
behavior:

* Most of the time: Unlock encryption, mount fails with apparent syntax 
errors rapidly in a loop many times, eventually falling to emergency 
shell.  At this point manually mounting /dev/mapper/vg0-rootfs to 
/sysroot then "exit" will boot.
* Sometimes: Fails to ask crypt password, mount fails with apparent 
syntax errors rapid in a loop, eventually falling to emergency shell. 
dm-crypt module is never loaded.

Any idea what could be going on?

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
