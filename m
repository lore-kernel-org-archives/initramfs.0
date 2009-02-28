From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: dracut and ubuntu 8.10
Date: Sat, 28 Feb 2009 10:11:16 +0100
Message-ID: <49A8FFB4.8080705@bfh.ch>
References: <49A8602D.7020708@bfh.ch> <1235791236.6445.25.camel@sentry-no.fnordovax.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1235791236.6445.25.camel-76q0VzFBGGr21HsLBtNmTckMGDeJXHgy@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org



Victor Lowther wrote:
> On Fri, 2009-02-27 at 22:50 +0100, Seewer Philippe wrote:
>> Hello all
>>
>> Today I actually just wanted to give Victor Lowther's network patches a go and see how far they can go. But first I thought why not try and get dracut running on my own system. Well, it didn't go straightforward, hence my series of patches this day. (Sorry Victor, testing network stuff will have to wait until next Friday)
>>
>> But at last: success! Dracut now boots my notebook!
> 
> Excellent! 
> 
>> Here's how:
>>
>> 0) Get dracut ;-)
>>
>> 1) Apply the patches I sent today
>>
>> 2) Depending on whether or not you need cryptsetup and/or lvm chmod -x 90crypt.sh and/or 90lvm.sh inside dracut/modules
>>
>> 3) Apply the patch below to get the correct ubuntu udev stuff
>>
>> 4) If you're on a x86-64 system (ubuntu amd64 install) make sure /lib64 does point to just 'lib' not '/lib':
>>
>> $ sudo bash
>> $ cd /
>> $ rm /lib64
>> $ /lib/ld-linux.so.2 /bin/ln -s lib lib64
> 
> Any idea why this is required?  That looks like it could break all sorts
> of things come upgrade time, especially if you actually have a mixed
> 32/64 bit environment.

Well initially lib64 points to /lib by absolute reference . That works 
well until switch_root starts cleaning up the initrams. When /lib is 
gone, so is our loader.
I don't yet know what will happen during upgrade time, but my guess is 
nothing big will happen, sind /lib only contain 64-bit libraries, the 
32bit ones go inside /lib32.

This is a workaround to make switch_root work. I guess sometime in the 
future switch_root will need some more love...


> 
>> 5) create /etc/dracut.conf and add the required drivers for your root-disk. And don't forget to add sd_mod (and sg just out of paranoia). Otherwise there's no disks at all.
>>
>> 6) Run dracut, build your image, add it to grub, reboot and hopefully enjoy! (Yes, there's no splash screen etc. But hey! It boots!)
> 
> Splash screens are for wussies anyways.  Real Linux Users run without
> ever touching a framebuffer, and have the output of the kernel boot
> sequence on every machine they have ever used memorized. :)

I have met people who like splash screen actually. But the 
infrastructure is there now, so anyone who wants can put it in :)

[snip]
>> +for rules in 05-options.rules 20-names.rules 40-basic-permissions.rules 60-persistent-storage.rules 61-persistent-storage-edd.rules 80-programs.rules 90-modprobe.rules 95-udev-late.rules; do
>> +    dracut_install /etc/udev/rules.d/$rules 
>> +done
> 
> You can use inst_rules to do the same thing without the for loop.

Ah no I can't. inst_rules puts the rules inside /lib/udev/rules.d and i 
want them inside /etc/udev/rules.d.... Why not just use dracut install 
in every module? Would make it a lot easier to read.

> I should probably patch it to look in ., /lib/udev/rules.d,
> and /etc/udev/rules.d if passed a filename without a path, though --
> that would make things easier to read and maintain.
> 
>> +dracut_install /lib/udev/dvb_device_name 
>> +dracut_install /lib/udev/usb_device_name 
>> +dracut_install /lib/udev/ata_id 
>> +dracut_install /lib/udev/usb_id 
>> +dracut_install /lib/udev/vol_id 
>> +dracut_install /lib/udev/scsi_id 
>> +dracut_install /lib/udev/path_id 
>> +dracut_install /lib/udev/edd_id 
>> +dracut_install /lib/udev/firmware_helper 
>> +dracut_install /lib/udev/ide_media 
>> +dracut_install /lib/udev/vio_type 
>> +dracut_install /lib/udev/watershed
> 
> dracut_install does take multiple arguments. :)
> 
> dracut_install /lib/udev/*_device_name /lib/udev/*_id /lib/udev/firmware_helper \
> /lib/udev/ide_media /lib/udev/vio_type /lib/udev/watershed\

Yes I know, see the first dracut_install line in this script. This was 
just a quick hack, using emacs rectangle mode was just a lot easier and 
faster than retyping the stuff from the original.

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
