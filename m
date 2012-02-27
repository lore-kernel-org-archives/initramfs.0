From: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Subject: Re: [PATCH] Use modinfo to gather module dependencies
Date: Mon, 27 Feb 2012 11:29:56 +0000
Message-ID: <jifpfl$hof$1@dough.gmane.org>
References: <2369135.eJzU9GBXlg@ernie> <4F4B5A00.2060400@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F4B5A00.2060400-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

'Twas brillig, and Harald Hoyer at 27/02/12 10:25 did gyre and gimble:
> Am 25.02.2012 22:09, schrieb Dennis Schridde:
>> Hello!
> 
>> I just switched from module-init-tools to kmod and found dracut broken, 
>> because it uses modprobe --show-depends to find out about module locations
>> and dependencies, which apparently is not implemented in kmod.
> 
>> Hence I wrote attached patch, switching from modprobe to modinfo, which
>> also seem to be the tool intended for the job. This method appears to work
>> reliable in kmod-5, but I have not tested with module-init-tools.
> 
>> Kind regards, Dennis
> 
> You need this patch for kmod:
> 
> http://git.profusion.mobi/cgit.cgi/kmod.git/commit/?id=269de2e0bf5011072da2f40f4f2d4023fad696b9

What does this patch add?

I seem to get modprobe working happily with kmod 5 even for non-loaded
modules. With patch applied or not, the output was the same.

I'd just like to understand the issue :)

Cheers

Col


(i915 is loaded, nouveau is not)


[colin@jimmy dracut (master)]$ modprobe --ignore-install --show-depends i915
insmod /lib/modules/3.2.7-desktop-1.mga2/kernel/drivers/acpi/video.ko.xz
insmod /lib/modules/3.2.7-desktop-1.mga2/kernel/drivers/i2c/i2c-core.ko.xz
insmod /lib/modules/3.2.7-desktop-1.mga2/kernel/drivers/acpi/button.ko.xz
insmod
/lib/modules/3.2.7-desktop-1.mga2/kernel/drivers/i2c/algos/i2c-algo-bit.ko.xz

insmod /lib/modules/3.2.7-desktop-1.mga2/kernel/drivers/gpu/drm/drm.ko.xz
insmod
/lib/modules/3.2.7-desktop-1.mga2/kernel/drivers/gpu/drm/drm_kms_helper.ko.xz

insmod
/lib/modules/3.2.7-desktop-1.mga2/kernel/drivers/gpu/drm/i915/i915.ko.xz
i915_enable_fbc=0
[colin@jimmy dracut (master)]$ modprobe --ignore-install --show-depends
nouveau
insmod /lib/modules/3.2.7-desktop-1.mga2/kernel/drivers/acpi/button.ko.xz
insmod /lib/modules/3.2.7-desktop-1.mga2/kernel/drivers/acpi/video.ko.xz
insmod
/lib/modules/3.2.7-desktop-1.mga2/kernel/drivers/platform/x86/wmi.ko.xz
insmod
/lib/modules/3.2.7-desktop-1.mga2/kernel/drivers/platform/x86/mxm-wmi.ko.xz
insmod /lib/modules/3.2.7-desktop-1.mga2/kernel/drivers/i2c/i2c-core.ko.xz
insmod
/lib/modules/3.2.7-desktop-1.mga2/kernel/drivers/i2c/algos/i2c-algo-bit.ko.xz

insmod /lib/modules/3.2.7-desktop-1.mga2/kernel/drivers/gpu/drm/drm.ko.xz
insmod
/lib/modules/3.2.7-desktop-1.mga2/kernel/drivers/gpu/drm/drm_kms_helper.ko.xz

insmod
/lib/modules/3.2.7-desktop-1.mga2/kernel/drivers/gpu/drm/ttm/ttm.ko.xz
insmod
/lib/modules/3.2.7-desktop-1.mga2/kernel/drivers/gpu/drm/nouveau/nouveau.ko.xz




-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited http://www.tribalogic.net/
Open Source:
  Mageia Contributor http://www.mageia.org/
  PulseAudio Hacker http://www.pulseaudio.org/
  Trac Hacker http://trac.edgewall.org/
