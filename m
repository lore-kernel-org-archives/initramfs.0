From: David Li <w.david.li-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Q: mount initramfs as the final root fs
Date: Wed, 11 Jan 2012 16:54:36 -0800
Message-ID: <CAADET=cG8mdu-Je_MUGyKOP_G9sfU6sR3KHxybFMREjvexrKmg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=KwmKFC2C8ebDMNmmtV9b9O6bq5qTs9dD5oewlblNAh0=;
        b=ZUApbIHwYFypJfZNfLUbZdZO9DJke5x5FdHkVr0Luw5xfEfgpYKLE48lE7YNM63l4T
         NCFfb5K3Ubw708I/MLC4fSnCu5vyFTaFFiT6EOO+zGxiJVbA6Tzm1PG0lLJGWhklmk9D
         gfvmk4fxn1RDH1o76hDtsoQRuJ5OpQVsCpvP8=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Everyone,

I need to let the kernel to mount the initramfs (created by dracut)
as the final root filesystem. No disk and no NFS either!

I tried kernel option root=/dev/ram0 (the initrd way to mount init ram
disk) but dracut didn't recognize this option. What should I use to
accomplish this?

Thanks.

David
