From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Netroot cmdline arguments
Date: Tue, 9 Jun 2009 17:35:12 +0200
Message-ID: <4A2E8130.2050305@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hello all

I've been trying to put some more validating in the cmdline parser scripts so we can abort early and tell the user what's wrong with the commandline. We've had a similar discussion concerning netroot cmdline arguments before, but at least for me some things are unclear.

I've tried here to put together the doc from http://apps.sourceforge.net/trac/dracut/wiki/commandline and what I've found inside the scripts themselves. If all those who who know and have used netroot stuff could help to clean this up, that would be great.

Thanks all,
Philippe



DHCP
----

Format:
	root=dhcp

Use dhcp root-path option. root-path should contain a text as described below

==> Question: Should root-path only follow the proposed Style type:server:... or should we allow any option format, possibly allow combining with dhcp next_server/server-id?

NFS
---

Preferred format:
	root=nfs[4]:[server:]path[:options]

Legacy formats:
	root=/dev/nfs[4] nfsroot=[server:]path[,options]

If server is unspecified it will be pulled from one of the following
sources, in order:
	static ip= option on kernel command line
	DHCP next-server option
	DHCP server-id option

Other formats:
	root=nfs[4]
	Plain "root=nfs" interprets DHCP root-path option as
	[ip:]path[:options] 

==> Question: I've never used/seen root=nfs before. If server-ip is missing in root-path should dhcp next-server/server-id be used?

NBD
---

Preferred format:
	root=nbd:srv:port[:fstype[:rootflags[:nbdopts]]]

nbdopts is a comma seperated list of options to give to nbd-client

Legacy formats:
	nbdroot=srv,port

==> Question: What should root= contain here? Is having no or an empty root= ok?

Other formats:
	nbdroot=srv:port[:fstype[:rootflags[:nbdopts]]]

==> Same here: empty root ok?
	root=dhcp nbdroot=srv:port[:fstype[:rootflags[:nbdopts]]]

==> Question: Does this make sense? Isn't Having a specified server conflicting with dhcp?

	root=nbd nbdroot=srv:port[:fstype[:rootflags[:nbdopts]]]

==> Question: What aboud a /dev/nbd or even more exact /dev/nbd0?


ISCSI
-----

Preferred format:
	root=iscsi:[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>

protocol defaults to "6", LUN defaults to "0". 

If the "servername" field is provided by BOOTP or DHCP, then that field is used in conjunction with other associated fields to contact the boot server in the Boot stage (Section 7). However, if the "servername" field is not provided, then the "targetname" field is then used in the Discovery Service stage in conjunction with other associated fields.

See: http://tools.ietf.org/html/rfc4173

==> Question 1: The RFC says that DHCP root-path may be used. OK for root=dhcp but what if we provide root=iscsi:... on the cmdline and leave the servername blank? Try to use root-path anyway? Or maybe even use next-server/server-id?

==> Question 2: The RFC specifically says hostnames or ipv6 addresses are allowed for servername. Do we have to support this?

Other/Legacy formats:
	iscsiroot=[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>

==> Question: Same as with nbd. empty or no root=?

	root=dhcp iscsiroot=[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>

==> Question: What is the use of root=dhcp and having more specifics?

	root=iscsi iscsiroot=[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>

==> Question: What aboud a /dev/iscsi or even more exact /dev/iscsi/...lun...?

	root=??? iscsi_initiator= iscsi_target_name= iscsi_target_ip= iscsi_target_port= iscsi_target_group= iscsi_username= iscsi_password= iscsi_in_username= iscsi_in_password=
	root=??? iscsi_firmware

==> Question: Are these really necessary/used?



--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
