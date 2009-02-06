From: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 2/3] raid: external and internal metadata support
Date: Fri, 6 Feb 2009 15:03:30 -0500
Message-ID: <20090206200330.GB6150@nostromo.devel.redhat.com>
References: <20090206164019.GD552@redhat.com> <A9DE54D0CD747C4CB06DCE5B6FA2246F4B496AFA@irsmsx504.ger.corp.intel.com> <20090206165601.GF11144@nostromo.devel.redhat.com> <e9c3a7c20902060927j2b900940kd851573469110135@mail.gmail.com> <20090206173814.GA3541@nostromo.devel.redhat.com> <498C7AD8.6080105@intel.com> <2c0cae741a7229789cd777d93180072a.squirrel@neil.brown.name>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2c0cae741a7229789cd777d93180072a.squirrel-eq65iwfR9nKIECXXMXunQA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Cc: Jacek Danecki <Jacek.Danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Williams, Dan J" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

NeilBrown (neilb-l3A5Bk7waGM@public.gmane.org) said: 
> There is more to this than the 'unclean' flag.
> The really important task for mdmon (which hopefully it never has
> to perform...) is to record device failures (which is what RAID is
> really all about).
> 
> If a device fails while trying to write to it, we cannot allow that
> write to complete until the other devices have had that device failure
> recorded on them.  Otherwise, following an unclean shutdown we might trust
> the data that is on that drive, which is now out-of-date.

OK, so:

1) kernel sends write request. If error....
2) <some error occurs>
3) kernel sends error to userspace
4) mdmon wakes up
5) mdmon decides where to record this
6) mdmon writes to super blocks
7) go to step one, hope you don't hit step 2 this time

This now means that reliable suspend and resume is completely
impossible on RAID devices, just as it is on FUSE. You can't have
waking up userspace be part of your write and sync process -
you've just deadlocked at step 3/4.

Unless I've missed something here?

Bill
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
