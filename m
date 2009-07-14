From: Hans de Goede <hdegoede@redhat.com>
Subject: RFC: mdadm and bringing up raid sets from initrd (dracut)
Date: Tue, 14 Jul 2009 12:59:13 +0200
Message-ID: <4A5C6501.3080607@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hotplug-owner@vger.kernel.org>
Sender: linux-hotplug-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs@vger.kernel.org>
Cc: linux-hotplug@vger.kernel.org, "Danecki, Jacek" <jacek.danecki@intel.com>, Harald Hoyer <harald@redhat.com>, Doug Ledford <dledford@redhat.com>

Hi,

As you probably know I'm working on making Fedora 12 use mdraid
instead of dmraid for Intel BIOS-RAID setups.

The installer (anaconda) part is mostly done (needs more testing)
and now I'm looking at implementing support for this in dracut
(the new mkinitrd for Fedora 12).

So I've been testing how this works for both imsm mdraid sets
and native mdraid metadata sets, in both cases using a 2 disk
mirror, so that the set can also be brought up in degraded mode.

Currently the udev rules use incremental assembly like this:
mdadm -I /dev/mdraid-member

There are 2 problems with this:
1) When doing this for native mdraid metadata arrays, if only
    one disk is present the set never gets activated
2) When doing this for imsm metadata arrays, as soon as the
    first disk is incrementally added, the set gets activated
    in degraded mode and stays that way, the second disk
    will get added to the container, but not to the actual
    sets in the container

And these 2 problems have 2 different solutions:
1) An incomplete, but potentially activatable in degraded mode
    set can be activated using mdadm --run /dev/md#
2) One can stop this problem by using:
    mdadm -I --no-degraded /dev/mdraid-member
    instead (this does not change anything for
    native mdraid metadata format sets)
    But if that is done, the sets in the container never get
    activated, this can be fixed by running
    mdadm -I /dev/md# on the container device

So my proposed solution for this is when udev is done scanning
(when the event queue is empty, detected using the same mechanism as
dracut is using for dmraid), do the following:

For each /dev/md#
   run mdadm --export --detail, and get the MD_LEVEL
   if MD_LEVEL == "container":
     mdadm -I /dev/md#
   else
     mdadm --run /dev/md#

This will:
1) Bring up raid sets inside containers (such as imsm raidsets)
2) Bring up incomplete raid sets in degraded mode where possible

I'll post a patch implementing this later today.

Regards,

Hans
