From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: initrd-xxx.img create dracut not correct
Date: Tue, 12 Mar 2013 10:12:03 +0100
Message-ID: <513EF163.3020106@redhat.com>
References: <513964D9.7060700@gmail.com> <51398CEE.5090502@redhat.com> <513C528C.2010200@gmail.com> <513DA469.80505@redhat.com> <513E8164.8000908@gmail.com> <513EE93F.1090909@redhat.com> <513EF097.4040405@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <513EF097.4040405-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: yeyouqun <yeyouqun1981-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

> [root@localhost mnt]# modprobe -a -d / --ignore-install --show-depends
> --set-version 3.8.2 xor
> insmod ///lib/modules/3.6.10/kernel/crypto/xor.ko

This seems like a bug in modprobe!!
