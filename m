From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: some $prefix issues
Date: Fri, 30 Sep 2011 03:03:15 +0200
Message-ID: <4E851553.6050806@ziu.info>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Current code allows customization of $prefix, but init still has 
hardcoded /run/initramfs path - so outside of setting prefix to that 
particular path its use is kinda limited (without making init aware of 
$prefix).

Another thing is, that inst*() family of functions have no notion of 
$prefix at all, so - especially subsequent - calls to those functions 
will not really care. This could in certain cases lead to frictions, for 
example:

Suppose we have (on host):
/bin -> usr/bin

We run dracut with:
--prefix=/run/intiramfs

In part of the code preparing basic directory layout:
...
$initdir/usr -> run/initramfs/usr
...
will be pre-created (and dangling at this point)

As bin is a symlink on the host (and dracut tries to mimic host's layout 
(?), we will have):
inst() /bin $prefix/bin
which will call inst_symlink() with same arguments, effectively leading to:
src: /bin
realsrc: /usr/bin
target: $initdir$prefix/bin

There will be attempt to create $initdir/usr/bin, but there's already 
(dangling) symlink and mkdir attempt (after readlink) will fail.

This can be easily verified by making on the host:
/binn -> usr/binn
And adding binn to the relevant layout-creating loops, which will lead 
to something like:
mkdir: cannot create directory `/var/tmp/initramfs.C2ifhw/usr': File exists

Last thing - /run remains mounted inside intramfs after mount --bind 
currently. With simple /run symlink to movable mount and without being 
forced to care if it suddenly loses binaries - it could be cleanly moved 
to real root almost atomically.

It's all fixable in one or the other way, but is --prefix functionality 
actually needed for something specific ? after pivot peeking/extracting 
is just a matter of cat/cpio or lsinitrd, or anything similar.
