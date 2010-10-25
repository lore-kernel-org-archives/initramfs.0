From: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: udev question
Date: Mon, 25 Oct 2010 18:46:19 +0100
Message-ID: <4CC5C26B.9060002@googlemail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=Lf2cPMqUr6fMOFTbVGaDq/ZjtMrPpNKt+EjtEKa4LxU=;
        b=gZfdMn10RZRZqOFx8jQanequ8kud3eGh8H7ijIkwS/gWgUNq/OV1Zm4ZFO+WFmZ+np
         xm6wwlS0+4IBsy/bz9UTgmCHBfA+p7NcTxJd0tRLs6g1BVZ8Y/ui9soXu1qDqcvJcvMP
         CdY8x5Bq1bK+N5jTwmE5B20Exr5N1nuNuT5Ng=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

A simple question: in /etc/udev/rules.d/ (on the root partition!) I have 
a .rules file for one of my smartcard devices which has, among other 
things, this statement:

PROGRAM="/bin/sleep 0.1"

This program is not on the initramfs image, but it is in the /bin 
directory on the root partition. I was under the impression that root is 
not mounted until udev has finished its job - is that not the case? If 
so, how is this program executed then? I also have a lot of other 
statements with RUN+=... which also refer to executables not present in 
initramfs - they are all present in the root partition. When/How do 
these execute then?

Am I missing something fundamental here?
