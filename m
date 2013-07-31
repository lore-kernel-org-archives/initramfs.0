From: Paul Komkoff <i@stingr.net>
Subject: Very specific initramfs image problem
Date: Thu, 1 Aug 2013 01:37:17 +0400
Message-ID: <20130731213716.GA5723@vuvuzela.stingr.net>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=YQiVbR+fcRIkJa7383FukW+yy9eZIOPlpCMISGPwtL8=;
        b=fjuT4QOAz9SLPKsDApVHRY2P7IzWuKyx6yOnn9yLfMNRJY8xjQ2aovyLpi/sdsAciG
         LLc6fxzQ4F+O2wxKwK0BUJLThNrvRIaHjyBmm2MMMx+SaxgBQdrzxPt/mi1hQgr1STjc
         HzI4MZyF96+SzEtL3HotDwOMKwz14iy4sXDw1aTOR4gLIfgw9Ltwu7nd4PBYA+MT7Ib4
         p2cCo90GTPSOWiuGnNsAu8PS4Bcl+NEekK9krtKh6W4nRiOqY+FZE0+nkIFc/3sji4zM
         Z0rAdlXF0i8XnP0n5JCde3oCtMU5XzE2aQ191CFNfB2CwRaT9HF1xx72PviQfvHhljA1
         FSeQ==
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Good morning.

I'm trying to achieve a very specific thing and I'm wondering if you can point
me in the right direction.

I have a system that sets up dual-boot workstations and makes grub the
bootloader. Now, I need to provide 2 network boot targets: one that will set
grub default to windows, another one to fedora. For that, I have a script that
updates grubenv; now, I need to package it into initramfs.

Before dracut/systemd what I did is just took mkinitrd result, unpacked, added
my script to it, and modified init to run it and then reboot. With dracut I was
hoping to try to reuse it as much as possible, as to run grub2-editenv I need
/boot mounted - means device detection and that's something I have to use
dracut/udev for.

I have the following ideas so far:
- just stick my code somehow into mount triggers, and when root is mounted
  mount /boot, run, and then reboot -f
- stick my code into pre-pivot (mount /boot and edit env etc), then instead of
  initrd-switch-root.target do reboot.target

I was wondering if there are better and/or cleaner ways for doing that (I'd
probably start implementing a module for the second one in the meantime).

Thanks!
--
This message represents the official view of the voices in my head.
