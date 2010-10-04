From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: NFS root with Dracut not calling nfsroot script
Date: Mon, 04 Oct 2010 11:08:31 +0200
Message-ID: <4CA9998F.7060701@redhat.com>
References: <20101002062617.5730102kmedzh6uo@webmail.zoltak.com> <20101004152252.15833xc2gkzz1mdc@webmail.zoltak.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101004152252.15833xc2gkzz1mdc-2RFepEojUI3Y3UUic/vCjNBPR1lH4CV8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: daniel-2N1FInP7wozQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/04/2010 06:22 AM, daniel-2N1FInP7wozQT0dZR+AlfA@public.gmane.org wrote:
> I've been trying to PXE boot using Dracut with an NFS root.
>
> I've been able to boot the node via PXE, get an IP address on eth0 but it always
> fails to mount the root device. I have it set to drop into the shell and at this
> point if I do:
>
> mount.nfs xxx.xxx.xxx.xxx:/vol/blah /sysroot -o nolock # it works i.e. I can
> mount the NFS.
>
> I've tried various methods in specifying the root via the kernel cmd param's and
> also in the DHCP config with no luck in getting it to mount and pivot.
>
> Here is the pxeboot.cfg file:
>
>
> # NFS server for OS image (imageroot) is at address 10.197.170.5
> PROMPT 1
> TIMEOUT 10
> DEFAULT 1
> DISPLAY messages
> LABEL 1
> KERNEL vmlinuz-2.6.34-gentoo-r1
> APPEND rw bootdev=eth0 ip=eth0:dhcp
> root=nfs:10.197.170.5:/vol/filerboot/linux/images/live-mon-test:fg,nfsvers=3,nolock,timeo=600,retrans=2,rsize=32768,wsize=32768,hard,nointr,actimeo=3600,tcp,noacl,rw
> initrd=initrd-2.6.34-gentoo-r1-dracut rdshell
>
>
>
> Am I missing something preventing the NFS booting? Maybe missing something in
> the Kernel?
>
> It appears the nfsroot script is never called. If I manually call it from the
> recovery shell the nfs root is mounted to /sysroot.
>
> The init.log is attached.
>
> Thanks in advance.
>


 From the init.log:

> ifup.eth0.783 + dhclient -4 -1 -q -cf /etc/dhclient.conf -pf /tmp/dhclient.eth0.pid -lf /tmp/dhclient.eth0.lease eth0
> Internet Systems Consortium DHCP Client V3.1.2p1-Gentoo
> Copyright 2004-2009 Internet Systems Consortium.
> All rights reserved.
> For info, please visit http://www.isc.org/sw/dhcp/
> Usage: dhclient [-1dqrx] [-nw] [-p <port>] [-s server]
> [-cf config-file] [-lf lease-file][-pf pid-file] [-e VAR=val]
> [-sf script-file] [interface]
>
> If you did not get this software from ftp.isc.org, please
> get the latest from ftp.isc.org and install that before
> requesting help.
>
> If you did get this software from ftp.isc.org and have not
> yet read the README, please read it before requesting help.
> If you intend to request help from the dhcp-server-2cKsPvgpMDY@public.gmane.org
> mailing list, please read the section on the README about
> submitting bug reports and requests for help.
>
> Please do not under any circumstances send requests for
> help directly to the authors of this software - please
> send them to the appropriate mailing list as described in
> the README file.
>
> exiting.
> ifup.eth0.783 + echo dhcp failed
> dhcp failed

So, it seeems like your dhclient does not support one of the options (most 
likely "-4").
You might want to try dhclient version > 4 or modify 
/usr/share/dracut/modules.d/40network/ifup and remove "-4" from "do_dhcp -4".

