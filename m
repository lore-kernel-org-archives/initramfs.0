From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: handling mdmon in the initramfs
Date: Fri, 02 Oct 2009 10:02:36 +0200
Message-ID: <4AC5B39C.10101@redhat.com>
References: <4AC53A0D.6060806@intel.com>	<19141.24565.657477.284252@notabene.brown>	<4AC56AF1.5030801@intel.com>	<19141.29719.815785.550499@notabene.brown>	<4AC5A85F.8060608@redhat.com> <19141.44581.425618.711550@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19141.44581.425618.711550-wvvUuzkyo1EYVZTmpyfIwg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Neil Brown <neilb-l3A5Bk7waGM@public.gmane.org>
Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Ciechanowski, Ed" <ed.ciechanowski-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Labun, Marcin" <Marcin.Labun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Danecki, Jacek" <jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Patelczyk, Maciej" <maciej.patelczyk-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Hi,

On 10/02/2009 09:39 AM, Neil Brown wrote:
> On Friday October 2, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org wrote:
>> Hi,
>>
>> There is no such thing in the initrd (a writable /var/run), but there is
>> a writable / (initrd == ramdisk), and mdadm will happily create /var/run
>> itself, if it would not do that, there would no issue.
>
> mdadm does not create directories (or at least not for the map file).
> So if /var/run does not exist, it will use a file in /dev.
>
>>
>> Although I do wonder how later, when we do have a writable /var/run, mdadm
>> decides which file to use. Once it has used /dev/.mdadm.map once it should
>> keep on using that.
>
> It always tries the first of
>    /var/run/mdadm/map  /var/run/mdadm.map /dev/.mdadm.map
>
> it will normally read, then write.
> So if /var/run doesn't exist, it will use /dev/.mdadm.map
> Once /var/run/mdadm exists, it will
>    read from /dev/.mdadm.map
>    write to /var/run/mdadm/map
>
> and from then on use /var/run/mdadm/map
>
> So if the initramfs really does not contain /var/run, then this aspect
> should "just work".
>

Ok,

Harald, I know we recently added some stuff to dracut with symlinks under
/var/run/mdadm. Since since then, we've opted to instead patch mdmon
to store its state under /dev/.mdadm (until a better fix is upstream), so the
symlink stuff can be removed and then the map stuff should just work.

Note that we will then still have issues with incremental assembly, as
dracut does incremental assembly, and if we then have partly assembled
arrays when switching over to /, rc.sysinit does a
mdadm -As --run, assembling everything in mdadm.conf, which will still
cause issues if some of them are already partly incremental assembled. But
I don't consider this a mdadm bug, but a distro one :)

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
