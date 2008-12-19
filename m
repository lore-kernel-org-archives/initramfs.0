From: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Dracut questions
Date: Fri, 19 Dec 2008 11:46:17 -0500
Message-ID: <787B75CF-02DE-44B5-BE2D-BA64F5353EBC@redhat.com>
References: <494B2E2F.5090203@redhat.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <494B2E2F.5090203-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Dec 19, 2008, at 12:16 AM, Warren Togami wrote:
> https://fedoraproject.org/wiki/Initrdrewrite
>> Probe at runtime instead of buildtime - Include all drivers, not just
>> the drivers necessary for the hardware being run. (For storage, the
>> common ones will be built-in to the kernel anyway)
>
> This means include all storage drivers and firmware for the storage  
> drivers?

By default, yes.  As of yesterday or so, there's support for  
overriding the set of modules if you want a subset since I figure  
someone someday will want it and it's trivial to allow.

> Does this also mean we only add network drivers if the initrd is  
> explicitly built for netboot?

There are many open questions for exactly how best to handle netboot.   
I expect the answer is "yes" and that we end up wanting to have the  
config for the initramfs to specify things like
      nbd_boot="yes"
      nfs_boot="yes"
      iscsi_boot="yes"
etc so that people can tweak accordingly.  It may also be that we want  
it to be based on the presence of things installed on the system.

> How do we plan on dealing with the location of various standard  
> utilities being different on other Linux distributions?
[snip]
>
> Perhaps use "which" to find it?  But then how do we choose its  
> destination path in the initrd chroot if the distributions disagree  
> on where they expect a command to go?  Will they disagree?

which will work just fine (although your examples are ones that don't  
matter right now :).  And the destination path should match the source  
path.  We just have to ensure $PATH is appropriate in the initramfs

Jeremy
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
