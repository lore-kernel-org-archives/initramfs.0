From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: kernel/initrd loading delays
Date: Fri, 13 Nov 2015 13:49:38 +0100
Message-ID: <5645DC62.3090903@redhat.com>
References: <561BDFDF.1030303@earthlink.net>
 <20151014090447.GB4795@dhcp-129-3.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151014090447.GB4795-sa4SJRhfYT4qE/hkJvsb+hcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Felix Miata <mrmazda-ihVZJaRskl1bRRN4PJnoQQ@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 14.10.2015 11:04, Dave Young wrote:
> On 10/12/15 at 12:29pm, Felix Miata wrote:
>> On more and more installations since most distros have replaced mkinitrd with
>> dracut, on selecting a bootloader menu choice the "root
>> (hd0,...filesystemtype..[Linux-bzImage, setup, ... initrd /boot/initrd"
>> message stays on screen 40 seconds or more before the time-stamped boot
>> messages begin scrolling the screen. IIRC, these delays first began appearing
>> last January or February, and appear on multiple machines. All kernel and
>> initrd images are on smallish EXT3 or EXT4 (mostly the latter) filesystems
>> using 1024 blocksize on BIOS logical partitions on rotating rust (IIRC, all
>> with native 512b sector size, manufactured in 2011 or earlier). All
>> installations are configured with static IP. All have Plymouth either not
>> installed, or are booted with noplymouth included on kernel cmdline.
>>
>> e.g, on my fastest system, host msi85, a 3.0 GHz dual core Haswell, total
>> time from boot stanza select on BIOS host msi85 to Rawhide 4.3.0-0.rc3.git4.1
>> (dracut initramfs.img 11,326,223) multi-user.target shell prompt ready is
>> about 80 seconds following that 40 second delay, with last time stamp showing
>> 36.844484.
>>
>> Same msi85 system booting LMDE 2 3.16.0-4 (non-dracut? initrd.img 27,362,964;
>> initramfs-tools 0.120) delays start of boot messages nearly 80 seconds,
>> reaching DM greeter ready nearly 140 seconds after stanza selection.
>>
>> Same system booting openSUSE Leap 42.1 4.1.8 (dracut initrd 8,082,360)
>> exhibits no perceptible delay, reaching multi-user.target shell prompt in
>> under 47 seconds from boot stanza selection.
>>
>> Same system booting openSUSE 13.2 3.16.7 (dracut initrd 5,351,996) delays
>> start of boot messages about 40 seconds, reaching multi-user.target bash
>> prompt about 90 seconds after stanza selection.
>>
>> Same system booting Mageia 5 4.1.8 (dracut initrd.img 9,391,664) exhibits no
>> delay, reaching multi-user.target bash prompt in about 45 seconds.
>>
>> Same system booting Wheezy 3.2.0 (non-dracut initrd.img 10,537,321) exhibits
>> no delay, reaching DM greeter in less than about 45 seconds.
>>
>> Same system booting openSUSE 13.1 3.12.44 (non-dracut initrd 7,679,390)
>> exhibits no delay, reaching multi-user.target bash prompt in less than 45
>> seconds.
>>
>> Same system booting Fedora 23 4.2.2 (dracut initramfs.img 11,255,214) reaches
>> multi-user.target shell prompt in about 75 seconds after unknown
>> kernel/initrd delay (puts display into sleep mode until boot messages appear).
>>
>> Same system booting openSUSE Tumbleweed 4.2.1 (dracut initrd 8,970,760)
>> exhibits no delay, reaching multi-user.target bash prompt in less than 45
>> seconds.
>>
>> Same system booting (second, on sda28, vs. other on sda23) openSUSE
>> Tumbleweed 4.2.1 (dracut initrd 8,965,124) exhibits ~40 second delay,
>> reaching multi-user.target bash prompt in about 100 seconds.
>>
>> Same system booting Kubuntu 14.10 3.16.0 (non-dracut initrd 20,550,608)
>> exhibits no initial (linux/initrd) delay, reaching KDM greeter in about 90
>> seconds.
>>
>> Same system booting Fedora 22 4.1.8 (dracut initrd 10,788,392) exhibits no
>> delay, reaching multi-user.target bash prompt in less than 50 seconds.
> 
> Wow, you are using so many distributions.
> 
> From your previous tests, I feel it should not be a dracut problem.
> But you need first find where is the delay from, bootloader, kernel, or somewhere else.
> I think you can select one distribution delaying happend, try older kernel
> if the older kernel does not have the delay then it should be kernel problem.
> 
> As for boot loader, they may have some debug options but I do not know that
> much.
> 
> Thanks
> Dave

Also rawhide kernels have debugging enabled, which slows down significantly.

Adding "rd.debug" might help.

https://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html#_troubleshooting

Also "debug" for systemd/udevd debug messages.
