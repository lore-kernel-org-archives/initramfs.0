From: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/2] (dracut) hwdb needed in early boot for some keyboards
Date: Tue, 12 Nov 2013 10:38:58 +0100
Message-ID: <1384249140-20683-1-git-send-email-colin@mageia.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>

Hi,

In this bug report https://bugs.mageia.org/show_bug.cgi?id=11645 a user is
unable to enter their encrypted root password via a wireless keyboard
connected with a Logitech, Inc. Unifying Receiver.

This information has moved from a 95-keymap.rules in the olden days to the
hwdb infrastructure (I think the 95-keymap.rules was upstream and not
something we did downstream)

In order to get this working I have to include the hwdb.bin generated from
the 20-usb-vendor-model.hwdb file.

The attached patch series adds this infrastructure to dracut, but it has the
side effect of adding 1.5Mb to the initrd. The pre-processed hwdb file itself
is around 1Mb. I suspect there is a lot of unneeded info in this file, so
perhaps it can be split out into separate files and only include keyboard
related bits in one of them?

There may also be other hwdb files needed for keyboards so please advise if
others should be added by default to dracut (60-keyboard.hwdb seems a likely
candidate)

If anyone has any other suggestions and also any idea how to make the hwdb.bin
file any smaller for the initrd that would be great too.

Cheers

Col

Colin Guthrie (2):
  Provide infrastructure to include udev hwdb files.
  Include support for Logitec, Inc. Unifying Reveiver keyboard

 dracut-functions.sh                    | 29 +++++++++++++++++++++++++++++
 dracut.sh                              |  3 +++
 modules.d/95udev-rules/module-setup.sh |  3 +++
 3 files changed, 35 insertions(+)

-- 
1.8.4.2
