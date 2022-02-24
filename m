From: Scott Moser <ssmoser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Exit non-zero on error / how to detect failure?
Date: Thu, 24 Feb 2022 12:45:33 -0500
Message-ID: <CAKxE60y5gUKDy8KFgv3rwKsFPDMq6xDK7VD26xe3UtqrzG7AcA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=HaAA9qcUSbH45dSi2RZtCXYeWc6qnoEs/1L5Qm3331A=;
        b=URe5mdHeUyEt+hO/XLDkey3ghLKfLAHxfkxm9xL8Wsb2boY0TvI1UhgNKaU5573LZn
         Kcs3ZUoOHdekSMN62gAYRyPDFVFsZEQjJPhTIbx5jwmrLfrr1pXJEltymrWHFVtMSQg5
         MNbAWhDNnao1ppay3o81yyKx/F9fodn1Ayvji15ugvc3arYRwVlrlnMyGhzuCDg6jPfG
         mzXi29zoJZsRAZvIhD/HjKPuZZeP5U8zM+NLFBpXnGF4JMthblgE8RWh9U7lWUVE9sZT
         /KnkKSbM27CSyXG7Gbv+76/gCtjh+lmPRvMIFGEiAk7uVCirSwjmuAHF34YqEoDg4RgB
         MOpA==
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I recently built a initramfs with dracut in debian (051-1), but
it seems this is still a problem on mainline.
I have a config in /etc/dracut/dracut.conf.d that said:

    install_items+="/etc/usermode-helper.conf usermode-helper"

An error elsewhere meant that those items were missing from the filesystem.

dracut exited 0 with emitted messages like:

    dracut-install: ERROR: installing '/etc/usermode-helper.conf'
    dracut-install: ERROR: installing 'usermode-helper'
    dracut: FAILED: /usr/lib/dracut/dracut-install -D <dir> \
        -a -l /etc/usermode-helper.conf usermode-helper

In my usage, this is a FATAL error, and failure to catch it here meant lost
time down the road.  I "solved" it by capturing output and grepping
for "ERROR:" or "FAILED:", but that is less than desirable.

Is there a way to tell dracut to exit non-zero on errors like this?

Scott
