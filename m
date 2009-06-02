From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: iSCSI
Date: Tue, 02 Jun 2009 13:29:09 +0200
Message-ID: <4A250D05.3020704@redhat.com>
References: <4A250C26.3050001@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A250C26.3050001-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/02/2009 01:25 PM, Harald Hoyer wrote:
> with the new iSCSI module I was able to do the block testcase over iSCSI
> that means:
>
> root filesystem on an encrypted LVM PV over ISCSI
>
> I used:
> "root=/dev/dracut/root rw
> iscsiroot=192.168.2.2::::iqn.2004-04.com.qnap:TS-439:iSCSI.test.8CCAFA
> ip=dhcp"
>
> to create the encrypted LVM PV on a iscsi disk and boot from it.
>

Oh, actually that was a LVM on an encrypted RAID-5 on a iSCSI disk..
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
