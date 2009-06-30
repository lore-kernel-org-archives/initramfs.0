From: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: create empty directory
Date: Tue, 30 Jun 2009 21:14:56 +0100
Message-ID: <1246392896.5695.22.camel@polyethylene>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:subject:from:to
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=5y9pznS7sY4n9QXa6+IDeUwimThfwgv2BMtKWIrr6LA=;
        b=EKBm/PHuc03Q7VPGvNEFlXVSQIJWZaT/xMnitQrhvPA1V7JggOGR6RJE06pgSUYmo6
         72nvW0pxHHQSjrHLgMh1LdhaAuQXY3ZteBs+eNkPLn4Pm4kaDo1I1giOWYRAH2dmEtGq
         O7rY3wAutaUoVPdVmSAuSWkZmogHLsNfcCkHk=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi,

I'm creating a dracut module.
What's the suggested way to create an empty directory in the initramfs
from the install script?

This will be used as a mount point by scripts in my module. I realise I
could just mkdir it during boot, but it would seem better to create it
in the initramfs.

Thanks,
Daniel


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
