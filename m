From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Redundant nfsroot cmdline options
Date: Wed, 17 Jun 2009 15:26:10 -0400
Message-ID: <4A394352.1010007@redhat.com>
References: <4A36A510.5010709@redhat.com> <20090617034849.GA22705@thedillows.org> <4A386B20.9010205@redhat.com> <4A3898E0.8090700@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A3898E0.8090700-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

> #!/bin/sh
> #
> # Preferred format:
> #       root=nfs[4]:[server:]path[:options]
> #       [root=*] netroot=nfs[4]:[server:]path[:options]

Harald and I agree that there is no reason for this second variation to 
exist in the case of NFS.  It seems the separate root= and netroot= only 
makes sense for remote block device protocols like iscsi or nbd.

> #
> # Legacy formats:
> #
> #       root=/dev/nfs nfsroot=[server:]path[,options]
> #
> #       XXX: All of the following have no reason to exist.
> #       [net]root=[[/dev/]nfs[4]] nfsroot=[server:]path[,options]
> #       [net]root=[[/dev/]nfs[4]] nfsroot=[server:]path[:options]
> #

I'm removing the three variations of the Legacy nfsroot.txt as discussed.

> # If the 'nfsroot' parameter is not given on the command line or is empty,
> # the dhcp root-path is used as [server:]path[:options] or the default

This comment doesn't seem to be true.

> # "/tftpboot/%s" will be used.

This part about /tftpboot/ and the accompanying implementation in 
95nfs/nfsroot seems baffling.

* In what cases does hostname lookup actually work here?
* Where does this precedent come from?  This seems to be a really narrow 
implementation from some specific past software with hard-coded assumptions.
* For example /tftpboot isn't used by default configurations of tftp 
servers on modern Debian, Ubuntu or Fedora anymore.  They've moved to 
FHS-compliant /var/lib/tftpboot.  But then again nothing demands that 
the sysadmin sticks with any particular path for the tftp server.
* What does tftpboot have to do with initrd?  The initrd doesn't have 
anything to do with tftp at this stage.

> #
> # If server is unspecified it will be pulled from one of the following
> # sources, in order:
> #       static ip= option on kernel command line

Huh?  How would you do that?

> #       DHCP next-server option
> #       DHCP server-id option
> #       DHCP root-path option

Do we really want this order?  It seems we want this order:

* root=
* DHCP root-path
* Everything else

> #
> # NFSv4 is only used if explicitly requested; default is NFSv2 or NFSv3
> # depending on kernel configuration
> #
> # root= takes precedence over netroot= if root=nfs[...]
> #
>

This precedence order shouldn't be necessary as netroot= shouldn't be 
necessary for NFS.

For now removing only the nfsroot.txt Legacy variations as the netroot= 
variations are too ingrained in the code.

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
