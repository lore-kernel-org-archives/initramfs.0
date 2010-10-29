From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: New rd.* namespace for dracut-008
Date: Fri, 29 Oct 2010 10:18:48 +0200
Message-ID: <4CCA8368.6020007@redhat.com>
References: <4CC99414.5060607@redhat.com> <4CC9AB0E.2040604@linux.vnet.ibm.com> <4CC9AD55.7010104@redhat.com> <20101028174048.GA2367@nostromo.devel.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101028174048.GA2367-Zdt1ptygihhQcNjhGXsBABcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Steffen Maier <maier-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/28/2010 07:40 PM, Bill Nottingham wrote:
> Harald Hoyer (harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org) said:
>> because it's the "dasd" parameter of the dasd_mod module
>>
>> one could specify it directly on the kernel command with
>> "dasd_mod.dasd=", which would be honored by the module itsself. So I
>> just added "rd." to indicate the sole use for the initramfs.
>
> We don't unload and reload the module (do we?), so I don't
> see how having a version that's solely for initramfs usage
> makes sense here.
>
> Bill

True... that's what I thought, too :)
