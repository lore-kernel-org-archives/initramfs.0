From: Harald Hoyer <harald@redhat.com>
Subject: Re: RFC: mdadm and bringing up raid sets from initrd (dracut)
Date: Thu, 16 Jul 2009 12:56:18 +0200
Message-ID: <4A5F0752.1020400@redhat.com>
References: <4A5C6501.3080607@redhat.com>	 <1955210A-EF27-479F-8C58-BA4FA9018A56@redhat.com>	 <4A5C9E17.2060106@redhat.com>	 <D758972F-0E5A-4860-9011-6B2DA1FA771A@redhat.com> <1247583632.1991.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hotplug-owner@vger.kernel.org>
In-Reply-To: <1247583632.1991.39.camel@localhost.localdomain>
Sender: linux-hotplug-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Zeuthen <david@fubar.dk>
Cc: Doug Ledford <dledford@redhat.com>, Hans de Goede <hdegoede@redhat.com>, initramfs <initramfs@vger.kernel.org>, linux-hotplug@vger.kernel.org, "Danecki, Jacek" <jacek.danecki@intel.com>

On 07/14/2009 05:00 PM, David Zeuthen wrote:
> On Tue, 2009-07-14 at 10:14 -0400, Doug Ledford wrote:
>> On Jul 14, 2009, at 11:02 AM, Hans de Goede wrote:
>>> Hi,
>>> On 07/14/2009 03:39 PM, Doug Ledford wrote:
>>>> On Jul 14, 2009, at 6:59 AM, Hans de Goede wrote:
>>>>> Hi,
>>>>>
>>>>> As you probably know I'm working on making Fedora 12 use mdraid
>>>>> instead of dmraid for Intel BIOS-RAID setups.
>>>>>
>>>>> The installer (anaconda) part is mostly done (needs more testing)
>>>>> and now I'm looking at implementing support for this in dracut
>>>>> (the new mkinitrd for Fedora 12).
>>>>>
>>>>> So I've been testing how this works for both imsm mdraid sets
>>>>> and native mdraid metadata sets, in both cases using a 2 disk
>>>>> mirror, so that the set can also be brought up in degraded mode.
>>>>>
>>>>> Currently the udev rules use incremental assembly like this:
>>>>> mdadm -I /dev/mdraid-member
>>>> Hmmm...does dracut use udev during initramfs time?
>>> Yes, it uses udev for everything, making discovery of / consistent
>>> with the discovery of other storage devices.
>> I'm not sure I like or agree with that philosophy.  I absolutely
>> *don't* want my / filesystem or raid device treated like some plug in,
>> temporary, roaming raid device.  They *aren't* the same, not in terms
>> of importance to the running of the machine and not in terms of
>> reliability requirements.  By using mdadm -A in the mkinitrd calls, I
>> was able to put in an mdadm.conf file and limit what arrays get
>> started to arrays found non-ambiguously in that mdadm.conf file and
>> identified by UUID.  When you switch to incremental assembly for root,
>> you risk the possibility of name space collisions and non-
>> deterministic bring up of your / array.
>
> I'm concerned about this too. To be more specific, I'm concerned about
> both automatically assembling things like RAID arrays / LVM logical
> volumes and also automounting devices [1].
>
> Anyway, my point with all this is that maybe we are going about things
> wrong in the initramfs. My understanding is that dracut roughly works
> this way (please let me know if this is wrong)
>
>   1. when generating the initramfs image, we leave information in
>      the kernel command-line about the root filesystem - typically
>      the UUID - e.g. root=UUID=786263c4-5e28-4cdc-97b8-1ab6e221c344
>
>   2. when the initramfs starts, we trigger all uevents and wait for
>      things to settle
>
>   3. Autoassembly / magic:
>
>      - If we see e.g. md components, we activate them via udev rules
>      - If we see e.g. LUKS devices, we unlock them (by interacting with
>        the user asking for the passphrase) via udev rules.
>      - Ditto for e.g. LVM
>
>   5. if we see the rootfs (matching on e.g. the UUID passed on the
>      kernel command line) we create the /dev/root symlink
>
>   6. when the system has settled (e.g. no more uevents) we mount
>      /dev/root and transition to non-early user space. If there
>      is no /dev/root link, we bail out
>
> Now, my beef is 3. above. I think it is way too optimistic to just
> auto-assemble / unlock etc. everything. E.g. we end up doing a lot of
> work not related to the rootfs that is better done in non-early user
> space.
>
> Instead, just like we specify the UUID for rootfs on the command-line,
> we need to leave some instructions to the initramfs logic on _exactly_
> what things should be autoassembled / unlocked / etc. in order to find
> the rootfs. So the kernel command-line wouldn't really be "just" the
> UUID of rootfs; it would be a whole recipe of actions to do. E.g.
>
>   ROOTFS=UUID=1234          \ # this the UUID of my rootfs
>   MD_ASSEMBLE=UUID=4567     \ # assemble MD array with UUID 4567
>   LUKS_UNLOCK=UUID=89ab       # unlock LUKS device with UUID 89ab
>
> which would work for e.g. cases where rootfs is on a LUKS device which
> is on a MD array. In other words, we'd need a whole "recipe" passed to
> the initramfs (the mkinitrd tool would generate this recipe), not just
> the UUID of the rootfs.
>
> Coincidentally, if we had something like this and the format of the
> "recipe" was documented somewhere, it would be easy to e.g. implement
> "rescue" functionality as described here
>
> http://www.redhat.com/archives/fedora-desktop-list/2009-July/msg00019.html
>
> since graphical disk utilities would just find /etc/grub.conf (or
> similar), read the recipe and then start assembling/unlocking bits and
> mount them as appropriate in /mnt/rescue/.
>
> Actually this is very close to what Doug is asking for when he says
> (paraphrased) "just include mdadm.conf instead of this magic". The key
> difference, however, is that the user _won't_ have to use mdadm.conf or
> care about config files - it's all taken care of by the mkinitrd binary
> when building the recipe. This is a good thing as having one less config
> file to worry about is good.
>
> Thanks for considering, and sorry for the long mail,
> David
>
> [1] : As some background information, I've spent a good chunk of my
> life, five years or so, dealing with end users complaining about how
> plain block devices got automounted when they were plugged in. FWIW, the
> complaints ranges from both non-sensical (irritated users: "these
> desktop kids shall not decide how UNIX works") to actual bugs where the
> on-disk contents were mis-detected and either something wrong got
> automounted or we failed to automount at all.
>
> If I've learned anything it's that you need to be very very careful here
> - unlike Windows and other operating systems with such capabilities,
> Linux is.. different.. mostly because we support so many different ways
> to put a file system through things likd md and dm. And you need to make
> it very easy to turn things like this off.
>
>
>

David, thanks for your suggestion. As of yesterday, dracut recognizes now the 
following command line parameters:

LVM
        rd_NO_LVM
               disable LVM detection

        rd_LVM_VG=<volume group name>
               only activate the volume groups with the given name

crypto LUKS
        rd_NO_LUKS
               disable crypto LUKS detection

        rd_LUKS_UUID=<luks uuid>
               only activate the LUKS partitions with the given UUID

MD
        rd_NO_MD
               disable MD RAID detection

        rd_MD_UUID=<md uuid>
               only activate the raid sets with the given UUID

DMRAID
        rd_NO_DM
               disable DM RAID detection

        rd_DM_UUID=<dmraid uuid>
               only activate the raid sets with the given UUID

