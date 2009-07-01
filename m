From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: RFC: writing kernel cmdline options to grub.conf for dracut
Date: Wed, 01 Jul 2009 13:10:59 +0200
Message-ID: <4A4B4443.50503@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Discussion of Development and Customization of the Red Hat Linux Installer <anaconda-devel-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

This morning I've been talking to Harald Hoyer about what sort
of commandline options dracut will be needing to find the /
filesystem beside root=UUID=1234567890 .

In most cases (normal disks, dmraid, mdraid, lvm, dmcrypt)
root=UUID=1234567890 should suffice.

However in certain cases for example dracut will need additional
info to find the disks.

We've come to the following plan for iscsi targets:
1) Extend the dhcp_root dhcp variable iscsi syntax to
    be able include a username password, so:
    iscsi:192.168.50.2::::iqn.2009-06.dracut:target66
    Can become:
    iscsi:user:pass-Q0ErXNX1RuYrv4yRHWfJZg@public.gmane.org::::iqn.2009-06.dracut:target66
    Or:
    iscsi:user:pass:reverse_user:reverse_pass-Q0ErXNX1RuYrv4yRHWfJZg@public.gmane.org::::iqn.2009-06.dracut:target66

2) Pass root-path=iscsi:... on the kernel cmdline, for each needed iscsi target, so if
    necessary this will be passed multiple times, dracut will be modified to be able
    handle multiple root-path arguments being passed in

3) chmod /proc/cmdline 400, so that it cannot be read by ordinary users, plugging
    the passwork leak problem

Now the remaining question is how to implement the adding of the needed
cmdline options to grub.conf.

For the iscsi case (and atleast fcoe will be similar) I see the following 2 options,
both of which are feasible:
1) Add code to iscsi.py to get the needed cmdline options

2) Add a dracutCmdlineOptions property to all Device classes, which will return
    the needed options (if any) to make the device in question available inside
    dracut.

One of the issues here is that onlining an iscsi target, may get us multiple disks
as the target may have multiple LUN's. If more then one LUN of the same target
is needed we might end up with having the same root-path=iscsi:... option twice on
the cmdline, filtering this will be is easy though so this is not really an issue.

Looking at this from the iscsi pov, doing this from iscsi.py is easier, as
that already has a list of targets instead of a list of disks (so LUN's) as the
rest of the storage code has. Looking at this from the pov of the rest of
the code it might be cleaner in the long run to make this a device property though.

So I'm not sure what to do, advice is / ideas are very welcome ?

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
