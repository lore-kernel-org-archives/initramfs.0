From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: 13 NFS syntax variations
Date: Wed, 17 Jun 2009 22:42:55 -0400
Message-ID: <4A39A9AF.6070009@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

I ask the contributors again, please consider that we should reduce 
redundant ways of configuring dracut as much as possible.  Please 
consider that this code will ship in various products for the next 
decade.  Is it really a good idea to confuse people by having 
documentation and examples floating around be in several different 
formats?  Sure we developers can understand 13 different syntax 
variations, but this is a lot more complicated to users trying to 
understand examples they find.

Here seems to be every possible dracut NFS syntax variation.

Group A
root=[<server-ip>:]<root-dir>[:<nfs-options>]
root=nfs:[<server-ip>:]<root-dir>[:<nfs-options>]
root=nfs4:[<server-ip>:]<root-dir>[:<nfs-options>]

Group B
netroot=[<server-ip>:]<root-dir>[:<nfs-options>]
netroot=nfs:[<server-ip>:]<root-dir>[:<nfs-options>]
netroot=nfs4:[<server-ip>:]<root-dir>[:<nfs-options>]

Group C
root=dhcp
	DHCP root-path=[<server-ip>:]<root-dir>[:<nfs-options>]
	DHCP root-path=nfs:[<server-ip>:]<root-dir>[:<nfs-options>]
	DHCP root-path=nfs4:[<server-ip>:]<root-dir>[:<nfs-options>]

Legacy nfsroot.txt
root=/dev/nfs nfsroot=[<server-ip>:]<root-dir>[,<nfs-options>]

Legacy Variations
root=/dev/nfs4 nfsroot=[<server-ip>:]<root-dir>[,<nfs-options>]
root=nfs nfsroot=[<server-ip>:]<root-dir>[,<nfs-options>]
root=nfs4 nfsroot=[<server-ip>:]<root-dir>[,<nfs-options>]

DHCP Fallbacks
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=Documentation/filesystems/nfsroot.txt
Seewer's code seems to implement various DHCP-derived fallbacks as 
documented from this ancient method.  I suppose this is OK, except:

* The fallbacks should kick-in only if server-ip is blank from root= or 
DHCP root-path.

> 54   If the `nfsroot' parameter is NOT given on the command line,
> 55   the default "/tftpboot/%s" will be used.

* We should do this only in the case where root=/dev/nfs, or not do it 
at all.  A hard-coded "/tftpboot" root-dir override in the modern 
syntaxes makes no sense.

* We should however support the %s substitution in exactly the same way 
as the kernel.  Looking at our current code though, it seems we don't. 
The docs don't do hostname.

What should we cut?

1) The most obvious to cut are the Legacy Variations.  Why should
dracut invent three new syntaxes and immediately declare them Legacy? 
Removing these would be the simplest.

2) Harald and I think we should cut Group B.  The netroot= syntax is 
necessary only for remote block device protocols like iscsci and nbd 
when you want to use LVM or crypto on those block devices.  For NFS it 
is only redundant.

Removing these would be a bit complex surgery because netroot= is 
tightly ingrained into the current code.

3) I personally think we should cut the "nfs:" prefixed syntaxes from 
Group A, B and C because they have no precedent and we're better off 
with fewer variations.  Others have disagreed though.

Any further thoughts on this?

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
