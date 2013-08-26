From: Benjamin Kingston <list-ses8GfRmtAZWzAuRflr9/A@public.gmane.org>
Subject: Re: Ignore or blacklist a disk from being brought up on boot
Date: Mon, 26 Aug 2013 06:13:10 -0700
Message-ID: <CAHA1JWJ79ODLUM7pbjNyeMgVEfcsWeVeHt0roZizYW=CsRzd8w@mail.gmail.com>
References: <CAHA1JWJisaRVsf2uARPxCN14Fhgu05H9_TxU1zDbyu_3PSbYWA@mail.gmail.com>
 <CAHA1JWJdqmyoqjs7Cp=HzH9F11xBDqR8bxobi51nPtrPFPir3w@mail.gmail.com> <521AF44D.5030404@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexusnebula.net; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GQctZkOTMKz3bcDBYmBVnBcBdlTH+WZlyohe38kZBd8=;
        b=WpwuuxM9QkaHfOQY6bSQrG0mj7mH2YOM4px7Hi4RlXd+zZyXrwXIrVHwPTXAwVUKt9
         gyUjsn+5T7oRxY8/Bg7GVSqLcLROI3jgSnzF9VyE48iuIqlw4JhTQhPB3GbTLkPmwsQ/
         DofR1AZdAZfCBQREpLexwqrwA6r7F21RNJ0fA=
In-Reply-To: <521AF44D.5030404-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

My commandline is as follows:
BOOT_IMAGE=/vmlinuz-3.10.9-200.fc19.x86_64
root=UUID=b5855018-5b09-4cbd-a7fc-0516dd5e7a0a ro
rd.lvm.vg.uuid=gK6vvj-uE7w-E6i0-nZOr-WtbN-cJbJ-gxd82v rd.dm=0
rd.luks.uuid=luks-770c95fa-3ce3-4908-a491-8710d679fa68
rd.md.uuid=613e00b8:220a6e5b:0caa4d15:e981bbb1
rd.md.uuid=01f167fc:5607540d:b2274dec:482834f2 vconsole.keymap=us
rd.fips fips=0 intel_iommu=pt rhgb quiet LANG=en_US.utf8

The disk never gets mounted to my knowledge. When booted, autofs
mounts the disk in /mnt/usb/boot and the /boot folder is a symlink
that points there. Inside the initramfs this is duplicated (/boot
symlink to /mnt/usb/boot), which contains the encryption keyfile.

On Sun, Aug 25, 2013 at 11:23 PM, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On 08/26/2013 12:58 AM, Benjamin Kingston wrote:
>> I have my boot partition on a pin protected flash drive and have
>> embedded the encryption keyfile for my filesystem in my initramfs
>> image to automate unlocking my computer with just the flash pin. The
>> issue with this comes when generating the initramfs through dracut,
>> because the boot disk is mounted and listed in /proc/self/mountinfo
>> and gets a systemd entry that requires it to be brought online.
>>
>> Since the keyfile is embedded in the image in ram the boot disk is not
>> needed to be brought online, but since the USB is reset, this requires
>> me to enter the pin on the flash drive a second time, just to unlock
>> the volume to satisfy systemd.
>>
>> is there a way to ignore a particular device when running dracut, or
>> at least change its timeout and systemd status to not be boot
>> effecting?
>
>
> What is your kernel cmdline?
> Where is the disk mounted in the initramfs?
>
