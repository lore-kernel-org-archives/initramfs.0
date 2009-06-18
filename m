From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: udevadm settle timeout semantics
Date: Thu, 18 Jun 2009 14:55:24 +0200
Message-ID: <4A3A393C.6000405@bfh.ch>
References: <4A3A218C.7020405@bfh.ch> <1245327385.7315.3.camel@yio.site>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245327385.7315.3.camel-2/CBIq5w30c@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Kay Sievers wrote:
> On Thu, 2009-06-18 at 13:14 +0200, Seewer Philippe wrote:
>> The manpage for udevadm (version 141) says about the timeout for settle 
>> and --timeout:
>>
>> [quote]
>> udevadm settle [options]
>>         Watches the udev event queue, and exits if all
>>         current events are handled.
>>
>> --timeout=seconds
>>             Maximum number of seconds to wait for the event
>>             queue to become empty. The default value is 180
>>             seconds. A value of 0 will check if the queue
>>             is empty and always return immediately.
>> [/quote]
>>
>>
>> Am I reading this correctly if I assume that udevadm has to wait for an 
>> event to be "handled" regardless of the timeout value?
>>
>> Example: dhclient has a default of 60 seconds to try to get an ip 
>> address until it fails. udevadm settle waits for the whole 60 seconds to 
>> pass regardless of the timeout parameter.
>>
>> Is this behaviour as intended?
> 
> The timeout is the maximum to wait:
> 
>   $ echo 'RUN+="/bin/sleep 300"' > /etc/udev/rules.d/00.rules
>   $ echo add > /sys/class/mem/zero/uevent
> 
>   $ time udevadm settle --timeout=3
>   udevadm settle - timeout of 3 seconds reached, the event queue contains:
>   /sys/devices/virtual/mem/zero (1796)
> 
> Not sure, udev 141 maybe had a bug here.

That is correct.

$ echo 'KERNEL=="zero" RUN+="/bin/sleep 300"' > /etc/udev/rules.d/00.rules
$ echo add > /sys/class/mem/zero/uevent

$ time udevadm settle --timeout=5
real	2m52.687s
user	0m0.004s
sys	0m0.064s

Harald found the bugfix for udevadm which fixed this:
http://article.gmane.org/gmane.linux.hotplug.devel/13952


This creates a problem for network configuration: If dhcp takes
longer than 30 seconds plus the time we allow for mount fall-through,
an emergency-shell will appear while maybe mount is happending in the
background because dhcp succeeded.

Any thoughts?
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
