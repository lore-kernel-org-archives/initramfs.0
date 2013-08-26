From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Ignore or blacklist a disk from being brought up on boot
Date: Mon, 26 Aug 2013 08:23:09 +0200
Message-ID: <521AF44D.5030404@redhat.com>
References: <CAHA1JWJisaRVsf2uARPxCN14Fhgu05H9_TxU1zDbyu_3PSbYWA@mail.gmail.com> <CAHA1JWJdqmyoqjs7Cp=HzH9F11xBDqR8bxobi51nPtrPFPir3w@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHA1JWJdqmyoqjs7Cp=HzH9F11xBDqR8bxobi51nPtrPFPir3w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Benjamin Kingston <list-ses8GfRmtAZWzAuRflr9/A@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 08/26/2013 12:58 AM, Benjamin Kingston wrote:
> I have my boot partition on a pin protected flash drive and have
> embedded the encryption keyfile for my filesystem in my initramfs
> image to automate unlocking my computer with just the flash pin. The
> issue with this comes when generating the initramfs through dracut,
> because the boot disk is mounted and listed in /proc/self/mountinfo
> and gets a systemd entry that requires it to be brought online.
> 
> Since the keyfile is embedded in the image in ram the boot disk is not
> needed to be brought online, but since the USB is reset, this requires
> me to enter the pin on the flash drive a second time, just to unlock
> the volume to satisfy systemd.
> 
> is there a way to ignore a particular device when running dracut, or
> at least change its timeout and systemd status to not be boot
> effecting?


What is your kernel cmdline?
Where is the disk mounted in the initramfs?
