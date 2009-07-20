From: Jacek Danecki <Jacek.Danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Activating dmraid array for isw format in initrd
Date: Mon, 20 Jul 2009 12:08:17 +0200
Message-ID: <4A644211.1010702@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi,

In RHEL 5.4 during installation on raid 1 using dmraid with isw format, 
in initrd there are these lines for dmraid activation and mounting root-filesystem.

echo Scanning and configuring dmraid supported devices
dmraid -ay -i -p --rm_partitions "isw_isw_dcbgecbfbe_Volume0"
kpartx -a -p p "/dev/mapper/isw_isw_dcbgecbfbe_Volume0"
resume LABEL=SWAP-isw_dhaacf
echo Creating root device.
mkrootdev -t ext3 -o defaults,ro /dev/mapper/isw_isw_dcbgecbfbe_Volume0p1

What about situation if user went to OROM and added spare?
The name of volume will be changed.

Before entering to OROM array has name:
/dev/mapper/isw_isw_dcbgecbfbe_Volume0
After:
/dev/mapper/isw_gchbjccfi_Volume0
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
