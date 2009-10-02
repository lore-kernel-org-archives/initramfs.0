From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: handling mdmon in the initramfs
Date: Fri, 02 Oct 2009 09:14:39 +0200
Message-ID: <4AC5A85F.8060608@redhat.com>
References: <4AC53A0D.6060806@intel.com>	<19141.24565.657477.284252@notabene.brown>	<4AC56AF1.5030801@intel.com> <19141.29719.815785.550499@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19141.29719.815785.550499-wvvUuzkyo1EYVZTmpyfIwg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Neil Brown <neilb-l3A5Bk7waGM@public.gmane.org>
Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Ciechanowski, Ed" <ed.ciechanowski-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Labun, Marcin" <Marcin.Labun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Danecki, Jacek" <jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Patelczyk, Maciej" <maciej.patelczyk-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Hi,

On 10/02/2009 05:31 AM, Neil Brown wrote:

<snip>

>>>> Problem 2: Discovery / Assembly
>>>> Several issues have forced dracut to punt on using mdadm -I.  Instead
>>>> dracut copies mdadm.conf to the initramfs and uses mdadm -As after a
>>>> udevadm --settle.  One low hanging issue is the fact that non-rootfs
>>>> arrays may only be partially assembled when dracut discovers and
>>>> switches to the final rootfs.  Upon switching the in-progress map file
>>>> is lost.  Moving /var/run/mdadm/map to /dev/.mdadm/map would appear to
>>>> solve this issue.
>>>
>>> mdadm already uses /dev/.mdadm.map if /var/run is not writable.  So is
>>> this a solved problem, or do we need some other way to force mdadm not
>>> to use /var/run too early.
>>
>> So you are talking about commit cf3a3d78 [2].  I think the problem is
>> that /var/run/mdadm/map is writable in dracut so we never fall back to
>> /dev/.mdadm.map.  Any reason to not make /dev/.mdadm.map the first
>> location to try?
>
> Because (damn it) the file is not a device file, it is a
> run-time-management file and so it belongs in /var/run.  If we just
> put things wherever was convenient instead of where they belonged we
> would end up with something like /proc!
>
> If there is a writable /var/run in early boot, presumably it is a
> tmpfs filesystem.
> Would it not be simple to
>     mount --bind /var/run /root/var/run
> before the pivot_root, or maybe "mount --move"?
> Then everything would benefit from a stable /var/run and nothing would
> have to put silly inappropriate files in /dev.
>
> On the other hand, if /var/run is not a tmpfs filesystem and is
> normally part of the real /var, what is the justification for having a
> writable /var/run in early boot?  Sounds like a recipe for confusion.
>

There is no such thing in the initrd (a writable /var/run), but there is
a writable / (initrd == ramdisk), and mdadm will happily create /var/run
itself, if it would not do that, there would no issue.

Although I do wonder how later, when we do have a writable /var/run, mdadm
decides which file to use. Once it has used /dev/.mdadm.map once it should
keep on using that.

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
