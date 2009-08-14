From: Harald Hoyer <harald@redhat.com>
Subject: [ANNOUNCEMENT] dracut-0.9
Date: Fri, 14 Aug 2009 18:10:37 +0200
Message-ID: <4A858C7D.9070209@redhat.com>
Reply-To: Development discussions related to Fedora
	<fedora-devel-list@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <fedora-devel-list-bounces@redhat.com>
List-Id: <initramfs.vger.kernel.org>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/fedora-devel-list>, 
	<mailto:fedora-devel-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/fedora-devel-list>
List-Post: <mailto:fedora-devel-list@redhat.com>
List-Help: <mailto:fedora-devel-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/fedora-devel-list>,
	<mailto:fedora-devel-list-request@redhat.com?subject=subscribe>
Sender: fedora-devel-list-bounces@redhat.com
Errors-To: fedora-devel-list-bounces@redhat.com
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "initramfs@vger.kernel.org" <initramfs@vger.kernel.org>, Development discussions related to Fedora Core <fedora-devel-list@redhat.com>

dracut-0.9
==========
- let plymouth attach to the terminal (nice text output now)
- new kernel command line parameter "rdinfo" show dracut output, even when
   "quiet" is specified
- rd_LUKS_UUID is now handled correctly
- dracut-gencmdline: rd_LUKS_UUID and rd_MD_UUID is now correctly generated
- now generates initrd-generic with around 15MB
- smaller bugfixes

dracut-0.8
==========
- iSCSI with username and password
- support for live images (dmsquashed live images)
- iscsi_firmware fixes
- smaller images
- bugfixes

dracut-0.7
==========
- dracut:     strip binaries in initramfs

            --strip
                   strip binaries in the initramfs (default)

            --nostrip
                   do not strip binaries in the initramfs
- dracut-catimages

     Usage: ./dracut-catimages [OPTION]... <initramfs> <base image>
     [<image>...]
     Creates initial ramdisk image by concatenating several images from the
     command
     line and /boot/dracut/

       -f, --force           Overwrite existing initramfs file.
       -i, --imagedir        Directory with additional images to add
                             (default: /boot/dracut/)
       -o, --overlaydir      Overlay directory, which contains files that
                             will be used to create an additional image
       --nooverlay           Do not use the overlay directory
       --noimagedir          Do not use the additional image directory
       -h, --help            This message
       --debug               Output debug information of the build process
       -v, --verbose         Verbose output during the build process

- s390 dasd support

dracut-0.6
==========
- dracut: add --kernel-only and --no-kernel arguments

            --kernel-only
                   only install kernel drivers and firmware files

            --no-kernel
                   do not install kernel drivers and firmware files

     All kernel module related install commands moved from "install"
     to "installkernel".

     For "--kernel-only" all installkernel scripts of the specified
     modules are used, regardless of any checks, so that all modules
     which might be needed by any dracut generic image are in.

     The basic idea is to create two images. One image with the kernel
     modules and one without. So if the kernel changes, you only have
     to replace one image.

     Grub and the kernel can handle multiple images, so grub entry can
     look like this:

     title Fedora (2.6.29.5-191.fc11.i586)
             root (hd0,0)
             kernel /vmlinuz-2.6.29.5-191.fc11.i586 ro rhgb quiet
             initrd /initrd-20090722.img 
/initrd-kernel-2.6.29.5-191.fc11.i586.img /initrd-config.img

     initrd-20090722.img
       the image provided by the initrd rpm
       one old backup version is kept like with the kernel

     initrd-kernel-2.6.29.5-191.fc11.i586.img
       the image provided by the kernel rpm

     initrd-config.img
       optional image with local configuration files

- dracut: add --kmoddir directory, where to look for kernel modules

            -k, --kmoddir [DIR]
                   specify the directory, where to look for kernel modules


-- 
fedora-devel-list mailing list
fedora-devel-list@redhat.com
https://www.redhat.com/mailman/listinfo/fedora-devel-list
