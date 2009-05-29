From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: How do we want to handle configuring network boot devices?
Date: Fri, 29 May 2009 15:18:00 +0200
Message-ID: <4A1FE088.4080904@bfh.ch>
References: <1243126816.4217.248.camel@obelisk.thedillows.org> <4A1EB0D2.30500@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A1EB0D2.30500-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



Harald Hoyer wrote:
> Ok, I updated
> https://apps.sourceforge.net/trac/dracut/wiki/commandline
> for the boot mechanism we should support in our first version. I removed 
> the URI style root, because I misread the iscsi root path syntax the 
> first time (no "//" involved).
> 
> Please correct/extend the list.

suggestions:

root=dhcp
<     get IP from dhcp server, root-path option from dhcp specifies root location 
---
>     get IP from dhcp server, root-path option from dhcp specifies root location, implies ip=dhcp 

NFS
< root=[<server-ip>:]<root-dir>[,<nfs-options>]
< root=??? nfsroot=[<server-ip>:]<root-dir>[,<nfs-options>]
---
> root=nfs:[<server-ip>:]<root-dir>[,<nfs-options>]
> root=/dev/nfs nfsroot=[<server-ip>:]<root-dir>[,<nfs-options>]

or 

< root=[<server-ip>:]<root-dir>[,<nfs-options>]
< root=??? nfsroot=[<server-ip>:]<root-dir>[,<nfs-options>]
---
> root=nfs:[<server-ip>:]<root-dir>[,<nfs-options>]
> root=[ignored] nfsroot=[<server-ip>:]<root-dir>[,<nfs-options>]

[ignored] applies to nbd, etc as well. 



> For e.g. password/user authentication, we have to inject conf files in 
> the cpio archive, because /proc/cmdline is readable by everyone or use 
> the dhcp root_path or other dhcp options.

I really suggest to ignore authenticated networks and -mounts for now. dracut v2 can handle that...

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
