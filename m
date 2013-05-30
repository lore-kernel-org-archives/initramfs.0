From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Firmware assisted dump support in dracut
Date: Thu, 30 May 2013 08:49:07 +0200
Message-ID: <51A6F663.5030804@redhat.com>
References: <20121128161234.GA8991@in.ibm.com> <50B73598.804@redhat.com> <50C03971.4050104@linux.vnet.ibm.com> <51A6E0E4.1000502@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51A6E0E4.1000502-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Mahesh Jagannath Salgaonkar <mahesh-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Cc: Initramfs Dracut <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ananth Narayan <ananth-xthvdsQ13ZrQT0dZR+AlfA@public.gmane.org>, Steven F Best <sbest-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, Haren Myneni <hbabu-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

On 05/30/2013 07:17 AM, Mahesh Jagannath Salgaonkar wrote:
> On 12/06/2012 11:51 AM, Mahesh Jagannath Salgaonkar wrote:
>> On 11/29/2012 03:44 PM, Harald Hoyer wrote:
>>> Am 28.11.2012 17:12, schrieb Mahesh J Salgaonkar:
>>>> Hi Harald,
>>>>
>>>> Last year I worked on adding Firmware assisted dump (fadump) support in
>>>> PowerLinux (ppc64). This feature is now accepted upstream Linux kernel and the
>>>> documentation is available at http://lwn.net/Articles/488132/
>>>>
>>>> Like kdump, fadump also exports the memory dump through /proc/vmcore in ELF
>>>> format. This enables us to reuse the existing kdump infrastructure for dump
>>>> capture and filtering. However, unlike kdump, fadump does not use kexec-based
>>>> approach, instead it depends on Power firmware to preserve the memory dump and
>>>> reboot into new kernel. This is what happens in fadump after crash:
>>>>
>>>> 1. At the crash, kernel informs power firmware that kernel has crashed.
>>>> 2. Firmware takes the control and reboots the entire system preserving only the
>>>> memory (resets all other devices).
>>>> 3. The reboot follows the normal booting process (non-kexec).
>>>> 4. The boot loader loads the default kernel and initrd from /boot
>>>>
>>>> I am working on integrating fadump with existing kdump infrastructure. The
>>>> current kdump infrastructure builds a separate initrd (whenever there is a
>>>> change detected in kdump config file /etc/kdump.conf) which then gets loaded
>>>> into memory by kexec tool for use by kdump kernel. But, in the fadump approach,
>>>> the second kernel (after crash) always use the default (OS built) initramfs.
>>>> Hence, to support fadump, change is required to introduce dump capturing steps
>>>> in default initramfs itself. Hence the possible approaches I am looking into
>>>> are:
>>>>
>>>> 1. Rebuild the default initramfs every time when there is a change detected in
>>>> kdump config file (/etc/kdump.conf)
>>>>    This approach would modify existing initramfs in place. I did work on this
>>>>    approach by enhancing mkdumprd (tool from kexec-tools package) to extract
>>>>    and rebuild default initramfs with dump capturing steps.  After discussing
>>>>    with Vivek Goyal, he suggested that better approach to add code to dracut
>>>>    for rebuilding boot initramfs instead of enhancing mkdumprd.  This means
>>>>    introducing a new dracut module that will be responsible for introducing
>>>>    dump capture steps inside the rebuilt initramfs by pulling required modules
>>>>    e.g. ssh, nfs etc. depending on /etc/kdump.conf
>>>>
>>>>    Now the question is whether it is possible for dracut to rebuild boot
>>>>    initramfs in place? if Yes, is there any issues in rebuilding of boot
>>>>    initramfs everytime when there is a change in /etc/kdump.conf?
>>>
>>> dracut is called by /sbin/new-kernel-package. dracut is not a service, which is
>>> run on every boot. So, no, dracut can't watch files and build an initramfs on
>>> itsself.
>>>
>>
>> Normally user would restart kdump service after changing kdump config
>> file. Idea is to invoke dracut through kdump service, as it already
>> watches and detect changes in kdump config files.
>>
>> I was wondering if dracut allow us to insert/install additional dracut
>> modules to already existing initramfs? OR does it rebuild initramfs all
>> over again?
> 
> Sorry for restarting this discussion very late. I would like to know how
> safe is to rebuild kernel's default (boot) initramfs for an already
> installed kernel ?
> 
> Also, Does dracut provides any of following mechanism?
> a) Mechanism where dracut can detect what options were used during first
> build for a given (exsisting) initramfs. (This mechanism may help one to
> regenerate similar initramfs with additional dracut modules.)

currently dracut only stores which modules were used to generate the image in
usr/lib/dracut/modules.txt

But yes, you are right. Would be nice to save all the options and have a
mechanism to regenerate it with those.

> 
> OR
> 
> b) Add additional modules to an existing initramfs instead of
> regenerating again. Is this possible at all?

You can always generate a second cpio image with additional files and either
concatenate both images or specify those two images in the bootloader.

OR

unpack the initramfs, add the file, (maybe run depmod, if kernel driver added),
and repack.


