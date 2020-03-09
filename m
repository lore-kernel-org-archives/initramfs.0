From: Erik Moqvist <erik.moqvist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: rootfs removed when opening a socket
Date: Mon, 9 Mar 2020 08:44:28 +0100
Message-ID: <CAPZf9tBFHTjnyV+fO61ppyt4cXurcnzedbgWJEsbSPb6zeKKdw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=J8BDkUviubuXHHp3nE1WUFa2w7R0tHMek/fh2Yll4mI=;
        b=lkIC2vmZYVdI8KLl0b+oaJite4ef46HuGXEuh9hyRt+FnhuW+v0K2Pfv6mp2RvJxdn
         kWBIYn+PC2p7WpRTT4CbHGONzaoLVzPO1vSVIoQhpEc6YoVv59OG+p+gygrKHtyP3OLn
         CtDs6aDue8yi8AMwF+fTYjMF61KcB4PuKRXSSYoa6tmKA8YvRKYtldsEQj6C4cihPJba
         l8oqxnNMTJtzLfEu0b8CrCw2huGLm5hW6LbN14yCZfN/iZKCef+mHDAJ6YkUTjPGJahd
         XRZnqaOfY464yQxLzG+1TlseqWZRgXW0FRRLXPTkBerAVKCSK90dW8dqxGedHJVjBNLE
         oOTQ==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello!

I'm working on a minimal embedded system where I intend to use the
initramfs as rootfs with /init implementing the entire system. I have
no need to mount another file system as rootfs.

Yesterday I noticed that the rootfs was removed about 10 minutes after
power on. It was just gone. After a few hours of debugging I noticed
that inodes started to be evicted at the same time as the rootfs was
removed. It turned out that my application periodically opens sockets
which are never closed, and as each socket allocates an inode, the
system eventually runs out of inodes (I think) and starts evicting old
ones to be able to open another socket. Now, as I understand it, the
evicted inodes were used by the rootfs, which could explain why the
rootfs was removed.

I am a bit surprised that opening a socket can result in removing the
rootfs. Is this the intended behavior?

I'm using kernel 5.5.7 with a minimal configuration on X86_64 QEMU.
The configuration can be found here:
https://github.com/eerimoq/monolinux-example-project/blob/master/app/linux-x86_64.config

/ Erik
