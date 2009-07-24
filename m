From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Race condition? /tmp/net.ifaces and pre-pivot
Date: Fri, 24 Jul 2009 09:21:07 +0200
Message-ID: <4A6960E3.4080807@redhat.com>
References: <4A68D828.40506@redhat.com> <4A6928EE.6090707@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A6928EE.6090707-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 07/24/2009 05:22 AM, Warren Togami wrote:
> On 07/23/2009 05:37 PM, Warren Togami wrote:
>> I am running into an odd issue that is supposedto be impossible.
>>
>> pre-pivot/20write-ifcfg.sh is often being run but fails to write
>> net.*.ifcfg files because /tmp/net.ifaces does not exist at that moment.
>> The mount was otherwise successful, and rdbreak before switch_root sees
>> that /tmp/net.ifaces exists.
>>
>> With plain "root=dhcp" with a NFS rootfs, it seems to never happen.
>> However with "root=dhcp bridge", perhaps 25-75% of the time it is
>> failing to write ifcfg files.
>>
>> Some kind of race going on? An inspection of the code seems to me that
>> /tmp/net.ifaces should have already been created prior to pre-pivot?
>>
>
> <dillow> warren: if you don't have any ip= lines on the command line,
> /tmp/net.ifaces gets created by netroot after the handler successfully
> completes
> <dillow> warren: I think that races with the check loop in init
> <dillow> warren: single processor box?
> <dillow> warren: it looks like you could get scheduled away from netroot
> and the init command loop could notice that root is mounted and make it
> to the pre-pivot hook during a single quantum
> <dillow> warren: as a test, you could move the line '[ ! -f
> /tmp/net.ifaces ] && echo $netif > /tmp/net.ifaces' in netroot in front
> of the handler call
> <dillow> warren: that should work around your issue. I don't think it is
> a long term fix, though -- the multiple NIC case would need some work to
> be clean
> <dillow> warren: this would only affect NFS, as the other devices would
> create /dev/root and exit that way to the mount loop
> <dillow> so they wouldn't sail through the mount loop due to the
> existence of $NEWROOT/proc
> <warren> dillow: single processor qemu VM
> <warren> dillow: so this race was happening before, only we didn't
> notice it since we weren't relying on anything
> <warren> dillow: any suggestions of a substitution that wont break dash?
> <dillow> warren: I think it got introduced with the initqueue stuff or a
> combination of that and changing the loops
>
> Harald, any ideas?

if you rely on a udev event to complete the solution is to place a

udevadm settle

before doing anything
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
