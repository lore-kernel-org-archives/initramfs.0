From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: Netroot cmdline arguments
Date: Thu, 11 Jun 2009 09:20:51 +0200
Message-ID: <4A30B053.9030308@bfh.ch>
References: <4A2E8130.2050305@bfh.ch>	 <1244607992.16191.33.camel@obelisk.thedillows.org>	 <4A2F63C6.2020504@bfh.ch> <1244638667.16191.57.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1244638667.16191.57.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

With input from the current discussion and ignorance of upcoming
netroot patches the current documentation would/should look like
the following:

DHCP
----

Format:
	root=dhcp

Get IP from dhcp, use dhcp root-path option to specify root location.
Contents according to formats below.

Please note: Specifying root=dhcp will ignore further netroot options

NFS
---

Preferred format:
	root=nfs[4]:[server:]path[:options]

Legacy formats:
	root=[[/dev/]nfs[4]] nfsroot=[server:]path[,options]
	root=[[/dev/]nfs[4]] nfsroot=[server:]path[:options]

If the 'nfsroot' parameter is not given on the command line or is empty,
the dhcp root-path is used as [server:]path[:options] or the default
"/tftpboot/%s" will be used.

If server is unspecified it will be pulled from one of the following
sources, in order:
	static ip= option on kernel command line
	DHCP next-server option
	DHCP server-id option
	DHCP root-path option

NFSv4 is only used if explicitly requested; default is NFSv2 or NFSv3
depending on kernel configuration

iSCSI
-----

Preferred format:
	root=iscsi:[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>

Legacy formats:
	root=[iscsi] iscsiroot=[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>
 	root=[iscsi] iscsi_firmware

NBD
---
Preferred format:
	root=nbd:srv:port[:fstype[:rootflags[:nbdopts]]]

Legacy formats:
	root=[nbd] nbdroot=srv,port
	root=[nbd] nbdroot=srv:port[:fstype[:rootflags[:nbdopts]]]

nbdopts is a comma seperated list of options to give to nbd-client

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
