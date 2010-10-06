From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Better error handling
Date: Wed, 06 Oct 2010 13:39:56 +0200
Message-ID: <4CAC600C.7040309@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

While talking to David Zeuthen, he mentioned that our current error handling is 
not very user friendly and I agree.

Presenting the user the message "Boot has failed, sleeping forever." does not 
really help.

Instead of displaying the message, we could:

- turn "rdshell" into "rd.no_shell" and drop to a shell by default.
   Admins with security concerns will lock grub with a password, and can add
   the "rd.no_shell" parameter.

- add simple tools to present the user a list of mountable partitions, assemble 
lvms, md, dmraid and mount network devices.


What do you think?
