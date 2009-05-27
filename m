From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: How do we want to handle configuring network boot devices?
Date: Wed, 27 May 2009 17:54:30 -0400
Message-ID: <4A1DB696.9060807@redhat.com>
References: <1243126816.4217.248.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1243126816.4217.248.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 05/23/2009 09:00 PM, David Dillow wrote:
> * I haven't found other initramfs's using NBD, but I've not searched
> 	very hard.

Debian/Ubuntu's initramfs-tools allows you to hard-code a NBD server and 
port during initrd generation.

>
> NFS
> * Kernel command line, as documented in Documentation/filesystems/nfsroot.txt
> 	root=/dev/nfs
> 	nfsroot=[ip:]path[,options]
> 		Replaces %s in path with text IP address
> 		If option missing, path defaults to "/tftpboot/%s"
> 		If IP is missing, uses server address from ip= line

This is an abomination.  I haven't anyone ever use this.  In-kernel dhcp 
client?  How do you control which interface to use?  Seems like a lot of 
room for error.  Also it seems this relies on having no initrd, 
bypassing other things you may want to do before mounting rootfs like 
load policy?

Options:
1) Re-implement it entirely in dracut without relying on the kernel 
implementation.  But will it work?  The kernel seeing root=/dev/nfs will 
try to do its own thing anyway?
2) Drop this entirely.  If somebody chooses to use this method of nfs 
boot dracut isn't involved.

> * DHCP root-path option, with varying forms
> 	Using next-server or server-id opt and root-path as pure path:
> 		${next_server-${server_id}}:${root_path}

This particular method is ambiguous, why next-server or server-id?

I think we should seriously consider that we shouldn't be concerned with 
every possible legacy method of setting up nfsroot.  Each generation of 
software has the opportunity to configure itself in the way that it 
needs.  What scenarios are there where this isn't true?

I mean, if you use old software, don't use dracut.

> Debian style syntax. With the base device being an optional number to indicate
> the nbd device to use.
>
> 	root=/dev/nbd[0-9]* nbdroot=server.ip.add.ress,port[,nbd basedevice]

This is from Andreas' suggested patch for nbd root, where this is the 
third supported method of booting nbd.  I think we should DROP this. 
The reason for this is it used to be necessary to define a specific nbd 
device number because old versions of nbd-client did not have a method 
to detect if a nbd device is already connected and in-use.  Modern 
versions do not have this problem.  Code using it simply iterates 
looking for the first unused nbd device.

The ability to specify a nbd mount point with cmdline should be using 
the new syntax.  We should drop this old syntax because it is redundant, 
and more error prone.

> 	Using root-path as full info:
> 		server:path
> 	Current dracut uses DHCP root-path option:
> 		nfs://server/path

Where did this syntax come from?  Is there precedent?  If not, I don't 
think Dracut should be inventing something new only because it visually 
looks better.

> 	My udev nfsroot patchset uses DHCP root-path option with command line override:
> 		[ip:]path[:options]

What are possible options for nfs?

>
> URI scheme proposed at http://apps.sourceforge.net/trac/dracut/wiki/commandline
> 	root=nfs://server:port/path
> 	root=nbd://server:port/path
> 	root=iscsi://server:port/target

(Same note as above, I don't think Dracut should be inventing new syntax 
only because it looks better, especially when it is functionally less 
expressive than the existing RFC's and implementations.)

> Open issues:
> * How to handle authentication data for iSCSI and NFS, if at all.

Does this always involve certificates or keys?  If so, we might have no 
option but to make it embedded in the initrd during generation.

> * How to handle unionfs/aufs mounts?

Debian/Ubuntu and possibly others will demand this, as this is their 
solution to read-only root netboot.  How to sanely define this in the 
initrd while still maintaining a generalized initrd?  Perhaps not possible.

> * How to handle dm-snapshot, eg for LiveCD overlays.

Same problem as above.

> * FCoE/AoE/DBRD/SRP -- I didn't search for examples on these.
> * Lustre/network filesystem du jour support -- I think these are
> possible, just need to be careful parsing things out. Not
> terribly important right now.

Define a sane standard for our existing protocols first, then it might 
become more clear what we should do for others?

> * Using the dracut URI scheme above as a strawman, shouldn't
> "root=nfs://...." imply "ip=dhcp" if none is given?

ip=dhcp should be implied if you specify root=dhcp or any other option 
that needs dhcp to go online, while not otherwise specified static.

> * What about multiple devices?

AFAIK nothing out there supports booting from the second interface.  Am 
I wrong?

> * How many legacy ways of doing this should we support?

I am suggesting *NONE* for the above reasons.

> * How do we separate options to the network block transport vs the
> filesystem mount?

What network block transport options are you talking about?

> * How do we allow use of these features both via the cmdline and via
> DHCP?

root=(what would come from root-path?)

If that clashes with in-kernel stuff, we could define our own:

root-path=(what would come from root-path)

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
