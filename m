From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: How to find the root partition with root=dhcp root-path=iscsi:::...
Date: Fri, 19 Jun 2009 13:11:35 -0400
Message-ID: <1245431495.32104.15.camel@lap75545.ornl.gov>
References: <4A3A4F8F.8070204@redhat.com> <4A3A65EC.1010404@redhat.com>
 <4A3A72E9.3000605@redhat.com> <1245380152.28792.9.camel@lap75545.ornl.gov>
 <4A3B2E6D.2000809@redhat.com> <1245427519.32104.2.camel@lap75545.ornl.gov>
 <4A3BBF97.3090403@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <4A3BBF97.3090403-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, 2009-06-19 at 18:40 +0200, Harald Hoyer wrote:
> On 06/19/2009 06:05 PM, David Dillow wrote:
> > On Fri, 2009-06-19 at 08:21 +0200, Harald Hoyer wrote:
> >> On 06/19/2009 04:55 AM, David Dillow wrote:
> >>> The RFC only says we need to boot off the LUN specified, 0 if none
> >>> listed. That's your default partition.
> >> ok, so the LUN is the partition number?
> >
> > No, a LUN is a whole disk. You would map the LUN to /dev/sda or /dev/sdb
> > or such depending on which one it is, and use the entire disk -- no
> > partitions needed. If you wanted to separate /var or /home etc, you
> > would put them on a different LUN(s) -- partitions optional -- and
> > use /etc/fstab to mount them.
> 
> hmm, so I would have to create a rule, which would look for the next disk which 
> appears and has some /sys magic iSCSI attributes  and try to mount the whole disk.

You're looking for the disk that makes the directory
/sys/class/scsi_disk/<HOST>:0:0:<LUN>

HOST will almost always be 0, unless we try multiple iSCSI roots in
sequence. LUN will be the one specified by root-path.

I'm not sure if you can match this via udev rules, perhaps using a match
rule such as SYMLINK=="by-path/*-scsi-0:0:0:<LUN>"
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
