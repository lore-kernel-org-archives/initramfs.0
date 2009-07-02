From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: initqueue
Date: Thu, 2 Jul 2009 15:45:56 +0200
Message-ID: <4A4CBA14.7010301@bfh.ch>
References: <4A4C87DF.10904@redhat.com> <4A4CAA92.9000401@bfh.ch> <4A4CAD6F.6080201@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A4CAD6F.6080201-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hannes Reinecke wrote:
> Hi all,
> 
> Seewer Philippe wrote:
>> Harald Hoyer wrote:
> [ .. ]
>> Please don't do that. That way we actually loose the benefit of doing as
>> much in parallel as possible. Instead please consider the patch below.
>> I've been fiddling with this for a few weeks now. It basically replaces
>> the current "wait-for-root" loop with a loop that queries the udev-queue
>> and only exits if either root is available or all udev events have been
>> processed.
>>
> D'accord.
> 
[snip]
> Ah, if it were so easy.
> 
> This approach work perfectly for any device which does synchronous scanning.
> 
> For a device doing asynchronous scan you're out of luck here as the device
> might start spitting out udev events at any time, even after the udev
> queue is empty.

Damned. I didn't think about that. Any hints how I could simulate that with kvm/qemu?

> EG usb or qla2xxx have a habit of doing so. So either you implement
> checks for each device (-type) which detects if the device is still
> scanning or you indeed just wait until the device appears.
> 
> There actually is no problem with the latter, as all the design
> goal here is to have _every_ device initialization in the background
> / asynchronously by udev.
> So in foreground we indeed just have to wait for the device node
> to appear. Even the udev queue check is pointless here; either
> we have a device node, in which case we can continue regardless
> of how many events are still in the udev queue;
> or we don't have one, in which case it quite irrelevant if
> udev has still events to process or not.

Just blindly waiting for the node to appear is dangerous. We might not
know which node to wait for or we might not have one at all (like
nfsroot for example). And in cases where the node never appears due to
lack of drivers,hardware,cmdline,... we'd never bail out without a timeout.

Suggestion: What about a solution like this?

while [ ! -d $NEWROOT/proc ] ; do
 while [ ! -d $NEWROOT/proc ] ; do
   #...current code as in my patch 
 done

 if [ ! -d $NEWROOT/proc ] ; do
    # No root around, give devices some time to do things asynchronous
    # and settle
    sleep 5
    # If the queue is still empty, bail
    udevadm settle --timeout 1 && break
 fi
done

Sleeping is not a real solution, as is just simply fiddling with timeouts.
Same goes for counting, that's why I tried to implement the udev-queue
approach after all. But I can't think of any other solution that does
not poll a devicenode.

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
