From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: How do we want to handle configuring network boot devices?
Date: Sat, 23 May 2009 21:00:16 -0400
Message-ID: <1243126816.4217.248.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Warren, Andreas, and I were discussing possible mechanisms for
configuring NFS, NBD, iSCSI, etc going forward, and it was suggested
that we try to document the current ways it is done, and how we may want
to go forward.

Assumptions:
* I've missed some ways of doing this; feel free to point us in the
	right direction.
* IP autoconfig follows the kernel command line described in the same
	document as Kernel nfsroot, with possible compatible extensions.
	This "ip=dhcp" and friends.

Existing standards/implementations:
iSCSI
* root selection via DHCP is documented by RFC4173
	format is iscsi:[SERVER]:[PROTO]:[PORT]:[LUN]:TARGET
	minimum config is "iscsi:::::TARGET"
* RH mkinitrd pulls iSCSI info from host system config
* There appears to be some support for "iSCSI Boot Firmware Attributes"
which may be useful, or not.
	http://en.wikipedia.org/wiki/ISCSI_Boot_Firmware_Table
	ftp://ftp.software.ibm.com/systems/support/system_x_pdf/ibm_iscsi_boot_firmware_table_v1.02.pdf

NBD
* RH mkinitrd uses the DHCP root-path option
	format is nbd:SERVER:PORT:FSTYPE[:MOUNTOPTS]
	you can specify the filsystem type to mount and
	the options to use in the DHCP option
* There does not appear to be a way to configure NBD in RH's mkinitrd
	without using DHCP
* I haven't found other initramfs's using NBD, but I've not searched
	very hard.

NFS
* Kernel command line, as documented in Documentation/filesystems/nfsroot.txt
	root=/dev/nfs
	nfsroot=[ip:]path[,options]
		Replaces %s in path with text IP address
		If option missing, path defaults to "/tftpboot/%s"
		If IP is missing, uses server address from ip= line
* DHCP root-path option, with varying forms
	Using next-server or server-id opt and root-path as pure path:
		${next_server-${server_id}}:${root_path}
	Using root-path as full info:
		server:path
	Current dracut uses DHCP root-path option:
		nfs://server/path
	My udev nfsroot patchset uses DHCP root-path option with command line override:
		[ip:]path[:options]

URI scheme proposed at http://apps.sourceforge.net/trac/dracut/wiki/commandline
	root=nfs://server:port/path 
	root=nbd://server:port/path 
	root=iscsi://server:port/target 


Open issues:
* How to handle authentication data for iSCSI and NFS, if at all.
* How to handle unionfs/aufs mounts?
* How to handle dm-snapshot, eg for LiveCD overlays.
* FCoE/AoE/DBRD/SRP -- I didn't search for examples on these.
* Lustre/network filesystem du jour support -- I think these are
possible, just need to be careful parsing things out. Not
terribly important right now.
* Using the dracut URI scheme above as a strawman, shouldn't
"root=nfs://...." imply "ip=dhcp" if none is given?
* What about multiple devices?
* How many legacy ways of doing this should we support?
* How do we separate options to the network block transport vs the
filesystem mount?
* How do we allow use of these features both via the cmdline and via
DHCP?


My commentary:
* I'd like to support the legacy way of specifying this info as much as
is reasonably possible. People are set in their ways, and it'd be nice
if dracut could just work for them.
* If we don't succeed in DHCPing/mounting the root on the first attempt,
we should loop trying, with a chance for the user to break out each time
-- think overloaded server bringing up a cluster.
* A modified URI scheme like the dracut suggestion may work; use opaque
URI's like the RFC4173 iSCSI root-path, or RH mkinitrd's nbd root-path.
We could source a specific handler for the URI type listed, making it
simpler to add new types in the future.
* While adding vendor-specific DHCP options is not a really good idea in
general, I see cases we may want to support that simply will not fit in
the 255 chars available to us in root-path, or which would make parsing
that be unnecessarily complex.
* When testing things, it is really nice to be able to override the DHCP
config via the kernel command line when possible. It's much cleaner to
edit a single PXE boot file (or add it via the serial console) when
working alongside a production environment -- less to remember to revert
(and restart!)


Ok, put on your asbestos underwear and wade on in. A consensus would be
really helpful as we have quite a few people working in the network boot
area and it would be great if we had a defined way forward for config.

Dave 

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
