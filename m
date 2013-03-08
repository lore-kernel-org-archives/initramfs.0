From: yeyouqun <yeyouqun1981-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: initrd-xxx.img create dracut not correct
Date: Fri, 08 Mar 2013 12:11:05 +0800
Message-ID: <513964D9.7060700@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=wp32qp3l/O3/1s6piIfkkMwDQf7w02/y8UGIc0yhdNE=;
        b=G4Jz2hQFFSkP/It5ziorLAr7WFMu7Zfsa1K4CAsM3GbNkW6Cp9GezmheDO5TS0bAkH
         0rXfVYwEHWLOBxcy7mDIK5cDycXSPPCDSqw8cZtQdZH790nj2wcy4vjlVfop3fjXfZmm
         33wopctTFhkglFOtIqRZMRUTzlNDzvseEK0GO+LkdVp3u36vwBgORIoqzjewTGiaOquu
         XhUlMcJ/384hDQJpQeoHRmxdD3cn5Bea6S1eJiWJh6SCFKyYRq62pyBNXRpjlJ9aqS6O
         i4Tl56+IrgHuCXnR40f5EgSpfCCgNW+uhb6Q5ZCy66OcKEjI0MjtLg2Rypb68LI9LR6i
         mqIQ==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


Recently I upgraded linux kernel to 3.6.10 and upgrade dracut version to 
024, system starts up OK on 3.6.10. But when I upgraded kernel from 
3.6.10 to 3.8.2, dracut failed to start up the system. Message when 
start up reads:

......
    dracut: dracut-dracut-024-
     rpcbind: cannot create socket for udp6
     rpcbind: cannot create socket for tcp6
     mount: unknoun filesys
     udev: starting version 147
     systend-udevd (139): /proc/139/oom_adj is deprecated, please use
     /proc/139/oom_score_adj instead.
     dracut Warning: Could not boot.
     dracut Warning: Could not boot.
     Dropping to debug shell.
     /bin/sh: can't access tty; job control turned off
......

But when I unpack the initrd-3.8.2.img, the /lib/modules directory shows 
as below:

modules ---- 3.8.2
          |
          |__ 3.6.10

all the kernel modules reside in "3.6.10" directory and other files, 
such as "modules.dep" and etc. reside in 3.8.2, I think this is the 
reason why system can't start up.

I upgraded kernel by the steps as(in kernel source tree of 3.8.2):

     make
     make modules_install
     make install

Any one can tell how to fix this behavior of dracut?
