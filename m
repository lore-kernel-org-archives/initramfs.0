From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: iSCSI and root
Date: Tue, 02 Jun 2009 13:03:29 -0400
Message-ID: <1243962209.14245.4.camel@lap75545.ornl.gov>
References: <4A254EED.3080902@redhat.com> <4A25503F.40306@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <4A25503F.40306-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Tue, 2009-06-02 at 18:15 +0200, Harald Hoyer wrote:
> On 06/02/2009 06:10 PM, Harald Hoyer wrote:
> > Because root=dhcp with root_path=iscsi:.. or root=iscsi:... would just
> > add a harddisk to the system, we still might want a root=/dev/... to
> > specify the path to the root partition.
> >
> > Or should we just mount the whole disk? If so, how do we detect the
> > newly added disk after iscsistart? Do we add a udev rule to mount it?
> >
> > We might want to use the code from /lib/udev/path_id, which parses
> > $full_sysfs_device_path and scans for */session[0-9]*/*
> 
> or just try to mount everything /dev/disk/by-path/ip-*-lun-*

I was thinking that for iscsi and nbd, we could allow a root=/dev/sda or
root=LABEL=/something along with a netroot=iscsi.... or netroot=nbd to
pull in the block devices, and then allow udev to mount them as they get
added. Ie, allow re-use of the existing block rules.

This would allow people to also do LVM and encrypted PVs on the
networked block devices.

We'd keep the root=iscsi*/nbd* stuff and default to either /dev/nbd0 or
the LUN specified for iscsi.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
