From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: Netroot cmdline arguments
Date: Wed, 10 Jun 2009 00:26:32 -0400
Message-ID: <1244607992.16191.33.camel@obelisk.thedillows.org>
References: <4A2E8130.2050305@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A2E8130.2050305-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

[ please set your mail client to wrap lines at 72 chars or so ]

On Tue, 2009-06-09 at 17:35 +0200, Seewer Philippe wrote:
> Hello all
> 
> I've been trying to put some more validating in the cmdline parser
> scripts so we can abort early and tell the user what's wrong with the
> commandline. We've had a similar discussion concerning netroot cmdline
> arguments before, but at least for me some things are unclear.

While I applaud the idea of letting the user know there is a problem,
I'm not sure that doing all of this in the cmdline hook is the best
place -- given that we also need to validate info coming in from DHCP as
well. Also, duplicating the parsing code from the netroot handlers
doesn't seem to be a win in my mind.

Certainly, there are a class of errors that we should catch early on,
but perhaps effort may be better spent in reporting the errors in the
netroot handlers?

My opinions on your questions follow, though I should note that having
implemented much of the legacy option parsing, I'm not completely
adverse to simplifying our support. I like that we can support so many
formats, but having written test cases for them I can see the appeal of
sparse support. It would make documentation easier, anyway. It's easy to
say "no, we don't do that."

> DHCP
> ----
> 
> Format:
> 	root=dhcp
> 
> Use dhcp root-path option. root-path should contain a text as described below
> 
> ==> Question: Should root-path only follow the proposed Style
> type:server:... or should we allow any option format, possibly allow
> combining with dhcp next_server/server-id?

I think we should allow the legacy options to work. We have the code to
do it.

> NFS
> ---
> 
> Preferred format:
> 	root=nfs[4]:[server:]path[:options]
> 
> Legacy formats:
> 	root=/dev/nfs[4] nfsroot=[server:]path[,options]
> 
> If server is unspecified it will be pulled from one of the following
> sources, in order:
> 	static ip= option on kernel command line
> 	DHCP next-server option
> 	DHCP server-id option
> 
> Other formats:
> 	root=nfs[4]
> 	Plain "root=nfs" interprets DHCP root-path option as
> 	[ip:]path[:options] 
> 
> ==> Question: I've never used/seen root=nfs before. If server-ip is
> missing in root-path should dhcp next-server/server-id be used?

root=nfs is something I did early on as a shortcut for root=/dev/nfs
which is supported by the kernel's nfsroot code. Similarly,
root={/dev/,}nfs4 is an invention to handle newer NFS versions.

If server-ip is missing, then it should be filled in via the server
argument from the appropriate ip= line, or via dhcpd
next-server/server-id.

> NBD
> ---
> 
> Preferred format:
> 	root=nbd:srv:port[:fstype[:rootflags[:nbdopts]]]
> 
> nbdopts is a comma seperated list of options to give to nbd-client
> 
> Legacy formats:
> 	nbdroot=srv,port
> 
> ==> Question: What should root= contain here? Is having no or an empty
> root= ok?

Legacy would be root=/dev/ndb[0-9]+ but Warren has suggested we drop
that. With my netroot= patches -- coming soon to a list near you! ;) --
the NBD handler will default to /dev/nbd0, or will be able to specify
root=LABEL=/ or root=/dev/lvm-volume/lv-name etc to use the same
features we get when root is on a local disk.

> Other formats:
> 	nbdroot=srv:port[:fstype[:rootflags[:nbdopts]]]
> 
> ==> Same here: empty root ok?
> 	root=dhcp nbdroot=srv:port[:fstype[:rootflags[:nbdopts]]]
> 
> ==> Question: Does this make sense? Isn't Having a specified server
> conflicting with dhcp?

Maybe, or you can see it as get your IP info from dhcp. I can see that
this is a bit of a conflict.

> 	root=nbd nbdroot=srv:port[:fstype[:rootflags[:nbdopts]]]
> 
> ==> Question: What aboud a /dev/nbd or even more exact /dev/nbd0?

As above -- root=/dev/nbd0 is a dropped syntax for the moment, to be
resurrected in a new form by netroot= 

> 
> 
> ISCSI
> -----
> 
> Preferred format:
> 	root=iscsi:[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>

> See: http://tools.ietf.org/html/rfc4173
> 
> ==> Question 1: The RFC says that DHCP root-path may be used. OK for
> root=dhcp but what if we provide root=iscsi:... on the cmdline and
> leave the servername blank? Try to use root-path anyway? Or maybe even
> use next-server/server-id?

Here, I would stick to the RFC as there are fewer legacy issues. I would
expect netroot=iscsi:... to behave as though the iscsi:... came from the
DHCP server and ignore the DHCP root-path option (or at least for the
fields specified on the command line.)

This is similar to how the kernel's ip= and nfsroot= pull their defaults
from the DHCP response, but allow it to be overridden by the command
line options.

If servername is blank, per the RFC we use <targetname> with the
Discovery Service to find our server.

> ==> Question 2: The RFC specifically says hostnames or ipv6 addresses
> are allowed for servername. Do we have to support this?

I think we should, yes. IPv6 support is something we're going to want in
general, but it will present some challenges to our parsing schemes.

Perhaps we would put some limits on using IPv6 in the legacy options (no
ip= static config for IPv6, require the full nfs:IP:server[:,]opts
format, etc.)

Supporting hostnames via DNS is almost free. Other schemes such as LDAP
and NIS would be more problematic I think. Though perhaps there is a
good way to pull that in. I haven't thought much about it.

> Other/Legacy formats:
> 	iscsiroot=[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>
> 
> ==> Question: Same as with nbd. empty or no root=?

With no root, I think we need the root to the LUN option given, which
defaults to the first LUN on that host if not given.

> 	root=dhcp iscsiroot=[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>
> 
> ==> Question: What is the use of root=dhcp and having more specifics?

This has the same conceptual conflict as you note for nbdroot= w/
root=dhcp.

> 	root=iscsi iscsiroot=[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>
> 
> ==> Question: What aboud a /dev/iscsi or even more exact /dev/iscsi/...lun...?

I don't think we need to invent a new format here. We've got enough
legacy issues to keep us busy. :)

> 	root=??? iscsi_initiator= iscsi_target_name= iscsi_target_ip=
> iscsi_target_port= iscsi_target_group= iscsi_username= iscsi_password=
> iscsi_in_username= iscsi_in_password=
> 	root=??? iscsi_firmware
> 
> ==> Question: Are these really necessary/used?

I think the first one is unlikely to be all that useful, given the
limits on the command line (though maybe it is just my version of
PXELINUX that is the limit.) Also, there are security issues with having
that information on the command line (not to mention in cleartext on the
wire.

I would like to see some way to support reading iSCSI Boot Firmware
Table (iBFT) from the BIOS to find our root, so we need a way to tell
dracut to do so. I don't know if that is root=iscsi:firmware or
root=blah iscsi=firmware or what.

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
