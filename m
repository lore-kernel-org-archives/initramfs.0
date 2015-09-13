From: Alex <mysqlstudent-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Can't mount USB within initramfs
Date: Sun, 13 Sep 2015 14:50:44 -0400
Message-ID: <CAB1R3shGMbuAh8HKSFq086VegXo7vLh=f7EH-49wjoBd_p69BQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=HPJQCNfr2YkALZDqB3wJIvA1dzrTsuNjtPGP6IM8djA=;
        b=Nm9k2lACMt1oWN5oqai9NjWKruALahouDRdY/8i6u71V5egE/EyJHcDeNcnuCSu6ea
         t9r6XFlMRvBmW8GaRWrnVg8iZaY181H4hIFgJUYIsc2PdZG4AE5JsubVA5Q3lXC7mIQf
         kOeDX6+rGKOXPoi1wXknjEcVQqXLN5ByUWpMCmqTyqYTqxmmiFAHh6jvni7ml787AsVe
         I6IXePsTSYz7e6TrCtHHBl09yE2lsrvY7p9WOtARoEpCdR1Aj2Y+XZxuUciL+xxm+XV7
         3YVe0uBjJIwQ2cWlpYPSY4/UBLrQih9U0KUIE90XpKYAzNo1JwBBI6NThCUT3iuu4/E5
         CbEw==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

I have a fedora22 system with dracut-041-10 and initramfs created with
it fails at "reached target basic system". I enabled some debugging,
and it appears to just loop, unable to mount a root, until I get a
dracut shell.

It's created an sosreport, but I'm unable to mount a USB stick to copy
it. It displays info about the device when it's inserted, but no
device name is assigned to it. Is this a problem with how the
initramfs was created, a bug, or am I doing something wrong?

The only modules in /usr/lib/modules/drivers are gpu drivers,
i2c/algos, and raid1 and raid456. The system has a RAID1 and a RAID5
partition, but the kernel modules aren't loaded (have to load them
manually), but then no devices are shown in /proc/mdstat there either.

Is filesystem support compiled into the kernel or must that be added
to the initramfs manually?

Thanks,
Alex
