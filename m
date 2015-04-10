From: lyndat3-p/IIKWkZnU0S+FvcfC7Uqw@public.gmane.org
Subject: How to have dracut conditionally add different kernel modules for
 different kernels?
Date: Fri, 10 Apr 2015 12:11:53 -0700
Message-ID: <1428693113.1734218.251850073.54517680@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=your-mail.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=E/v
	aNKZwhwQx1nLAsF5weDFmH0g=; b=CfhKtJthfv94UeQ/mgU2BeeZG+/bcHm1/4k
	fk6b7cJl88ZYqWTrqGbFzzu5CupKUa8CYGeBcVJoQR4+4CPx5H1ABT9WDQhEFzy8
	+5h2ZPPB8nJv2KQQbqtsOEKoMDo66kPBfJgLUXfm0nUrf7hszl5xgLPlTp8636iY
	5BVLVbXU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=E/vaNKZwhwQx1nLAsF5weDFmH0g=; b=Sor/y
	qJWoKAjcOUWvDY1MYq+nlI5HoLVxWg4vW3dG3k4w7BI+BwSKKOkPeO9aCEA3S+dX
	YXn+DSmSBKVQqmHwFtAQZ6w/KoH7BAB9QMtCHJYcOPJgRUEHvW7nhbBAoH+8AQrL
	u32CPITYeVHI4M8kzbjTRiXOctbJRlfj1j3oNc=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The distro I use, opensuse, has switched to using dracut for initrd creation.

Prior to dracut usage, kernel-flavor-specific loading -- particularly for the case of Xen -- could be defined in

 /etc/sysconfig/kernel
  ...
  INITRD_MODULES="processor thermal ahci fan jbd ext3 edd"
  DOMU_INITRD_MODULES="xennet xenblk"
  ...

On 'old' mkinitrd, if both -xen and non-xen kernels were installed, initrd's were created for each.  In the xen case the modules defined in "DOMU_INITRD_MODULES" were conditionally added to the initrd-xen.

Since the  switch to dracut, module config/loading is defined in dracut.conf & dracut.d/*conf

But the 

add_drivers+=" ... " 

is apparently added for all kernels.

What's the right way to add kernel-specific modules in dracut, so that for example the xen mods are ONLY added in the xen case?

LT
