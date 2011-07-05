From: "Prashant Batra (prbatra)" <prbatra-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Subject: initramfs building
Date: Tue, 5 Jul 2011 13:35:56 +0530
Message-ID: <B97B134FACB2024DB45F524AB0A7B7F203BBD010@XMB-BGL-419.cisco.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=prbatra-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org; l=470; q=dns/txt;
  s=iport; t=1309853162; x=1311062762;
  h=mime-version:content-transfer-encoding:subject:date:
   message-id:from:to;
  bh=FJ704ZTzTqTuv/Al2C+Awb5KScrjzJ6IKOHisk1vRKQ=;
  b=Btikz3K+qbacPnn0B3ahUIYB0NXmcLSVARWyBdk554E3ODGRbooaVIcI
   yTkJLtde6UQJl6gV0+g/l0OVVpT+y+mBckoZg75yOcqAnMgXPmEKKpVi2
   SDeF/W8yrRr/j9k2hjBBcgtQnlVLmunijdGBulwwSBRwnzeq12p6QTkSC
   k=;
Content-class: urn:content-classes:message
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi, 

To build a initramfs image as part of kenel, the path to the build image
is needed. 
But if you start of a fresh kernel, you can not have the ramfs image
built for that kernel.

So, the way is to build the kernel, install all the modules into
/lib/modules/version folder, then build the initramfs image, include the
path in kernel config and again build kernel image.

Is this correct or there is a better procedure?

Regards, 
Prashant Batra
