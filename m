From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: dracut and CVE-2016-4484
Date: Tue, 15 Nov 2016 18:49:47 +0100
Message-ID: <bd06f657-60bc-6d62-1bb6-c0f146e7a6d5@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

People who want to secure their dracut system have to:

- add a BIOS password
- add a grub password
- add “rd.shell=0” to the kernel command line

Anaconda (the Fedora/RHEL installer) does add “rd.shell=0” to the kernel
command line automatically, if you setup the bootloader with a password at
installation time.

On the other hand, you can still take the hard disk to another computer and be
root ;-)﻿
