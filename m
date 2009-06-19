From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: How to find the root partition with root=dhcp root-path=iscsi:::...
Date: Fri, 19 Jun 2009 18:40:55 +0200
Message-ID: <4A3BBF97.3090403@redhat.com>
References: <4A3A4F8F.8070204@redhat.com> <4A3A65EC.1010404@redhat.com> <4A3A72E9.3000605@redhat.com> <1245380152.28792.9.camel@lap75545.ornl.gov> <4A3B2E6D.2000809@redhat.com> <1245427519.32104.2.camel@lap75545.ornl.gov>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245427519.32104.2.camel-FqX9LgGZnHWDB2HL1qBt2PIbXMQ5te18@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/19/2009 06:05 PM, David Dillow wrote:
> On Fri, 2009-06-19 at 08:21 +0200, Harald Hoyer wrote:
>> On 06/19/2009 04:55 AM, David Dillow wrote:
>>> The RFC only says we need to boot off the LUN specified, 0 if none
>>> listed. That's your default partition.
>> ok, so the LUN is the partition number?
>
> No, a LUN is a whole disk. You would map the LUN to /dev/sda or /dev/sdb
> or such depending on which one it is, and use the entire disk -- no
> partitions needed. If you wanted to separate /var or /home etc, you
> would put them on a different LUN(s) -- partitions optional -- and
> use /etc/fstab to mount them.

hmm, so I would have to create a rule, which would look for the next disk which 
appears and has some /sys magic iSCSI attributes  and try to mount the whole disk.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
