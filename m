From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v1] dracut.sh: Support early microcode loading.
Date: Wed, 17 Jul 2013 14:40:33 +0200
Message-ID: <51E690C1.5010004@redhat.com>
References: <1373397849-11397-1-git-send-email-konrad.wilk@oracle.com> <3E5A0FA7E9CA944F9D5414FEC6C712205A528195@ORSMSX106.amr.corp.intel.com> <51DD0F27.70202@redhat.com> <20130710145815.GD11007@phenom.dumpdata.com> <20130712210254.GA26664@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130712210254.GA26664-6K5HmflnPlqSPmnEAIUT9EEOCMrvLtNR@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: "Yu, Fenghua" <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 07/12/2013 11:02 PM, Konrad Rzeszutek Wilk wrote:
> From 5f853d2ececd4cadff648e22cb9c9287a01a9783 Mon Sep 17 00:00:00 2001
> From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> Date: Tue, 9 Jul 2013 13:57:01 -0400
> Subject: [PATCH] dracut.sh: Support early microcode loading.
> 
> Implement it per Linux kernel Documentation/x86/early-microcode.txt
> (from v3.11-rc0):
> 
> <start>
> Early load microcode
> ====================
> By Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> Kernel can update microcode in early phase of boot time. Loading microcode early
> can fix CPU issues before they are observed during kernel boot time.
> 
> Microcode is stored in an initrd file. The microcode is read from the initrd
> file and loaded to CPUs during boot time.
> 
> The format of the combined initrd image is microcode in cpio format followed by
> the initrd image (maybe compressed). Kernel parses the combined initrd image
> during boot time. The microcode file in cpio name space is:
> on Intel: kernel/x86/microcode/GenuineIntel.bin
> on AMD  : kernel/x86/microcode/AuthenticAMD.bin
> 
> During BSP boot (before SMP starts), if the kernel finds the microcode file in
> the initrd file, it parses the microcode and saves matching microcode in memory.
> If matching microcode is found, it will be uploaded in BSP and later on in all
> APs.
> 
> The cached microcode patch is applied when CPUs resume from a sleep state.
> 
> There are two legacy user space interfaces to load microcode, either through
> /dev/cpu/microcode or through /sys/devices/system/cpu/microcode/reload file
> in sysfs.
> 
> In addition to these two legacy methods, the early loading method described
> here is the third method with which microcode can be uploaded to a system's
> CPUs.
> 
> The following example script shows how to generate a new combined initrd file in
> /boot/initrd-3.5.0.ucode.img with original microcode microcode.bin and
> original initrd image /boot/initrd-3.5.0.img.
> 
> mkdir initrd
> cd initrd
> mkdir -p kernel/x86/microcode
> cp ../microcode.bin kernel/x86/microcode/GenuineIntel.bin (or AuthenticAMD.bin)
> find . | cpio -o -H newc >../ucode.cpio
> cd ..
> cat ucode.cpio /boot/initrd-3.5.0.img >/boot/initrd-3.5.0.ucode.img
> <end>
> 
> That is what we do in the patch. Furthermoere there is also
> an off-switch: "no-early-microcode" to disable it.
> 
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> [v1: Support --host-only parameter]
> ---
>  dracut-functions.sh |   33 +++++++++++++++++++++++++++++++++
>  dracut.sh           |   46 ++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 75 insertions(+), 4 deletions(-)
> 

Pushed to dracut git HEAD, but disabled by default, also added the
--early-microcode option and bash cimpletion.

Man pages still need documentation.

lsinitrd only displays the microcode files at the moment of course.
This is tricky to solve. Any ideas?


