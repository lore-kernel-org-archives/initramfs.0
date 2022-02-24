From: Scott Moser <smoser-tZfQ4l0FZIvk1uMJSBkQmQ@public.gmane.org>
Subject: Exit non-zero on error / how to detect failure?
Date: Thu, 24 Feb 2022 12:57:35 -0500
Message-ID: <CAKxE60w22VmhWMrfN2y=MTEH+EniWn02R6a3+ynE6vPK5GjyBA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brickies.net;
        s=dreamhost; t=1645725466;
        bh=HaAA9qcUSbH45dSi2RZtCXYeWc6qnoEs/1L5Qm3331A=;
        h=From:Date:Subject:To:Content-Type;
        b=MIH7QSH8vGdZNsI5FEW+EH0tg2m74kS8LEByd+QP11Jp0v1Y5AU2D3Yz5JuSHaE5R
         pxG2GdAdYRaKXlmBaJfrderrxXf0L/RM24zdsZbuAM5R8eH/dZOM9Sh7X4lRaQgtil
         zvpSHT7eFkYhHcfVc/F9R9V008DaJoCn++WBPdCg=
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
