From: Vasiliy Tolstov <v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org>
Subject: live rootfs from squashfs and read write ability
Date: Wed, 21 May 2014 16:51:14 +0400
Message-ID: <CACaajQsj71mL4BciOPaNTx2wN_A2SiBM=babpsUK5QGzQ2Yreg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=selfip.ru; s=google;
        h=mime-version:sender:from:date:message-id:subject:to:content-type;
        bh=zGRDBsoTY4vQQUmCSPnC+PvhFcgUDQ7VYeUSEllr3Ic=;
        b=F3wXqqCtYyVZS+7+sOMLp1qgD5WI4MFr+6RPP3Ohj6+edFJF8WWGhxG1DmVVH2k8d8
         R0XxmVeBWzSlDtMaldNOjvWPjho+q9s5ktcwW7iy3me9A/w7+L9inpiQmtdoyiuX2jw0
         mWYtveRJwIUM38XbAlXTOowlizDwmCBbkL7gM=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hello! I'm very happy with dracut (i'm create live squashfs image and
boot it), but as i see i have my root in read only mode. How can i get
route in read/write mode (in ram).
My cmdline like:
bond=bond0:eth0,eth1:mode=6 net.ifnames=0 ip=bond0:auto6 rd.bootif=0
rd.md=0 rd.dm=0 rd.lvm=0 rd.luks=0 rd.shell
root=live:http://[2001:db8:0:f101:92e2:baff:fe31:44e]/image/mh-vm/image.squashfs
console=tty0 console=ttyS1,115200 rw

-- 
Vasiliy Tolstov,
e-mail: v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org
jabber: vase-+9FY0jupvH6HXe+LvDLADg@public.gmane.org
