From: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 2/3] raid: external and internal metadata support
Date: Fri, 6 Feb 2009 13:21:18 -0500
Message-ID: <20090206182118.GA4413@nostromo.devel.redhat.com>
References: <20090206164019.GD552@redhat.com> <A9DE54D0CD747C4CB06DCE5B6FA2246F4B496AFA@irsmsx504.ger.corp.intel.com> <20090206165601.GF11144@nostromo.devel.redhat.com> <e9c3a7c20902060927j2b900940kd851573469110135@mail.gmail.com> <20090206173814.GA3541@nostromo.devel.redhat.com> <e9c3a7c20902061012w15a31e7br6ce2074b7b9db555@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e9c3a7c20902061012w15a31e7br6ce2074b7b9db555-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Danecki, Jacek" <jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "neilb-l3A5Bk7waGM@public.gmane.org" <neilb-l3A5Bk7waGM@public.gmane.org>

Dan Williams (dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org) said: 
> > - kernel tells userspace "hey, i unmounted this"
> > (userspace freaks out because the filesystem the daemon is running on
> >  just went away)
> mdmon does not know or care if the *filesystem* is read-only.  It is
> reading and writing /proc, /sys, and the raw disk devices.

Your daemon has to be running from somewhere. That tends to be
reduced to the initramfs that you've already deleted and switchrooted
away from (in which case, good luck on upgrades of your userspace tools -
you're stuck with the version in the initramfs you booted from, even
if your later userspace tools end up using some later protocol).
You can't run it from the rootfs, because that's a chicken/egg
scenario (or you'll switch to it, and then be unable to mark it
clean, because you can't mark the array r/o, because the filesystem
is r/w, which you can't undo because the daemon is running on
it...)

Long-lived daemons running from the initramfs aren't really good.
We don't run udev that way.

> > - userspace frobs bit in superblock to say 'This array is CLEAN!'
> ...not in this scenario no.

Then when is the clean bit set?

> > So, why isn't the ext* journal or filesystem unclean flag
> > handled via a userspace file monitoring daemon, then?
>
> I'm not trying to be obtuse, but because it isn't.  Put another way,
> consider what extra tools the initramfs would need if we wanted to
> support an ntfs-3g rootfs.

You're asking for *the exact same thing*... just RAID specific.

Bill
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
