From: Akos Ovari <ovari.akos-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Minimal initramfs Modification
Date: Thu, 1 Oct 2015 10:56:22 +0000 (UTC)
Message-ID: <loom.20151001T125053-733@post.gmane.org>
References: <CAAZEOjsyDkv0ai9a96Jg0M7tX5hAKUXMgHW7NiAugf7Sf_xnEw@mail.gmail.com> <55B151B0.5020100@gmail.com> <CAAZEOjsavzT1GsBMENe9AbHYDUhrhbS5OWaZ4tpuqe7383GO3A@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Rick,

You can extract initramfs on RHEL7/CentOS7 with this:

/usr/lib/dracut/skipcpio initramfs-3.10.0-123.el7.x86_64.img |zcat| cpio -id 
--no-absolute-filenames

Bye
Akos
