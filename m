From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: dracut: Make mkinintrd-dracut.sh SUSE mkinitrd compatible
Date: Fri, 27 Sep 2013 20:18:54 +0200
Message-ID: <1380305940-64410-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

these patches implement most important SuSE specific /sbin/mkinitrd
paramters:
  <none> : Before gives a "usage" error -> now scans /boot for kernels
           and builds corresponding inirtrds for them
  -i -k  : Pass a list of kernels and initrd targets
           (not sure it was worth the hassle to be able to pass)
  -b     : Boot directory to search for kernel images
  -d     : Change root file system. Not tested whether dracut's behavior
           matches exactly what our mkinitrd does.

If any of these parameters (including <none>) would have been called before,
mkinitrd-dracut.sh would have bailed out with a "usage error" and an error
code.
Or the other way around: Any valid mkinitrd-dracut.sh not resulting in an
error, should work exactly the same way it did before.

Therefore I hope these can get in if the code is ok.

Thanks,

    Thomas

[PATCH 1/6] mkinitrd-dracut.sh: Introduce -i -k parameters
[PATCH 2/6] mkinitrd-dracut.sh: Enhance param parsing: Allow
[PATCH 3/6] mkinitrd-dracut.sh: Implement --quiet|-q option
[PATCH 4/6] mkinitrd-dracut.sh: Allow mkinitrd call without passing
[PATCH 5/6] mkinitrd-dracut.sh: Also allow -d to specify the root_fs
[PATCH 6/6] mkinitrd-dracut.sh: Build host images for
