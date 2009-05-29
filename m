From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: TODO: instmods() firmware is broken
Date: Fri, 29 May 2009 18:22:33 -0400
Message-ID: <4A206029.9050307@redhat.com>
References: <4A1EE0B7.4030907@redhat.com> <1243598095.31156.6.camel@sentry-no.fnordovax.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1243598095.31156.6.camel-76q0VzFBGGr21HsLBtNmTckMGDeJXHgy@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 05/29/2009 07:54 AM, Victor Lowther wrote:
> Or to call modinfo only when instmods is actually installing a module,
> and not when it is expanding module shorthand.
>
> Which is what one of the patches I just pushed to the repo does.

So looks like not a bug, but is it really necessary to print all this?

W: Possible missing firmware /lib/firmware/FW13 for module b43.ko
W: Possible missing firmware /lib/firmware/iwlwifi-5150-1.ucode for 
module iwlagn.ko
W: Possible missing firmware /lib/firmware/isl3886pci for module p54pci.ko
W: Possible missing firmware /lib/firmware/isl3887usb for module p54usb.ko
W: Possible missing firmware /lib/firmware/isl3886usb for module p54usb.ko
W: Possible missing firmware /lib/firmware/FW10 for module b43legacy.ko
W: Possible missing firmware /lib/firmware/i2400m-fw-sdio-1.4.sbcf for 
module i2400m-sdio.ko
W: Possible missing firmware /lib/firmware/i2400m-fw-usb-1.4.sbcf for 
module i2400m-usb.ko
W: Possible missing firmware /lib/firmware/FW13 for module b43.ko
W: Possible missing firmware /lib/firmware/FW10 for module b43legacy.ko
W: Possible missing firmware /lib/firmware/isl3886pci for module p54pci.ko
W: Possible missing firmware /lib/firmware/isl3887usb for module p54usb.ko
W: Possible missing firmware /lib/firmware/isl3886usb for module p54usb.ko
W: Possible missing firmware /lib/firmware/aic94xx-seq.fw for module 
aic94xx.ko
W: Possible missing firmware /lib/firmware/ql8100_fw.bin for module 
qla2xxx.ko
W: Possible missing firmware /lib/firmware/ql2500_fw.bin for module 
qla2xxx.ko
W: Possible missing firmware /lib/firmware/ql2400_fw.bin for module 
qla2xxx.ko
W: Possible missing firmware /lib/firmware/ql2322_fw.bin for module 
qla2xxx.ko
W: Possible missing firmware /lib/firmware/ql2300_fw.bin for module 
qla2xxx.ko
W: Possible missing firmware /lib/firmware/ql2200_fw.bin for module 
qla2xxx.ko
W: Possible missing firmware /lib/firmware/ql2100_fw.bin for module 
qla2xxx.ko
101213 blocks
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
