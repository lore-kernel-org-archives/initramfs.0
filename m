From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: How do we want to handle configuring network boot devices?
Date: Wed, 27 May 2009 20:23:14 -0400
Message-ID: <1243470194.23466.32.camel@obelisk.thedillows.org>
References: <1243126816.4217.248.camel@obelisk.thedillows.org>
	 <4A1DB696.9060807@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A1DB696.9060807-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, 2009-05-27 at 17:54 -0400, Warren Togami wrote:
> On 05/23/2009 09:00 PM, David Dillow wrote:
> > * I haven't found other initramfs's using NBD, but I've not searched
> > 	very hard.
> 
> Debian/Ubuntu's initramfs-tools allows you to hard-code a NBD server and 
> port during initrd generation.

Yes, Julien was kind enough to post the scripts that handle this for
Debian.

> > NFS
> > * Kernel command line, as documented in Documentation/filesystems/nfsroot.txt
> > 	root=/dev/nfs
> > 	nfsroot=[ip:]path[,options]
> > 		Replaces %s in path with text IP address
> > 		If option missing, path defaults to "/tftpboot/%s"
> > 		If IP is missing, uses server address from ip= line
> 
> This is an abomination.  I haven't anyone ever use this. In-kernel dhcp 
> client?  How do you control which interface to use? 

ip= lines are also parsed by the kernel and can be used for this.

> Seems like a lot of 
> room for error.  Also it seems this relies on having no initrd, 
> bypassing other things you may want to do before mounting rootfs like 
> load policy?
> 
> Options:
> 1) Re-implement it entirely in dracut without relying on the kernel 
> implementation.  But will it work?  The kernel seeing root=/dev/nfs will 
> try to do its own thing anyway?
> 2) Drop this entirely.  If somebody chooses to use this method of nfs 
> boot dracut isn't involved.

Well, yes, Warren. If the kernel has CONFIG_ROOT_NFS set and sees these
options, I expect the initrd will not be used. But I don't think any
distro that dracut would support has this set. Certainly it has caused
no problems in my writing and testing the nfsroot code I did last month.

> > * DHCP root-path option, with varying forms
> > 	Using next-server or server-id opt and root-path as pure path:
> > 		${next_server-${server_id}}:${root_path}
> 
> This particular method is ambiguous, why next-server or server-id?

If next-server is set, use it. If not, use server-id. This method has
been long used and is unambiguous. 

> I think we should seriously consider that we shouldn't be concerned with 
> every possible legacy method of setting up nfsroot.  Each generation of 
> software has the opportunity to configure itself in the way that it 
> needs.  What scenarios are there where this isn't true?
> 
> I mean, if you use old software, don't use dracut.

This isn't about using old software, it is about allowing old
configuration methods to work so that dracut can be a drop in
replacement. I'm not saying these are all good ways to do it, or that we
necessarily need to support all of them, but if they are easy to map to
our solution once we choose it, then it makes sense to do so.

It's nice when software is usable without having to read all of the
documentation -- in many ways, this allows a dracut-enabled distro to be
dropped into place in an existing DHCP environment, which may have
thousands of nodes using the existing syntax.

Is it a requirement to support legacy methods? Probably not, but again,
I think we should consider the pain involved in doing it. If it is low,
then perhaps it makes sense.

If other people chime in and agree with you about dropping legacy
methods, then I'll happily shut up about it and not worry about
compatibility. While easy, it is code to written.

> > 	Using root-path as full info:
> > 		server:path
> > 	Current dracut uses DHCP root-path option:
> > 		nfs://server/path
> 
> Where did this syntax come from?  Is there precedent?  If not, I don't 
> think Dracut should be inventing something new only because it visually 
> looks better.

I thought that came from you. Harold maybe?

> > 	My udev nfsroot patchset uses DHCP root-path option with command line override:
> > 		[ip:]path[:options]
> 
> What are possible options for nfs?

man 5 nfs, or look through fs/nfs/nfsroot.c in the kernel source. There
are several, and many get used often to meet the needs of the
environment.

> > * Using the dracut URI scheme above as a strawman, shouldn't
> > "root=nfs://...." imply "ip=dhcp" if none is given?
> 
> ip=dhcp should be implied if you specify root=dhcp or any other option 
> that needs dhcp to go online, while not otherwise specified static.

Agreed, unless ip= lines are supplied in which case they should
override.

> > * What about multiple devices?
> 
> AFAIK nothing out there supports booting from the second interface.  Am 
> I wrong?

gedi-tools.sf.net will boot from whatever interface and remap it to
eth0. You yourself were complaining about issues with wireless. I have
several machines in which the interface they should boot of off is not
eth0, and it is not possible to swap the order of the cards.

Besides, it is already implemented, sans bugs from my forward port.

> > * How do we separate options to the network block transport vs the
> > filesystem mount?
> 
> What network block transport options are you talking about?

I'm holding open the possibility that there are some. iSCSI may have
some, but I am not that familiar with it. NBD does not; I don't know
about DBRD. SRP does have options that would need to be handled, but
that could be dealt with later.

Mainly, I think this is just another nail in the coffin of the URI
type:// syntax.



--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
