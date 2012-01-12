From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/3] allow network setup without netroot
Date: Thu, 12 Jan 2012 09:51:45 +0800
Message-ID: <4F0E3CB1.3080607@redhat.com>
References: <1326304109-32652-1-git-send-email-wwoods@redhat.com> <1326304109-32652-3-git-send-email-wwoods@redhat.com> <20120111210614.GB14024@metroid.usersys.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120111210614.GB14024-s6BhOCdKmxS3M6m420IelR/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/12/2012 05:06 AM, Will Woods wrote:

> On Wed, Jan 11, 2012 at 12:48:29PM -0500, Will Woods wrote:
>> Currently, network configuration arguments are ignored *unless* the root
>> device is a network device. But there are some cases where you might
>> want to set up the network even though you have a non-network root
>> device (e.g. to fetch updates from the network for a livecd image).
>>
>> With this patch you can set "netroot=no", which will cause dracut to set
>> up the network according to your other boot arguments but not attempt to
>> set up a network root device.
>>
>> Signed-off-by: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>>  modules.d/40network/netroot |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/modules.d/40network/netroot b/modules.d/40network/netroot
>> index 9d996cc..eba269a 100755
>> --- a/modules.d/40network/netroot
>> +++ b/modules.d/40network/netroot
>> @@ -13,11 +13,12 @@ type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
>>  [ ! -e /tmp/net.$1.up ] && exit 1
>>  
>>  # There's no sense in doing something if no (net)root info is available
>> -# or root is already there
>> +# or root is already there - or if we're specifially told not to
>>  [ -e /tmp/root.info ] || exit 1
>>  . /tmp/root.info
>>  [ -d $NEWROOT/proc ] && exit 0
>>  [ -z "$netroot" ] && exit 1
>> +[ "$netroot" = "no" ] && exit 0
> 
> ..on second thought, this might not be the best way to handle this use
> case. There's a bunch of other network setup stuff that happens
> afterward in 'netroot', and we probably will want that for whatever
> network stuff is happening instead of mounting root.

> 
> Maybe a 'dummyroot' netroot "handler" that doesn't do anything would be
> better - that way anything that wants to trigger when the network is up
> can just add items to the 'netroot' hook, and they'll run like normal
> netroot hooks.
> 
> If anyone's got opinions on the matter, let me know - otherwise I'll
> probably have a different version of this patch in a day or two. Skip it
> for now.


I have sent a patch for manually ifup nic, which deal with this problem
 and also be useful when we use initrd as minimal recovery system.

see:
http://www.spinics.net/lists/linux-initramfs/msg02205.html

Yes, dummy netroot is a reasonable idea for automatically bring up
network, but I still do not want to lose the manual setup option.
I'd like to have both :)

> 
> -w
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
