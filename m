From: Renjun Qu <renjunqu.kernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: (unknown)
Date: Tue, 25 Oct 2011 13:55:53 +0800
Message-ID: <CAPu47WTjxrrF+tHGRJOgKohD-sijBvX8iC-gBUnbsRw_KS4K5g@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=h1mOAlUp8IMIs/dIDv9guJ9VW4ZALFfsejFDEqamauo=;
        b=QCPV/myHnUW8mnc7rDd9tb1QVPyhfp5WTFqQojZCwDinlJqMlmsKMZSX/82KzXxi2T
         TT8Mk3BAj8ZqWzAGC4nH3p6ZChLMtwpvuVUl8R95R3qYS0EGekGmZEZOh9EOcuLgtBoO
         0xqZJzVcRaDMozZ2f7trvzstlGfE3tIM0FQUo=
Subject: 
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello everyone:
         I am building a small embedded linux system right now. I
confused that why the default rootfs must has a "dev/console" node. I
have made a experiment as follow:
        1st, configure the kernel(2.6.32) to support the initramfs
and initrd, and set the source of the initramfs to a directory which
only has a "root" node.
        2nd, configure the kernel to support the root file system on
nfs, and rebuild the kernel. I have created all necessary files and
directories in the directory exported by the nfs server.
        3rd,  set the appropriate boot parameter, and boot my kernel.
        The result is, the kernel can successfully mount the root
file system, but the "/sbin/init" program can not print any
information to me. My "sbin/init" program is just a hello world
program which only print some greeting information.There is a
"dev/console" device node in the nfs exported directory.
        But if i set the source of the initramfs to empty, and redo
my experiment from the 2nd step,everything will be ok. So, i think
there must be a =93dev/console=94 node in the rootfs. The real root fil=
e
system already has a "dev/console" node, why default rootfs must have
a dev/console node. Please help me.

                         Best regards,

                            Ren jun Qu
