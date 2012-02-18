From: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Subject: Chicken+Egg: Using udevadm to detect LVM+RAID fails.
Date: Sat, 18 Feb 2012 11:44:28 +0000
Message-ID: <jho2us$1cl$1@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

We've been using dracut 014 for a while and are generally happy (as you
know), but I've run into problems with the latest releases.

I like the idea of only assembling those raids that are absolutely
needed for boot. Ditto for activating only those LVM VGs/LVs that are
needed.

However I have a bit of a problem with the techniques used to work out
what the necessary UUIDs are when dracut is run.

At present we use mkinitrd. As you likely know, this does not run udev
during early boot and thus the udev metadata database lacks certain bits
of essential information (this is actually what motivated us to move to
dracut in the first place - systemd being fully hotplug requires this
metadata for a proper boot - it doesn't just probe and try!).

The problem I have comes in when a user upgrades a previous distro
(mkinitrd) to a new one (dracut). If they do an in-place update (i.e.
not booting to an install media - just running urpmi --auto-update from
a booted system - I've used this method of upgrading my stable boxes for
years), then the metadata dracut expects is simply not there in udev.

So I think I'll have to revert to the older methods of parsing /sys tree
to find slaves etc. and looking ad mdadm and vgdisplay/lvdisplay outputs
to work out the UUIDs needed.

That said I do not really want to maintain this as a distro patch, so I
wanted to check what the upstream opinion is on doing things the "old
fashioned way" (although of course allowing for the various mount points
now supported in dracut >= 015 - not just /)?

When you initramfs is hosed, it would be nice to be able to rebuild it
from a very minimal environment, so I think not relying 100% on udevadm
here is a good thing generally anyway, but others may disagree.

So what are the thoughts here? Is everyone happy with udevadm info as
things stand? Will I just have to do distro patches here to deal with
the upgrade problem?




FWIW, I'm also having a lot of problems with users who have booted with
previous versions of dracut and still did not get the mdraid module
included... so I think the current code in dracut 016 is still somewhat
buggy with regards to raid detection...

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited http://www.tribalogic.net/
Open Source:
  Mageia Contributor http://www.mageia.org/
  PulseAudio Hacker http://www.pulseaudio.org/
  Trac Hacker http://trac.edgewall.org/
