From: Zack Freeman <zacharyfreeman-g/b1ySJe57IN+BqQ9rBEUg@public.gmane.org>
Subject: Subtle misconfiguration in initramfs after dnf upgrade; boot breaks under some circumstances
Date: Sun, 29 Aug 2021 08:13:28 +0000
Message-ID: <ckX49YX87gc1MbVjSpLp7asHnEU2UwA4FnOqkRdoKBJ0fAZ1lqWb7DQO4brmZYuFN4kwXVJwHnQkAj3mfCgVSunpB2MIe-tE7VOSyZOOD5E=@protonmail.com>
Reply-To: Zack Freeman <zacharyfreeman-g/b1ySJe57IN+BqQ9rBEUg@public.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1630224812;
        bh=uNOLAuXu6uroanwW/bCeUKLvqU6vNcGW4hshlKsB8T8=;
        h=Date:To:From:Reply-To:Subject:From;
        b=fdK4QXNbpdqQvLSpfI5vHQAprng+NzI7JK1WQb+uaM9NPgIYRlo58p+uDawRX+Unz
         spWVPQ58gDdfsRoKzXlu2stF0zBT6uI/LrsnsKxS1ov7yyC90pATDMxalB3P920Bce
         bYDfal8jzALXTsV9pnJ5UZgRXZhqTNFGA26ECTv0=
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

I recently installed a fresh minimal copy of Fedora 34 using Anaconda and t=
his fairly simple Kickstart file (see below). To save you some reading, the=
 Kickstart file creates 3 software RAID1 arrays (/, /boot, and swap) and in=
stalls Fedora 34 on top.

When Anaconda completes, I'm presented with a working system running on top=
 of a bootable software RAID1. So long as I continue to use the initramfs t=
hat was created for me by the installer, I can unplug a drive (thus degradi=
ng the RAID1 array), and continue to still boot the system.

But, as soon as I run dnf upgrade and pull in a new kernel (updating 5.11 t=
o 5.13), the new initramfs that gets generated will lose the above function=
ality (booting off a degraded array). The system will still boot when all R=
AID1 members are present, but as soon as a single member of the RAID1 is lo=
st, I get dropped into a dracut emergency shell and then need to manually t=
urn all the inactive arrays active via a series of mdadm --run /dev/md[X] a=
nd mdadm --readwrite /dev/md[X] commands.

Any idea why Anaconda+Kickstart can create a working initramfs that support=
s booting off of a degraded software RAID1 array, but dracut can't when it'=
s automatically invoked by dnf update?

For additional information see:
Kickstart file:  https://gist.github.com/zacharyfreeman70/ead4c8a9d2fec5875=
3d7c295f39cfc00
GitHub issue: https://github.com/dracutdevs/dracut/issues/1593
Reddit post: https://old.reddit.com/r/Fedora/comments/pdqw3v/initramfs_buil=
t_incorrectly_after_dnf_upgrade/
