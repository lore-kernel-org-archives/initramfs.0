From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 2/3] raid: external and internal metadata support
Date: Fri, 6 Feb 2009 12:19:50 -0700
Message-ID: <e9c3a7c20902061119i2120cc5fpda0a5cdc3aedc17b@mail.gmail.com>
References: <20090206164019.GD552@redhat.com>
	 <A9DE54D0CD747C4CB06DCE5B6FA2246F4B496AFA@irsmsx504.ger.corp.intel.com>
	 <20090206165601.GF11144@nostromo.devel.redhat.com>
	 <e9c3a7c20902060927j2b900940kd851573469110135@mail.gmail.com>
	 <20090206173814.GA3541@nostromo.devel.redhat.com>
	 <e9c3a7c20902061012w15a31e7br6ce2074b7b9db555@mail.gmail.com>
	 <20090206182118.GA4413@nostromo.devel.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=5n2NkJOAKnSnCfQ0MHT/lXP61e5VYHVDdN5drwE3XCk=;
        b=APyi1EOOlSduBrfqRLATFaunTKqaQQBnTLF1hzG032d+qupMqQrhLC/8h5TsIbxH+f
         lhqVM5k92xSaBcDEv6+PWoSjEi5pjYlf73CATR7mPBNDPdFBsq++dD1V/ium9mrDu/qJ
         zrWFbs9ZHLCmZS+MusMYRFbubxzoSIBuLhpF8=
In-Reply-To: <20090206182118.GA4413-Zdt1ptygihhQcNjhGXsBABcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "Danecki, Jacek" <jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "neilb-l3A5Bk7waGM@public.gmane.org" <neilb-l3A5Bk7waGM@public.gmane.org>

On Fri, Feb 6, 2009 at 11:21 AM, Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Dan Williams (dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org) said:
>> > - kernel tells userspace "hey, i unmounted this"
>> > (userspace freaks out because the filesystem the daemon is running on
>> >  just went away)
>> mdmon does not know or care if the *filesystem* is read-only.  It is
>> reading and writing /proc, /sys, and the raw disk devices.
>
> Your daemon has to be running from somewhere. That tends to be
> reduced to the initramfs that you've already deleted and switchrooted
> away from (in which case, good luck on upgrades of your userspace tools -
> you're stuck with the version in the initramfs you booted from, even
> if your later userspace tools end up using some later protocol).

Actually no, your not necessarily stuck with the mdmon from boot.  In
a pinch you could "mdmon /proc/mdstat /".  Worse case you need to
re-dracut and reboot, but that is already more flexible than the
metadata handled in kernel-space approach.

> You can't run it from the rootfs, because that's a chicken/egg
> scenario (or you'll switch to it, and then be unable to mark it
> clean, because you can't mark the array r/o, because the filesystem
> is r/w, which you can't undo because the daemon is running on
> it...)

Array r/o is a separate issue from the raid metadata clean bit, see below.

> Long-lived daemons running from the initramfs aren't really good.
I agree, and I initially looked for ways to wait until the rootfs was
available before launching mdmon... then I hit the xfs journal
recovery case.

> We don't run udev that way.
At first glance it looks like plymouth is run this way, but I am
probably mistaken.  From dracut/init:
[ -x /bin/plymouth ] && /bin/plymouth --newroot=$NEWROOT

One might say "just set the dirty bit, terminate, and wait for the
mdmon in the rootfs to take over".  The problem is that a disk could
fail in this window, and this event needs to be handled before the
kernel does anything else to the array.

>
>> > - userspace frobs bit in superblock to say 'This array is CLEAN!'
>> ...not in this scenario no.
>
> Then when is the clean bit set?
The clean bit can be set as soon as the parity data is in sync with
the data on the other drives.  We typically wait for some period of
write-inactivity to avoid needlessly touching the metadata after every
write.

>> > So, why isn't the ext* journal or filesystem unclean flag
>> > handled via a userspace file monitoring daemon, then?
>>
>> I'm not trying to be obtuse, but because it isn't.  Put another way,
>> consider what extra tools the initramfs would need if we wanted to
>> support an ntfs-3g rootfs.
>
> You're asking for *the exact same thing*... just RAID specific.
>

The key difference being that there are performance reasons for
handling filesystem metadata in the kernel.  Raid metadata events are
always in the slow path.

--
Dan
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
