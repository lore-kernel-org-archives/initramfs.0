From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: multipath device issue
Date: Tue, 14 Aug 2012 14:17:19 +0800
Message-ID: <5029ED6F.5080904@redhat.com>
References: <501A0B87.9070506@redhat.com> <501A3532.7010907@redhat.com> <501A7590.3010701@redhat.com> <501A7E2A.4020601@redhat.com> <501A8078.1020208@redhat.com> <501B635B.1090703@redhat.com> <501B7FCE.1050502@redhat.com> <501B91FA.6010703@redhat.com> <5029ED27.8000309@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5029ED27.8000309-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chao Wang <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Cc vivek

On 08/14/2012 02:16 PM, Dave Young wrote:

> 
>>> So, if you see /dev/mapper/mpathb be correctly created, when you start multpathd
>>> after all devices exist in /dev, then the 62-multipath.rules
>>> mechanism does not seem to work,
>>
>>>
>>
>>> With the next systemd release "rd.udev.log-priority=debug" does work again and
>>> we might be able to debug this issue.
>>
>>
>> Ok, will see if I can get something from the 62-multipath.rules. Thanks
>> for the suggestion.
>>
>>
> 
> 
> Hi, here is the debug messages with latest systemd, 62-multipath fails
> at run 'socket:/org/kernel/dm/multipath_event':
> 
> ---
> Welcome to Fedora 17 (Beefy Miracle) dracut-023-2.fc18 (Initramfs)!
> 
> [    0.799958] systemd[1]: No hostname configured.
> [    0.801608] systemd[1]: Set hostname to <localhost>.
> [    0.807834] systemd[1]: Cannot add dependency job for unit
> systemd-journal-flush.service, ignoring: Unit
> systemd-journal-flush.service failed to load: No such file or directory.
> See system logs and 'systemctl status systemd-journal-flush.service' for
> details.
> [  OK  ] Listening on udev Kernel Socket.
> [  OK  ] Listening on udev Control Socket.
> [  OK  ] Listening on Journal Socket.
>          Starting Journal Service...
> [    0.825703] systemd-journald[44]: Fixed max_use=11.8M max_size=1.4M
> min_size=64.0K keep_free=5.9M
> [    0.828702] systemd-journald[44]: Reserving 2695 entries in hash table.
> [    0.831147] systemd-journald[44]: Vacuuming...
> [  OK  ] Started Journal Service.
> [  OK  ] Reached target Sockets.
>          Starting Dracut cmdline hook...
>          Starting Setup Virtual Console...
> [  OK  ] Reached target Swap.
> [  OK  ] [    0.850156] usb 1-1: new full-speed USB device number 2
> using uhci_hcd
> Reached target Local File Systems.
> [  OK  ] Started Setup Virtual Console.
> [  OK  ] Reached target System Initialization.
> dracut-cmdline[46]: Warning: Option 'KEYTABLE' is deprecated, use
> 'KEYMAP' instead.
> dracut-cmdline[46]: Warning: Option 'SYSFONT' is deprecated, use 'FONT'
> instead.
> [  OK  ] Started Dracut cmdline hook.
>          Starting Dracut pre-udev hook...
> [  OK  ] Started Dracut pre-udev hook.
>          Starting udev Kernel Device Manager...
> [  OK  ] Started udev Kernel Device Manager.
>          Starting Dracut pre-trigger hook...
> [  OK  ] Reached target Basic System.
> [    0.950521] systemd-udevd[102]: starting version 188
> [    0.970090] device-mapper: multipath: version 1.3.0 loaded
> [    1.003546] input: ImExPS/2 Generic Explorer Mouse as
> /devices/platform/i8042/serio1/input/input2
> [    1.266732] usb 1-1: New USB device found, idVendor=0627, idProduct=0001
> [    1.269940] usb 1-1: New USB device strings: Mfr=1, Product=3,
> SerialNumber=5
> [    1.272323] usb 1-1: Product: QEMU USB Tablet
> [    1.273889] usb 1-1: Manufacturer: QEMU 1.0
> [    1.275491] usb 1-1: SerialNumber: 42
> [    1.311638] input: QEMU 1.0 QEMU USB Tablet as
> /devices/pci0000:00/0000:00:01.2/usb1/1-1/1-1:1.0/input/input3
> [    1.315072] generic-usb 0003:0627:0001.0001: input,hidraw0: USB HID
> v0.01 Pointer [QEMU 1.0 QEMU USB Tablet] on usb-0000:00:01.2-1/input0
> [    1.344055] Refined TSC clocksource calibration: 2491.907 MHz.
> [    1.349823] systemd-udevd[163]: failed to execute
> '/usr/lib/udev/socket:/org/kernel/dm/multipath_event'
> 'socket:/org/kernel/dm/multipath_event': No such file or directory
> dracut-initqueue[144]: Warning: Could not boot.
> dracut-initqueue[144]: Warning: /dev/mapper/mpathb does not exist
> 
> 
> Entering emergency mode. Exit the shell to continue.
> Type "journalctl" to view system logs.
> 
> dracut:/#
> 



-- 
Thanks
Dave
