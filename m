From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: How do we want to handle configuring network boot devices?
Date: Thu, 28 May 2009 14:23:39 -0400
Message-ID: <4A1ED6AB.3040606@redhat.com>
References: <1243126816.4217.248.camel@obelisk.thedillows.org> <4A1EB0D2.30500@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A1EB0D2.30500-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 05/28/2009 11:42 AM, Harald Hoyer wrote:
> Ok, I updated
> https://apps.sourceforge.net/trac/dracut/wiki/commandline
> for the boot mechanism we should support in our first version. I removed
> the URI style root, because I misread the iscsi root path syntax the
> first time (no "//" involved).
>
> Please correct/extend the list.
>
> For e.g. password/user authentication, we have to inject conf files in
> the cpio archive, because /proc/cmdline is readable by everyone or use
> the dhcp root_path or other dhcp options.

I suspect none dhcp root-path is unsuitable too, because it is blatantly 
transmitted in clear text.  This is also an issue for including it in a 
config file for PXE boot because the initrd must be transmitted 
unencrypted over the wire.

The only "secure" way of handling secrets in the initrd is if the initrd 
is on a local disk within a client.  It is plausible that some users 
would opt to boot from local disks, and mount root filesystem over the 
network for benefits of easy central management.

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
