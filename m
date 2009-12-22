From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [dracut] Loading of modules that don't have a uevent or pci
	device: ideas?
Date: Tue, 22 Dec 2009 10:22:21 -0500
Message-ID: <20091222152221.GC2785@phenom.dumpdata.com>
References: <20091221212600.GA7132@phenom.dumpdata.com> <4B30D79F.9080506@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4B30D79F.9080506-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, Dec 22, 2009 at 03:28:47PM +0100, Harald Hoyer wrote:
> On 12/21/2009 10:26 PM, Konrad Rzeszutek Wilk wrote:
>> Hey Harald and initramfs mailing list,
>>
>> I am working on de-coupling a lot of Xen modules from the PV-OPS
>> kernel (git://git.kernel.org/pub/scm/linux/kernel/git/jeremy/xen.git)
>> so that it is not neccessary to have them compiled in.
>>
>> I've gotten to the point that all of the drivers (fbfront, kbdfront,
>> netfront, blkfront, pcifront) can be loaded on demand. Some of them
>> can't be unloaded (still working on that).
>>
>> The next stage is to make the loading automatic, and detect if the kernel
>> is running under Xen (PV) and if so load the neccesssary modules.
>>
>> To solve that, my thought was to:
>>
>> a) Write udev rules that would be act up if the kernel emitted such
>> rules. But the kernel does not emit any uevents for this purpose and
>> it does not emit any virtualization ones until the virtualization modules
>> are loaded.  I could write up code that would emit this
>> information and be generic enough that it would do so for anything
>> that uses the paravirt strutures. So basically a SysFS interface for
>> the paravirt interface.
>>
>> b) Or utilize xen-detect and load the appropiate modules if we are
>> running in Xen PV land. The second is by far much simpler but I don't
>> know if more appropiate. I am attaching an example patch to demonstrate
>> what I had in mind. (Caveat: I didn't include the pre-requisite for
>> xen-tools yet).
>>
>> c). Another way? Any ideas would be much appreciated.
>>
>
> I would favor "modalias" files in /sys, which will be used to modprobe 
> the modules with the modalias.
> Have a look at this:
> $ find /sys -name modalias

I think I did not explain the problem quite well. The modalias values
appear after the modules have been loaded. I am at the situation where I am
trying to figure out if I should load the modules or not - so the modalias
values are not present.

The one option that exists right now to detect whether we are running
under Xen is to use 'xen-detect', which I think you are OK with?

>
> I am sure this could be automated in the kernel without the need of extra 
> special xen handling with scripts.
>
>> +xen-detect
>> +RC=$?
>> +if [ "$RC" = "1" ] ; then
>
> why not?
>
> if xen-detect ; then ...; fi

Ooh, the patches I've for xen-detect return three different return values.
1 for PV Xen, 2 for HVM Xen, and 0 if no Xen.

Also xen-detect prints this out (depending on the scenario):

Running in HVM context on Xen v4.0.
Running in PV context on Xen v4.0.
Not running on Xen.

And it looks that 'if xen-detect', the if clause takes under consideration
the output - which means that on machines not running Xen it would still jump in the
"then" clause.

I think I am going to modify the xen-detect to accept another flag that would
just print a string if it is running in a PV context and nothing else- that
should make it easier.
