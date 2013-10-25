From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [ANNOUNCE] dracut 034
Date: Fri, 25 Oct 2013 15:37:22 +0200
Message-ID: <526A7412.8030804@redhat.com>
References: <5253DD0C.7050506@redhat.com> <l4dk8e$fv8$1@ger.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <l4dk8e$fv8$1@ger.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: dirteat-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/25/2013 01:22 PM, EatDirt wrote:
> On 08/10/13 12:23, Harald Hoyer wrote:
>> Here comes a new dracut version. Thanks to all who have contributed to this
>> release.
> 
> Hi guys,
> sorry if this is not the right place to post, but we have some problems with mga
> distributed dracut-034
> 
> For users having two partitions / and /usr; specified in their /etc/fstab,
> without including systemd module, dracut does not automatically includes the
> necessary usrmount module.
> 
> Without usrmount, the initrd yields a kernel panics at boot time. I naively
> though that dracut would automatically take care of the partitions specified in
> /etc/fstab and therefore "sees" that without systemd added, usrmount must be
> present.
> 
> Do you think it is a dracut bug, or we should take care of this at the "distro"
> packaging level?
> 
> Thanks for your help!
> 
> cheers,
> chris.
> 
> 
> PS: the mga full bug report is there (check the last posts):
> 
> https://bugs.mageia.org/show_bug.cgi?id=11292
> 

Hmmm, the usrmount module is automatically included, if /sbin/init is on /usr.
If it is not on /usr, normally /sbin/init can mount /usr via fstab.
