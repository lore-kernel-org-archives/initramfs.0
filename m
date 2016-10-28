From: Dennis Luehring <dl.soluz-hi6Y0CQ0nG0@public.gmane.org>
Subject: PROBLEM: why not panic on initramfs.c/populate_rootfs errors?
Date: Fri, 28 Oct 2016 13:38:27 +0200
Message-ID: <56acd08b-8fab-d238-ac24-fd55844e8d3d@gmx.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

i've already posted this on linux-kernel mailinglist but didn't get any 
response - so i hope this is the right mailing list for such questions

im building initrd/initramfs cpios for serveral qemu (qemu 2.7.x git 
head) platforms and
stumbled over inconsistent rootfs after kernel load
using vanilla kernel 4.8.4(and 4.7.0), bash 4.4, core-utils/linux-utils
build with gcc 6.1 under Ubuntu 16.04.1 x64
but its not qemu or platform related - the behaviour of 
https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/init/initramfs.c?id=refs/tags/v4.8.4
populate_rootfs function is equal to all platforms and makes it harder 
to find problems with initrd/initramfs,cpio,ram

using a big(~380MB) initrd.cpio with not enough ram (1GB) in qemu i get 
this kernel message
"Initramfs unpacking failed: write error"
that sometimes led to missing files in my rootfs (thanks to "Richard 
Henderson"(DEC-Alpha maintainer) who directed me to the kernel log
message - after searching for hours why some executables didn't work 
after kernel load)

using a small(~15MB) initrd.cpio with just a staticaly linked c/c++ based
init for the kernel also with 1GB ram gives me this kernel message:
"Initramfs unpacking failed: junk in compressed archive"

both initrd.cpios are created with cpio (version 2.11)
"find . | cpio -H newc -o initrd.cpio"

why do the kernel not panic if not able to populate the roofs consistently?

related to the panic i've found this commit (from 2009-01-14) that 
allows inconsistent rootfs
https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/init/initramfs.c?id=73310a169aebe257efdd35a763cce1c7658f40c9

is that still a good idea/practise?

to have initramfs recovery seems to  be a rare case and a simple panic 
would help much better in many other
common situations or are the errors comming from unpack_to_rootfs() 
currently not
always errors but sometimes warnings where panic would be the wrong 
action to take?

i don't know if both messages telling me that something bad happend and
i need to fix it first or is the second just a warning?
"Initramfs unpacking failed: write error"
"Initramfs unpacking failed: junk in compressed archive"

i've uploaded my cpios, kernel and start-scripts for my szenario to 
(~72MB): http://www.filedropper.com/initramfstestalpha-linux-gcc-610fail
files:
config - kernel 4.8.4 config for DEC Alpha (default)
big_initrd.cpio - the ~380MB initrd
initrd.cpio - the ~15MB initrd
init.cpp - the staticaly linked c/c++ based init source
start_big_initrd.cpio_1GB.sh - start-script for qemu using big_initrd 
and 1GB of ram
start_big_initrd.cpio_2GB.sh - start-script for qemu using big_initrd 
and 2GB of ram
start_initrd.cpio.sh - start-script for qemu using initrd and 1GB of ram
start_big_initrd.cpio_1GB.kernel.out - kernel output of 
start_big_initrd.cpio_1GB.sh
start_big_initrd.cpio_2GB.kernel.out - kernel output of 
start_big_initrd.cpio_2GB.sh
start_initrd.cpio.kernel.out - kernel output of start_initrd.cpio.sh
System.map - kernel map
clfskernel - kernel 4.8.4 for DEC Alpha

please direct me to the correct mailinglist (or person) that could
answer this questions if im wrong here

thx
