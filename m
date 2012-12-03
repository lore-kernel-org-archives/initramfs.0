From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] dracut: add team device support
Date: Mon, 03 Dec 2012 13:27:16 +0800
Message-ID: <50BC3834.3040908@redhat.com>
References: <1352991509-31740-1-git-send-email-amwang@redhat.com>	 <50BC1871.4050009@redhat.com> <1354505223.28101.11.camel@cr0>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354505223.28101.11.camel@cr0>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Pirko <jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 12/03/2012 11:27 AM, Cong Wang wrote:

> On Mon, 2012-12-03 at 11:11 +0800, Dave Young wrote:
>>> -    instmods =drivers/net/phy ecb arc4 bridge stp llc ipv6 bonding
>> 8021q af_packet virtio_net
>>> +    instmods =drivers/net/phy ecb arc4 bridge stp llc ipv6 bonding
>> 8021q af_packet virtio_net =drivers/net/team
>>
>>
>>
>> 40network installs all related kernel modules. This will create a big
>> initramfs though some of them are not used at all.
>>
>> I'm thinking it's better to conditionally install them. In the long
>> run
>> maybe network module should be splited to to multiple modules.
>>
>> And for now I think it's better to install them only if there's team
>> related user space tools in running system. 
> 
> It is not as easy as what you think, users may specify their network
> config at _run time_ via cmdline, so it is not easy to know which kernel
> module will be used until we get all the cmdline.


I agree it's not easy. But for team support if there's no team user
space utility the 2nd kernel setup will fail, isn't it?

> 
> For kdump, one solution is removing all unnecessary stuffs including
> kernel modules and user-space utitlies at setup time, because kdump
> parses the network config at setup time. Obviously this only applies for
> kdump, for others, e.g. anaconda, this problem still exists, but they
> probably don't care about the memory usage as much as kdump.


I will thinking more about the kdump solution. But even for anaconda,
smaller initramfs size is also good to have.

> 
> However, I don't think this is relevant here, we should do this in a
> different patch. It is unfair to only blame team driver here, there are
> already some other modules in the same line anyway...


This is not a blame for team code, just begin to consider the impact to
initramfs size. It's good to start do it once we notice it.
.

-- 
Thanks
Dave
