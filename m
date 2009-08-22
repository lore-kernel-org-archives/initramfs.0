From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Thoughts on iscsi and nbd
Date: Sat, 22 Aug 2009 13:56:34 -0500
Message-ID: <554CE824-C014-4C07-8449-5E868C0342EB@gmail.com>
Mime-Version: 1.0 (iPhone Mail 7A341)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:x-mailer:mime-version
         :subject:date;
        bh=gzLM2Pbhn5OcR+4kW9s7ckl5lb7Vex2u8JiC13pCkec=;
        b=GOU0eH9YWg1p6lGbjVq1fbY5UNBcdWuM5p5M3sxMn/5HwbiOtCVDhV4v8S0chNPaw2
         EZvdw4htOPhF5fVYg7R/3SstMrx5K4BkANJlIns2Ph21pzch7LgmhainFqnMPc7ZBL8H
         896++65hnsz6M2U5rqzxqXJBmSkGKxUgX5+Bc=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

We seem to be doing them wrong -- going by the way we specify using  
them on the kernel commandline, we appear to only support booting  
directly to an iscsi or nbd lun, with no possibility of having an lvm  
or luks layer on top of the iscsi transport.

Am I missing some important doc or piece of code that implies otherwise?


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
