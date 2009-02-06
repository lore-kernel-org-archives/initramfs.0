From: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 2/3] raid: external and internal metadata support
Date: Fri, 6 Feb 2009 15:08:18 -0500
Message-ID: <20090206200818.GC6150@nostromo.devel.redhat.com>
References: <20090206164019.GD552@redhat.com> <A9DE54D0CD747C4CB06DCE5B6FA2246F4B496AFA@irsmsx504.ger.corp.intel.com> <20090206165601.GF11144@nostromo.devel.redhat.com> <e9c3a7c20902060927j2b900940kd851573469110135@mail.gmail.com> <20090206173814.GA3541@nostromo.devel.redhat.com> <e9c3a7c20902061012w15a31e7br6ce2074b7b9db555@mail.gmail.com> <20090206182118.GA4413@nostromo.devel.redhat.com> <e9c3a7c20902061119i2120cc5fpda0a5cdc3aedc17b@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e9c3a7c20902061119i2120cc5fpda0a5cdc3aedc17b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Danecki, Jacek" <jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "neilb-l3A5Bk7waGM@public.gmane.org" <neilb-l3A5Bk7waGM@public.gmane.org>

Dan Williams (dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org) said: 
> Actually no, your not necessarily stuck with the mdmon from boot.  In
> a pinch you could "mdmon /proc/mdstat /".

Not really.

You state:

> One might say "just set the dirty bit, terminate, and wait for the
> mdmon in the rootfs to take over".  The problem is that a disk could
> fail in this window, and this event needs to be handled before the
> kernel does anything else to the array.
...
> The clean bit can be set as soon as the parity data is in sync with
> the data on the other drives.  We typically wait for some period of
> write-inactivity to avoid needlessly touching the metadata after every
> write.

You shut down the machine. After a while, you get to the point where
you're getting ready to unmount the filesystem. Since mdmon's running
on it (if you started it post boot), you have to kill it. After that
point, there are going to be writes (a final sync, if nothing else,
when you unmount the filesystem.) And you won't be able to set any
RAID metadata flags then, as the daemon won't be running. So, doing
a later run of "mdmon /proc/mdstat" doesn't fully protect you.

Bill
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
