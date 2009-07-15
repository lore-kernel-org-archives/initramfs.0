From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/3] Tell the kernel to forget about partitions found
 on raw imsm raid disks
Date: Wed, 15 Jul 2009 10:03:48 +0200
Message-ID: <4A5D8D64.1040207@redhat.com>
References: <1247603083-3513-1-git-send-email-hdegoede@redhat.com> <1247603083-3513-2-git-send-email-hdegoede@redhat.com> <1247603083-3513-3-git-send-email-hdegoede@redhat.com> <20090714230219.GA5766@nb.net.home>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090714230219.GA5766-sHeGUpI7y9L/9pzu0YdTqQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Discussion of Development and Customization of the Red Hat Linux Installer <anaconda-devel-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Hi,

On 07/15/2009 01:02 AM, Karel Zak wrote:
>   Hi Hans,
>
> On Tue, Jul 14, 2009 at 10:24:43PM +0200, Hans de Goede wrote:
>> This patch currently assumes this new utility (code included) will become
>> part of udev and will live in /lib/udev, for now it is probably a good idea
>
>   I hope not. The utility duplicate partx(8) / delpart(8) code.
>
>> --- a/modules.d/90mdraid/65-md-incremental-imsm.rules
>> +++ b/modules.d/90mdraid/65-md-incremental-imsm.rules
>> @@ -6,5 +6,6 @@ SUBSYSTEM=="block", ACTION=="add", \
>>          ENV{ID_FS_TYPE}=="linux_raid_member|isw_raid_member", \
>>          TEST!="/tmp/.mdraid_start-%k", \
>> 	IMPORT{program}="/sbin/mdadm --examine --export $tempnode", \
>> +	RUN+="/lib/udev/rm_partitions $env{DEVNAME}", \
>
>   + RUN+=/sbin/partx -d $env{DEVNAME}", \
>

Ah, good one I only knew about kpartx not partx, yes partx is the way to
go (assumed it works I've not tested this yet), no need to invent a
new utility.

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
