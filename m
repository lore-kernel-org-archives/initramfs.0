From: "Karsten Forum" <forum-FsvK1yUvlemJOWFeQooTGSCwEArCW2h5@public.gmane.org>
Subject: How to boot without initrd.img ?
Date: Tue, 1 Jun 2010 13:32:47 +0200
Message-ID: <dcc73894a8d1f0d8d194b5df83ab3921.squirrel@decotrain.homedns.org>
Reply-To: forum-FsvK1yUvlemJOWFeQooTGSCwEArCW2h5@public.gmane.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello together,

i want to place my question here, because i didn't get an answer in "normal" user
forums.

My Problem: I want to copy a complete Linux installation from one PC to other PC's.

In the past i could do that just by booting Knoppix from CD, making an tgz from the
source partition and extract it on the destination partition.
This works fine in Debian with Kernel 2.6.22. After the extract i could boot with
some error messages and timeouts.
Then i updated some config's in /etc and afterwards i could update the initrd.img.

The PC's have the same mainboard and processor, but can differ in the harddisk and
type of Nvidia graphic-card.

Now i am switching to Kubuntu 10.04 with kernel 2.6.32 and i tried the same procedure.
But i get no chance. The boot-process stuck early acessing the harddisk. The main
poblem is that the source PC has a SATA disk and the destination PC an IDE disk.
I tried different tricks to boot (without the initrd.img in grub) or update the
initrd.img on the destination PC, but nothing works.

So my question is how can i boot the system without using the initrd.img ?

It's possible to boot from CD on different hardware, but up to now i don't know how
this is working?

Or maybe somebody knows a better solution for my problem?

Regards
Karsten

