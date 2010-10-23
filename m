From: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH] 90crypt: keys on external devices support
Date: Sat, 23 Oct 2010 16:13:39 +0100
Message-ID: <4CC2FBA3.8050205@googlemail.com>
References: <4CBDA328.40401@googlemail.com> <1287497223-sup-3606@etiriah> <4CBDAC3D.7050906@googlemail.com> <1287580112-sup-97@etiriah> <4CBEF768.90908@googlemail.com> <1287583979-sup-416@etiriah> <4CBF0133.2070709@googlemail.com> <1287587924-sup-2572@etiriah> <4CC17A87.7050804@googlemail.com> <1287766357-sup-2600@etiriah>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=VmR7Ob7Cqo3/Wc+lQvYIEykMU6ftKMnHVXzoxyrCaV0=;
        b=evSi5HJH1FAxW+uaWlVpGCUeYKRpNdSFX+PXfm7RGzGxVi794wrS4/lKVywca7Ejqq
         p2Bd8t5eLo90OTZO+dKVsBmO4l7z6nHqbZrJKu0/raXfn7dc3G6DOTRYbslumvUPebzJ
         /JUASrO8+oH8my2t+UUtbCV8aO750Ys4baQo4=
In-Reply-To: <1287766357-sup-2600@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


> Switch to git version.  Don't be afraid.  It's quite stable. :-)
>   
I did, thank you. Compiled it as a package and found a bug in the 
dracut.spec file - the following 2 lines should be added, otherwise the 
rpm build fails:

+%{_datadir}/dracut/modules.d/95fstab-sys
+%{_datadir}/dracut/modules.d/96insmodpost

Also, building the --host initrd image was an unmitigated disaster of 
epic proportions!

It does not like hibernation at all - after I used hibernate and then 
switched the PC back on even though the 'restore' worked I've completely 
lost all my usb connections (mouse, keyboard and an extended hard disk) 
and upon reboot the kernel crashed and then as a result of that crash I 
had to repair the root (/) partition and restore a vital lib file, 
which, for some reason, was damaged and Linux won't boot without it (the 
entire system just died!).

Building the 'standard' dracut also has some quirks and also doesn't 
like hibernation, though the system 'only' crashed twice (out of 7 
tests). Upon restart after hibernation, with the standard initrd (from 
fedora, not dracut) I normally get the system restoring itself straight 
away (bypassing grub!), which is the right way to do.

With the dracut-built initramfs that is no longer the case - I am seeing 
the grub menu and I have the usual choice of my bootup options, which is 
a VERY DANGEROUS thing as if I forget that I've hibernated a Linux 
system and boot another (which happens to use the same swap space) when 
I later on attempt to restart the old (previously hibernated) system 
there will be an almighty crash which will most definitely result in a 
corruption of my entire system.


> Maybe there's already such simplified tool?
>   
That is the ONLY alternative, sadly! I tried to see if I could fit in 
the various binaries without installing a large group of dependencies, 
but I was frustrated by failure!

The pcscd daemon (which is essential for reading token data) depends on 
both HAL and D-Bus running (at least that is the case with my FC13 
system). That means I have to install an additional set of about 23 
packages in order to make this work - a futile exercise!

So, in conclusion - until there is either a stripped-down version of 
pkcs11-tool or another similar program which does not require large 
number of dependencies to run and read a token data from a smartcard, 
installing such a module is nigh impossible!
