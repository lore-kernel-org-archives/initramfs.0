From: "NeilBrown" <neilb-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [RFC PATCH 2/3] raid: external and internal metadata support
Date: Sat, 7 Feb 2009 06:34:38 +1100 (EST)
Message-ID: <2c0cae741a7229789cd777d93180072a.squirrel@neil.brown.name>
References: <20090206164019.GD552@redhat.com>
    <A9DE54D0CD747C4CB06DCE5B6FA2246F4B496AFA@irsmsx504.ger.corp.intel.com>
    <20090206165601.GF11144@nostromo.devel.redhat.com>
    <e9c3a7c20902060927j2b900940kd851573469110135@mail.gmail.com>
    <20090206173814.GA3541@nostromo.devel.redhat.com>
    <498C7AD8.6080105@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <498C7AD8.6080105-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jacek Danecki <Jacek.Danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Williams, Dan J" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Sat, February 7, 2009 5:00 am, Jacek Danecki wrote:
> Bill Nottingham wrote:
>>
>> So, why isn't the ext* journal or filesystem unclean flag
>> handled via a userspace file monitoring daemon, then?
>
> Dan, Neil
>
> Are any plans about rewrite mdmon in kernel-space?
>

Definitely not.

There is more to this than the 'unclean' flag.
The really important task for mdmon (which hopefully it never has
to perform...) is to record device failures (which is what RAID is
really all about).

If a device fails while trying to write to it, we cannot allow that
write to complete until the other devices have had that device failure
recorded on them.  Otherwise, following an unclean shutdown we might trust
the data that is on that drive, which is now out-of-date.

The task of mdmon is to discover when there have been write error,
record the device failure in the metadata, then allow the write
to complete.

It has a number of other tasks as well, but that is the important
one which means that it must always be running when the array is
writable.

NeilBrown

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
