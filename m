From: jaivuk <jaivuk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Unable to boot Fedora 15 Live iso image from grub2 (iso-scan/filename
 kernel parameter)
Date: Thu, 21 Jul 2011 09:53:22 +0100
Message-ID: <CAC-ivu5wS+xGoekc_jjs72BC4=Dz+k3umnAdSHVu_vjGDva=rQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=UMxcd7ChXMcQrsdaLxCdRaB6ClHNDwl96HQZa5B31nI=;
        b=do0G4XKHw0yV27OzpDdhXaZoKK8lbNz07KRKfn0jHDfcLGB4ZVuFUXKBCwZlSOD1rS
         044aeuPpbPMspbhnJUVrS8ZCLtFkQ1NFu4xm73NcbDQqXOGzvqjAEaInNCIV9JSsMt1F
         MpmPl8SBbYNpgf4toyEdrzeGKQPhs0JTtRMeM=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi guys,

I tried to boot Fedora live ISO in form of ISO image from USB
partition (FAT32) where I have grub2 installed but still no luck.

I opened new ticket for this issue:
https://bugzilla.redhat.com/show_bug.cgi?id=723801

I ended up in dracut shell and I tried to mount root manually - I was
successful with that but I still cannot boot:

mkdir -p /liveiso
mount /dev/disk/by-uuid/1234-ABCD /root
losetup -f --show /root/Fedora-15-i686-Live-XFCE.iso
#displayed: /dev/loop0
mount -t auto -o -ro /dev/loop0 /liveiso
#image is mounted to /liveiso
exit
#Now I get the same error message - No root device ... found

Do you think I'm missing some additional commands?

Thank you,

Jaiv
