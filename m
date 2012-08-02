From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Building new initrd with dracut-network packages for iscsi boot.
Date: Thu, 02 Aug 2012 11:32:48 +0200
Message-ID: <501A4940.7000302@redhat.com>
References: <1343837115.80604.YahooMailNeo@web121006.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1343837115.80604.YahooMailNeo-ZrCFWsyaVExRBbKmAC7my5OW+3bF1jUfVpNB7YpNyf8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vinay Venkataraghavan <raghavanvinay-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Am 01.08.2012 18:05, schrieb Vinay Venkataraghavan:
> Hi all,
> 
> I have a few questions regarding building a new initrd which adds additional modules to the existing initrd.
> 
> The environment that I am working in is as follows:
> 
> 1. that anaconda has completed the install and I prevent the system from rebooting. 
> 
> 2. Anaconda has installed the OS to an iscsi disk. 
> 
> 
> What I'd like to do now is to add the dracut-network and iscsi modules to the initrd so that when the system reboots it will be able to connect to the remote iscsi target and mount the root device.
> 
> I have been working through this for about three weeks now and am stuck at the phase where I can rebuild the initrd with the network modules and iscsi modules. 
> 
> 
> The installed system contains all the dependency rpms such as: dracut, dracut-kernel, dracut-network, and iscsi-initiator-utils. 
> 
> While in the anaconda shell I tried the following command:
> 
> dracut -v -a iscsi -m network new_initrd.img `uname -r`
> 
> Executing this command has two problems:
> 
> 1. The network option is invalid. I'm wondering if this should be -m dracut-network??
> 
> 2. This does not add modules to the existing image. But it creates a very minimal initrd. 
> 
> 
> What I would like is to add the network boot modules to boot from an iscsi root device to the existing initrd. 
> 
> 
> I would appreciate any help in this matter. Please let me know if I can furnish any further information.
> 
> Thanks in advance.
> - Vinay



"-m network" is wrong, because all the other modules are not used then. You will
end up only with "network" + "iscsi".

Why don't you just use:

# dracut new_initrd.img

or, if you find that too big, just omit the modules, you don't need.

# dracut --omit "nbd nfs multipath" new_initrd.img
