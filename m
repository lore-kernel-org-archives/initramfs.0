From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: PATCH: Fix / on lvm
Date: Mon, 13 Jul 2009 09:04:19 +0200
Message-ID: <4A5ADC73.5000509@redhat.com>
References: <4A577113.2040804@redhat.com> <4A5AA554.3000304@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A5AA554.3000304-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi,

On 07/13/2009 05:09 AM, Warren Togami wrote:
> On 07/10/2009 12:49 PM, Hans de Goede wrote:
>> Hi,
>>
>> Currently / on lvm is not working because the udev rules test for
>> KERNEL="dm-*" which of course
>> will not be true for PV's, so PV's are not recognized and thus lvm does
>> not work.
>>
>> The attached patch fixes this.
>>
>> Regards,
>>
>> Hans
>
> Could you please describe in detail the type of setup needed to
> reproduce this failure? I have / on lvm here and dracut is working just
> fine.
>

Basically the default anaconda partitioning setup so /boot /dev/sda1
(sata disk) and / on an lv whose vg contains one (large) pv which is
/dev/sda2

But this isn't all that interesting, read the rules, they are there to
do: "lvm vgscan; lvm vgchange -ay" when a new PV gets added to the system,
yet they contain the line:

KERNEL!="dm-*", GOTO="lvm_end"

Before doing this, meaning that a PV on a regular scsi disk (instead of a
PV on top of device mapper) will not cause the
"lvm vgscan; lvm vgchange -ay" to get executed and thus my / to not be
found.

Maybe you are using a dmraid setup ?  That would explain why these rules
are working for you.

Regards,

Hans


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
