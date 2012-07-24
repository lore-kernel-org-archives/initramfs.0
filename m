From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 1/2] init: Introduce early initrd files through uncompressed cpio passing
Date: Tue, 24 Jul 2012 11:16:01 +0200
Message-ID: <201207241116.02354.trenn@suse.de>
References: <1342607764-66747-1-git-send-email-trenn@suse.de> <201207231640.35023.trenn@suse.de> <500D691C.7010203@zytor.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <500D691C.7010203@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, initramfs@vger.kernel.org, bigeasy@linutronix.de, Fenghua Yu <fenghua.yu@intel.com>

On Monday, July 23, 2012 05:09:16 PM H. Peter Anvin wrote:
> On 07/23/2012 07:40 AM, Thomas Renninger wrote:
> > This is another problem and I expect I call:
> > early_initrd_find_cpio_data()
> > early enough for Fenghua's needs.
> > If not, how early exactly is this needed?
> 
> We're calling that from arch-specific code before even turning paging 
> on.
Why?
If you would shed more light into what you (or Fenghua)
try to achieve that would help.
What kind of platform/CPU is this?
What happens if firmware is not provided (that early,..)?

...

> Now, you definitely do have a valid point about being able to iterate 
> over multiple files with a common prefix.  We could do that with either 
> a callback (where the callback is passed in as an argument), but I think 
> it might be nicer to do that as an iterator interface... let me ketch on 
> this.
Please do.

I finally would like to have the ACPI table via initird overriding.
ACPICA people added the physical table override stuff only for this.
With the cpio encapsulation (using initrd_start) this is a nice,
arch independent approach.
I can imagine the one or other arch picks this up. One example
could be flattened device tree passing via intird for ARM.

Maybe it could be kept arch independent with a "weird archs need things
even earlier" specific interface/hook if really needed.
Then others could pass initrd_start as now done, but X86 or
specific archs do some nasty HW specific stuff.

...
 
Hm, I could imagine this early fiddling will take some time.
If the cpio encapsulation as shown is acceptable, these patches
could get pushed already and the "very very early" additions can
be pushed on top in one of the next kernel rounds.

Thanks,

   Thomas
