From: Dan =?ISO-8859-1?Q?Hor=E1k?= <dan-mBPqX7VnFd4@public.gmane.org>
Subject: control what kernel modules get loaded into ramdisk
Date: Mon, 02 Nov 2009 18:34:27 +0100
Message-ID: <1257183267.3755.286.camel@eagle.danny.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hello,

I started to use dracut for preparing generic ramdisk for Fedora/ARM.
The issue with ramdisks on ARM is that they are usually limited in size
because they are stored in the internal flash memories whose capacity
can be 8 or 16 MB (for kernel, ramdisk and other stuff) in the
commercial devices (like NAS from QNAP). So I used the
"omit_dracutmodules" option in the config file to drop stuff like i18n,
plymouth etc. It works, the created ramdisk is usable, but what remains
quite large are the kernel modules for all filesystems. The ability to
limit the list of drivers for block devices would be also nice. Is there
a way to control what kernel modules get loaded into the ramdisk, like
some black- or whitelist?


Thanks

Dan

