From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/7 respin] network,nfs,fstab-sys stuff
Date: Thu, 02 Feb 2012 16:36:13 +0800
Message-ID: <4F2A4AFD.2040003@redhat.com>
References: <20120202075944.GA12408@darkstar.nay.redhat.com> <4F2A48F9.90201@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F2A48F9.90201-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 02/02/2012 04:27 PM, Cong Wang wrote:

> On 02/02/2012 03:59 PM, Dave Young wrote:
>> This series deal with network startup without netroot and nfsmount
>> in fstab-sys. Patch 1/7, 2/7 and 3/7 is same with previous ones,
>> I just send them for easily tracking.
>>
>> [PATCH 1/7] allow ifup bring up network manually even without netroot
>> [PATCH 2/7] auto setup network without netroot
>> [PATCH 3/7] fix fstab-sys module check
>> [PATCH 4/7] add nobody group for rpc.idmapd
>> [PATCH 5/7] source dracut-lib.sh in nfs cleanup script
>> [PATCH 6/7] split nfs rpc daemons startup script
>> [PATCH 7/7] do not check dev node exist for fstab-sys mounting
> 
> 
> 3- 7 patches all look good to me now.


Thanks

> I still keep my opinion on 2/7, I think we'd better not add more cmdline
> unless we have to, until now, you still don't prove "we have to do
> that". :)


Scratching head...
Harald is thinking about this thing as well, I'm waiting for his
comments. I will not touch this code until get his idea about the whole
network part.

> 
>>
>> Changes from last version are:
>> 4/7: new fix for nfs
>> 5/7: new fix for nfs
>> 6/7: start nfs-start-rpc.sh in pre-udev hook
>> 7/7: remove fsck check for nfs due to fsck_able already do this for us.
> 
> It would be nicer to put these into per patch.
> 
> Thanks.
> -- 
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
