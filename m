From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: udevadm settle timeout semantics
Date: Thu, 18 Jun 2009 13:14:20 +0200
Message-ID: <4A3A218C.7020405@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

The manpage for udevadm (version 141) says about the timeout for settle 
and --timeout:

[quote]
udevadm settle [options]
        Watches the udev event queue, and exits if all
        current events are handled.

--timeout=seconds
            Maximum number of seconds to wait for the event
            queue to become empty. The default value is 180
            seconds. A value of 0 will check if the queue
            is empty and always return immediately.
[/quote]


Am I reading this correctly if I assume that udevadm has to wait for an 
event to be "handled" regardless of the timeout value?

Example: dhclient has a default of 60 seconds to try to get an ip 
address until it fails. udevadm settle waits for the whole 60 seconds to 
pass regardless of the timeout parameter.

Is this behaviour as intended?

Thanks for the help,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
