From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Redundant nfsroot cmdline options
Date: Mon, 15 Jun 2009 15:46:24 -0400
Message-ID: <4A36A510.5010709@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dave Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>

http://sourceforge.net/apps/trac/dracut/wiki/commandline

I am concerned about the proliferation of too many redundant ways of 
configuring netboot.  We should clearly document each supported method 
on this Wiki page and figure out which methods should be cut.  The most 
obvious methods to cut are NEW inventions of dracut that are redundant 
to other methods.

modules.d/95nfs/parse-nfsroot.sh
> case "$root" in
>     nfs|dhcp|'')
>         if getarg nfsroot= > /dev/null; then
>             root=nfs:$(getarg nfsroot=)
>         fi
>         ;;
>     nfs4)
>         if getarg nfsroot= > /dev/null; then
>             root=nfs4:$(getarg nfsroot=)
>         fi
>         ;;
>     /dev/nfs|/dev/nfs4)
>         if getarg nfsroot= > /dev/null; then
>             root=${root#/dev/}:$(getarg nfsroot=)
>         else
>             root=${root#/dev/}
>         fi
>         ;;
> esac

root=/dev/nfs nfsroot=...

* Documentation/filesystems/nfsroot.txt documents this method.  This 
method as documented requires kernel options that no distribution uses, 
to have a netboot kernel that bypasses initrd to find its filesystem 
from cmdline options.
* This is the only native method supported by Debian's initramfs-tools, 
where it is emulated.
* Red Hat/Fedora kernels nor mkinitrd has never supported this method.


This old syntax should be tolerated as legacy and supported by dracut. 
We should NOT however invent multiple redundant syntaxes derived from 
this legacy.

root=nfs       nfsroot=...
root=nfs4      nfsroot=...
root=/dev/nfs4 nfsroot=...

These are all new inventions in dracut, redundant to the following 
native methods already supported.

NFSv3
root=[<server-ip>:]<root-dir>[:<nfs-options>]
root=dhcp DHCP root-path=[<server-ip>:]<root-dir>[:<nfs-options>]

NFSv4
root=nfs4:[<server-ip>:]<root-dir>[:<nfs-options>]
root=dhcp DHCP root-path=nfs4:[<server-ip>:]<root-dir>[:<nfs-options>]

Are there any cases not possible by these syntaxes?

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
