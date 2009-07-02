From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: RFC: writing kernel cmdline options to grub.conf for dracut
Date: Thu, 2 Jul 2009 16:18:07 +0200
Message-ID: <4A4CC19F.9020906@bfh.ch>
References: <4A4B4443.50503@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A4B4443.50503-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Discussion of Development and Customization of the Red Hat Linux Installer <anaconda-devel-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hans de Goede wrote:
> Hi,
> 
> This morning I've been talking to Harald Hoyer about what sort
> of commandline options dracut will be needing to find the /
> filesystem beside root=UUID=1234567890 .
> 
> In most cases (normal disks, dmraid, mdraid, lvm, dmcrypt)
> root=UUID=1234567890 should suffice.
> 
> However in certain cases for example dracut will need additional
> info to find the disks.
> 
> We've come to the following plan for iscsi targets:
> 1) Extend the dhcp_root dhcp variable iscsi syntax to
>    be able include a username password, so:
>    iscsi:192.168.50.2::::iqn.2009-06.dracut:target66
>    Can become:
>    iscsi:user:pass-Q0ErXNX1RuYrv4yRHWfJZg@public.gmane.org::::iqn.2009-06.dracut:target66
>    Or:
>    
> iscsi:user:pass:reverse_user:reverse_pass-Q0ErXNX1RuYrv4yRHWfJZg@public.gmane.org::::iqn.2009-06.dracut:target66 
> 
> 
> 2) Pass root-path=iscsi:... on the kernel cmdline, for each needed iscsi 
> target, so if
>    necessary this will be passed multiple times, dracut will be modified 
> to be able
>    handle multiple root-path arguments being passed in
> 
> 3) chmod /proc/cmdline 400, so that it cannot be read by ordinary users, 
> plugging
>    the passwork leak problem

This does not really plug the leak. Just boot until initramfs is loaded, 
pull the network plug and wait until dracut drops us to a (root-)shell.

> 
> Now the remaining question is how to implement the adding of the needed
> cmdline options to grub.conf.

Question: Is it really necessary to provide username/password to dracut? 
Wouldn't it be better to ask the user? I mean if a mount is password 
protected, be it cryptroot, nfs4 or whatever, shouldn't the user enter 
the data?

Regards,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
