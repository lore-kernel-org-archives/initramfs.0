From: "Gerd v. Egidy" <lists-6VzpN07DMvo@public.gmane.org>
Subject: understanding mdraid initialization logic
Date: Tue, 15 Feb 2011 12:43:23 +0100
Message-ID: <201102151243.23744.lists@egidy.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

I'm trying to understand what goals dracut wants to reach regarding mdraids - 
what should the status of the mdraids be when dracut is finished?

Currently I see that when dracut includes an mdadm.conf, all these mds will 
stay active when dracut ends. When dracut does not use/include an mdadm.conf, 
the mds will be deactivated again at the end of dracut unless they are needed 
for the root filesystem.

This logic is in modules.d/90mdraid/parse-md.sh, it is done by conditionally 
deleting the mdraid-cleanup.sh.

What is the reason for deactivating the mds? Why is this handled differently 
when an mdadm.conf is present?

I need an dracut image which is portable across a lot of machines so I can't 
include an mdadm.conf. But when the real system starts after dracut is done, 
all mds except the root one are gone and can't be mounted through fstab. I use 
filesystem labels in fstab, so the md numbers are irrelevant.

Kind regards,

Gerd

-- 
Address (better: trap) for people I really don't want to get mail from:
jonas-K4Lox0BdAqn6SQ/niu2adgC/G2K4zDHf@public.gmane.org
