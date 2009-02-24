From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [RFC PATCH] Move actually mounting the root filesystem into its
 own series of hooks.
Date: Tue, 24 Feb 2009 09:00:36 +0100
Message-ID: <49A3A924.9000003@bfh.ch>
References: <3188506a1f06de54ee7874fc45261f5c2faf9e79.1235283966.git.victor.lowther@gmail.com> <49A301FF.2090303@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49A301FF.2090303-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi all

Warren Togami wrote:
[snip]
> root=dhcp is a kernel cmdline given by the bootloader (syslinux, grub, 
> pxelinux, etc.) which directs the initrd during runtime to bring up eth0 
> and do DHCP.  It then mounts the rootfs depending on options given by 
> the DHCP server.  Fedora 10 mkinitrd implements the following two types 
> of mounts with root=dhcp.
> 
>         option root-path "172.31.100.254:/path/to/target_root";
>         option root-path "nbd:172.31.100.254:2000:squashfs:ro";
> 
> An existing RFC specifies syntax for iscsi that could be implemented as 
> well.  (Although iscsi is problematic because some types require 
> authentication.)  Arbitrary types of root=dhcp rootfs mounts can be 
> implemented with hooks made possible with your patch.

A question: Why not use root=/dev/nfs and the other options according to 
kernel doc, like nfsroot=... and ip=autoconf? For me that is much more 
readable.

Maybe even leave nfsroot-mounting to the kernel as long as that features 
remains in the tree.

I guess nbd and iscsi could go the same way like root=/dev/iscsi ...

Regards,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
