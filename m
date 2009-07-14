From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: RFC: mdadm and bringing up raid sets from initrd (dracut)
Date: Tue, 14 Jul 2009 17:02:47 +0200
Message-ID: <4A5C9E17.2060106@redhat.com>
References: <4A5C6501.3080607@redhat.com> <1955210A-EF27-479F-8C58-BA4FA9018A56@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1955210A-EF27-479F-8C58-BA4FA9018A56-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Doug Ledford <dledford-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-hotplug-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Danecki, Jacek" <jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Hi,

On 07/14/2009 03:39 PM, Doug Ledford wrote:
> On Jul 14, 2009, at 6:59 AM, Hans de Goede wrote:
>> Hi,
>>
>> As you probably know I'm working on making Fedora 12 use mdraid
>> instead of dmraid for Intel BIOS-RAID setups.
>>
>> The installer (anaconda) part is mostly done (needs more testing)
>> and now I'm looking at implementing support for this in dracut
>> (the new mkinitrd for Fedora 12).
>>
>> So I've been testing how this works for both imsm mdraid sets
>> and native mdraid metadata sets, in both cases using a 2 disk
>> mirror, so that the set can also be brought up in degraded mode.
>>
>> Currently the udev rules use incremental assembly like this:
>> mdadm -I /dev/mdraid-member
>
> Hmmm...does dracut use udev during initramfs time?

Yes, it uses udev for everything, making discovery of / consistent
with the discovery of other storage devices.

<snip>

> Are we going to be totally changing this with
> dracut and F12? This method very nicely resolves the issues you posted.
>

Yes.

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
