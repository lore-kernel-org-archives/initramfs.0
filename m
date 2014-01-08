From: "Manuel Amador (Rudd-O)" <rudd-o-U/0UrcBcm+/QT0dZR+AlfA@public.gmane.org>
Subject: Help with my ZFS module: waiting for certain known devices
Date: Wed, 08 Jan 2014 08:13:10 -0800
Message-ID: <1389197590.13195.11.camel@julia.dragonfear>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello!

I'm working on the dracut module for ZFS, and I've discovered that I'm
at an impasse.  ZFS works well without LUKS encryption, but if I use
LUKS encryption, that makes ZFS invisible at boot time, because dracut
just won't wait until the disks are decrypted before calling my mount
script.

In general, I want to know what the mechanism is to wait for pool
backing devices.  That is to say, if the root pool R containing the root
file system M is backed by device A and C, and A doesn't appear until 20
seconds after boot, and C doesn't appear until the user has typed the
LUKS decryption password and successfullly decrypted the device B (which
I know has appeared when I see the password prompt) and therefore
exposing newly-unencrypted C to the OS, then the pool should not be
imported until those two events have succeeded.

How do I go about doing that?  I tried using unit files in F19, it sorta
worked, but of course it broke completely in F20.  I suspect this has to
do with the initqueue thing, whatever that is, but I really have no
idea, and the only document I found is littered with TODOs of the very
things that I went to the document for.

Help, please!  I cannot boot my main computer without this!
