From: Benjamin Kingston <list-ses8GfRmtAZWzAuRflr9/A@public.gmane.org>
Subject: Re: Ignore or blacklist a disk from being brought up on boot
Date: Thu, 29 Aug 2013 01:35:30 -0700
Message-ID: <CAHA1JWL9ZKxxu+ctXA5zcPSz+VKQAFnEW4TNNs6h+J0OiF5ggA@mail.gmail.com>
References: <CAHA1JWJisaRVsf2uARPxCN14Fhgu05H9_TxU1zDbyu_3PSbYWA@mail.gmail.com>
 <CAHA1JWJdqmyoqjs7Cp=HzH9F11xBDqR8bxobi51nPtrPFPir3w@mail.gmail.com>
 <521AF44D.5030404@redhat.com> <CAHA1JWJ79ODLUM7pbjNyeMgVEfcsWeVeHt0roZizYW=CsRzd8w@mail.gmail.com>
 <CAHA1JWJpei_FU-2RRZpGdQV7aBCoC=Eud9BgWcFgh=KM0qAcLA@mail.gmail.com> <521C6DC1.1010702@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexusnebula.net; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=K6yV4EsMaEXIHXJwK4KL3eG9/nNyqWoJ/1RDqudsU/c=;
        b=UPrHozIxyYZ+U2dyhKUtObNIuc084LDqSoP9VTNijrspBBVfOMlx/Pys8CXl5QjyrH
         wnKS7E/gLlLXedbm4hSw0ftKnJ6WvgYACmJ1qjrUcOW5XeZfvnyvJCd4jG2CdxuPG/Dk
         OgCLFyjRyxDt+qmcI9MTaHEF+TUzRjL6h3bec=
In-Reply-To: <521C6DC1.1010702-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I'm playing around with fips at the moment and currently have kernel
fips off, to my knowledge the fips dracut module does nothing unless
kernel fips is on. Essentially I'm trying to get dracut to ignore the
boot partition device since all needed information to boot and unlock
(/etc/cryptab and the keyfile) are embedded in the initramfs. It
appears that upon dracut generating the initramfs image, it assumes
that the volume that boot is on is required to boot the system.

I know the system unlocks the drive because if I allow systemd to
timeout while waiting for the volume UUID to appear, I can see the
LUKS volume in /dev/mapper in the dracut shell. Essentially the only
thing preventing the system from booting is the fact that there is a
systemd target that is requiring the boot partition to be made active
(not mounted, as far as I can tell by interrupting dracut pre-pivot
after unlocking the flash volume the 2nd time).

I also had it working smoothly in fedora 17 at one point, where it
would unlock the luks disk according to the embedded crypttab with the
embedded keyfile and boot the system with out having to unlock the
flash drive just so systemd can see it. I'm not sure what could have
changed since fedora 18 since my experience is in systems
administration rather than software development, so I really
appreciate you sharing some of your time.

On Tue, Aug 27, 2013 at 2:13 AM, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On 08/26/2013 04:03 PM, Benjamin Kingston wrote:
>> One more thing to add. There is a systemd target in
>> /etc/systemd/system that mentions the ext4 filesystem on the pin
>> protected flash drive by uuid
>>
>> On Mon, Aug 26, 2013 at 6:13 AM, Benjamin Kingston <list-ses8GfRmtAZWzAuRflr9/A@public.gmane.org> wrote:
>>> My commandline is as follows:
>>> BOOT_IMAGE=/vmlinuz-3.10.9-200.fc19.x86_64
>>> root=UUID=b5855018-5b09-4cbd-a7fc-0516dd5e7a0a ro
>>> rd.lvm.vg.uuid=gK6vvj-uE7w-E6i0-nZOr-WtbN-cJbJ-gxd82v rd.dm=0
>>> rd.luks.uuid=luks-770c95fa-3ce3-4908-a491-8710d679fa68
>>> rd.md.uuid=613e00b8:220a6e5b:0caa4d15:e981bbb1
>>> rd.md.uuid=01f167fc:5607540d:b2274dec:482834f2 vconsole.keymap=us
>>> rd.fips fips=0 intel_iommu=pt rhgb quiet LANG=en_US.utf8
>>>
>>> The disk never gets mounted to my knowledge. When booted, autofs
>>> mounts the disk in /mnt/usb/boot and the /boot folder is a symlink
>>> that points there. Inside the initramfs this is duplicated (/boot
>>> symlink to /mnt/usb/boot), which contains the encryption keyfile.
>>>
>>> On Sun, Aug 25, 2013 at 11:23 PM, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>>> On 08/26/2013 12:58 AM, Benjamin Kingston wrote:
>>>>> I have my boot partition on a pin protected flash drive and have
>>>>> embedded the encryption keyfile for my filesystem in my initramfs
>>>>> image to automate unlocking my computer with just the flash pin. The
>>>>> issue with this comes when generating the initramfs through dracut,
>>>>> because the boot disk is mounted and listed in /proc/self/mountinfo
>>>>> and gets a systemd entry that requires it to be brought online.
>>>>>
>>>>> Since the keyfile is embedded in the image in ram the boot disk is not
>>>>> needed to be brought online, but since the USB is reset, this requires
>>>>> me to enter the pin on the flash drive a second time, just to unlock
>>>>> the volume to satisfy systemd.
>>>>>
>>>>> is there a way to ignore a particular device when running dracut, or
>>>>> at least change its timeout and systemd status to not be boot
>>>>> effecting?
>>>>
>>>>
>>>> What is your kernel cmdline?
>>>> Where is the disk mounted in the initramfs?
>>>>
>
> Why did you specify rd.fips and probably include the fips module?
> Just to get /boot mounted?
