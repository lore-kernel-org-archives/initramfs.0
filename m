From: Ian Pilcher <arequipeno-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Default initramfs location
Date: Tue, 14 Jul 2020 13:35:03 -0500
Message-ID: <rektsp$17oq$1@ciao.gmane.io>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I've recently migrated one of my systems from GRUB to systemd-boot.  As
a result my initramfs is no longer at /boot/initramfs-$(uname -r).img.

Instead, it is at /efi/$(cat /etc/machine-id)/$(uname -r)/initrd.

dracut is still using the old location by default.  (For example, if I
rebuild the initramfs with 'dracut -f', dracut writes the new file at
it's "traditional" location under /boot.)

Is there a configuration option that I can set to make dracut use the
systemd-boot location (or some other way to do it)?

Thanks!

-- 
========================================================================
                  In Soviet Russia, Google searches you!
========================================================================

