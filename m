From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] fix up console handling
Date: Wed, 14 Mar 2012 11:01:46 -0400
Message-ID: <1331737309-24315-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Howdy, dracuteers.

This patch is an attempt to fix up console handling in dracut (specifically
in emergency_shell).

The main goal is still to avoid the "no job control in this shell" message
(and associated inability to use tab-completion, Ctrl-C, etc.)[1].


Dracut currently has two ways to do this:

1) If the '--ctty' flag is passed to dracut, it will include 'setsid' in
initramfs and try to use /dev/console as the ctty (or a device specified
with rd.ctty=DEV
2) If we don't have 'setsid', and 'openvt' is in the initramfs[2]
(and no console=DEV or rd.openvt=0), it uses openvt to run sh on tty1.


Unfortunately, they're both slightly broken:

1) /dev/console can't be a controlling TTY, so ctty fails unless you pass a
correct 'rd.ctty=DEV' argument.
2) the 'openvt' method doesn't work on anything without VTs - headless
systems, IBM POWER, s390, etc.


Patch 1 adds some ctty-finding code that matches what busybox "cttyhack"
does (and roughly what anaconda "loader" used to do) to find a valid ctty.

Patch 2 makes it so openvt won't be used unless the ctty we found is a VT.

Patch 3 makes --ctty the default behavior. Harald told me on IRC that the
only reason he knew of that it wasn't the default was that it didn't work.
Assuming the first two patches test well (esp. on headless systems etc.) I
think it makes sense to have this be the default. 'setsid' is 9kb on a
x86_64 system (2kb compressed) so I don't think it's a tremendous burden.

Let me know what you think,

-w

[1] For this to work the shell needs to be a session leader and it needs a
controlling tty. We can become session leader with 'setsid', so that's easy.

Setting the ctty can be done with the ctty with the TIOCSCTTY ioctl, but
there's also a shortcut: the first real tty you open will automatically
become your controlling tty. So all we really need to do is find the real
tty (i.e. not /dev/console or /dev/tty0) and open it.

[2] As far as I can tell, this happens by default in Fedora? It's in my
initramfs and I've gotten but reports about it, but I can't figure out how it
actually gets there..
