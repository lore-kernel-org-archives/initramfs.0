From: Joe Lawrence <Joe.Lawrence-7+ureL1bLXNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Out of tree drivers missing from initramfs
Date: Wed, 23 Jan 2013 09:58:17 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1301230952460.31163@jlaw-desktop.mno.stratus.com>
References: <alpine.DEB.2.02.1301221612280.31163@jlaw-desktop.mno.stratus.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.02.1301221612280.31163-ceYW5R1vr2hcrvxNGtJwk767FWEIOpWeVpNB7YpNyf8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Lawrence <Joe.Lawrence-7+ureL1bLXNBDgjK7y7TUQ@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 22 Jan 2013, Joe Lawrence wrote:

> Hello Harold / list,

s/Harold/Harald/  (apologies for the typo)

> 
> I'm trying to build an initramfs that includes an out-of-tree kernel 
> module for the mpt2sas driver without much success (by default).

Follow up info, modules.dep entry might be relevant:

# grep mpt2sas /lib/modules/3.8.0-rc4.sra+/modules.dep
updates/lsb-ft/extra/mpt2sas/mpt2sas.ko: kernel/drivers/scsi/raid_class.ko updates/lsb-ft/extra/sd_mod.ko updates/lsb-ft/extra/scsi_hbas.ko kernel/drivers/scsi/scsi_transport_sas.ko

Regards,

-- Joe
