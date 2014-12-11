From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [RESEND] SUSE patches which should show up mainline
Date: Thu, 11 Dec 2014 15:45:51 +0100
Message-ID: <1418309193-11208-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org

Hi,

Changes to last post:
- Removed unnecessary IFS variable restoring
- Removed inst_multiple sed and host from nfs module
- Removed warpclock patch/module (according Chao Wang this is done by systemd
  by copying /etc/{localtime,adjtime} to initramfs)

One cleanup for the future I have in mind:
As udev rules are often moved around in timeline (just the number changes),
it would be nice if systemd enforces that udev rules must be unique.
That would mean this is forbidden:
01-ruleXXX
05-ruleXXX
Then dracut could implement:
inst_rule ruleXXX
and it would work for all distros and versions.
But this needs clarification with systemd people first.

Would be great to see as many of these applied already.
E.g. mkinitrd-suse: Update to sles12 SUSE state
should not be a big deal to apply.

Thanks a lot,

       Thomas
