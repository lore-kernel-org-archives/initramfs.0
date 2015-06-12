From: Gordan Bobic <gordan-UpbECiGlrmGsTnJN9+BGXg@public.gmane.org>
Subject: Storage Daemon in Initramfs
Date: Fri, 12 Jun 2015 15:44:39 +0100
Message-ID: <557AF057.5010309@bobich.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

I'm trying to troubleshoot an issue I'm experiencing in a scenario where 
a storage daemon that starts up in initramfs is required for rootfs.
Specifically, zfs-fuse - I'm running rootfs on zfs-fuse.

I have already read the following, and modified zfs-fuse so that it 
marks itself (argv[0][0]='@') to avoid switchr-root killing spree:
http://www.freedesktop.org/wiki/Software/systemd/RootStorageDaemons/


I can successfully boot up the rootfs, that part works.
I also mount --bind {/dev,/proc,/sys} to the rootfs before switch-root 
kicks off, along with the direcory where zfs-fuse keeps it's unix domain 
socket.

At that point almost everything works. Almost.

@sbin/zfs-fuse is running, and the other userspace tools can talk to it 
(zfs, zpool, etc.) I can list file systems and create them. But - I 
cannot mount them, and I cannot import new pools. All of this works in 
the initramfs before switchr-root (tested at point of rd.break=mount).

But after zfs-fuse daemon is below the rootfs "plane", it no longer 
works. Mount returns either error 2 (canonicalization error) if I tell 
it to mount to /sysroot/mount/point (/sysroot being where dracut mounts 
the real root), or error 5 if I tell it to mount anywhere else, as if it 
cannot find the mount point.

So what I am trying to figure out is how can I get the storage daemon 
that is running below the rootfs plane of existance to still be able to 
mount stuff into the rootfs it is responsible for after switch-root.

It seemed to work when I use a simple chroot, but switch-root seems to 
be a harder barrier to cross.
I would expect this kind of thing impacts other things and not just 
zfs-fuse, so I presume there is either a reasonly standard way of 
dealing with it, or at least a documented set of functionality that a 
storage daemon has to implement to deal with it.

Since this is a systemctl switch-root issue, I think it only affects 
systemd, and not other init systems.

What to do? Other than rebuild my entire distro without systemd (tempted 
as I am on a daily basis).

TIA

Gordan
