From: "Gerd v. Egidy" <lists-6VzpN07DMvo@public.gmane.org>
Subject: Re: understanding mdraid initialization logic
Date: Tue, 15 Feb 2011 14:34:14 +0100
Message-ID: <201102151434.14671.lists@egidy.de>
References: <201102151243.23744.lists@egidy.de> <AANLkTinpHgBb3EJaXxj+-tznm9S=6asfTmePgDF-c8DL@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTinpHgBb3EJaXxj+-tznm9S=6asfTmePgDF-c8DL-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Andrey,

> > What is the reason for deactivating the mds? Why is this handled
> > differently when an mdadm.conf is present?
> 
> If mdadm.conf is not present, it is generic image. In this case you
> can't be sure that all arrays actually belong to and will be activated
> by booting system. So they are stopped to avoid confusion.

Belong to what? The linux instance currently running on this system?

I don't see any more harm in keeping active mdraids of other linux instances 
than activating them for a short time during boot.

> > I need an dracut image which is portable across a lot of machines so I
> > can't include an mdadm.conf. But when the real system starts after
> > dracut is done, all mds except the root one are gone and can't be
> > mounted through fstab. I use filesystem labels in fstab, so the md
> > numbers are irrelevant.
> 
> Well, usually system is expected to boot without initrd as well,

I'd say today you usually don't have the kernel modules needed to mount the 
root statically built in your kernel. So a system won't boot without initrd.

> so it
> should be capable of activating those resources itself. I wonder what
> distro are you using?

I'm using Fedora. But I use rd_NO_MDADMCONF to make sure that the dracut image 
can be used on multiple systems.

Usually the Fedora dracut includes mdadm.conf and so it does not need to 
initialize other mds.

Kind regards,

Gerd

-- 
Address (better: trap) for people I really don't want to get mail from:
jonas-K4Lox0BdAqn6SQ/niu2adgC/G2K4zDHf@public.gmane.org
