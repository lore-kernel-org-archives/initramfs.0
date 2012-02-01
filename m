From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2 v2] deal with nfs in fstab-sys
Date: Wed, 01 Feb 2012 16:19:44 +0800
Message-ID: <4F28F5A0.90000@redhat.com>
References: <20120201020058.GA9573@darkstar.nay.redhat.com> <jgaqvk$n39$2@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <jgaqvk$n39$2@dough.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 02/01/2012 03:52 PM, Cong Wang wrote:

> On Wed, 01 Feb 2012 at 02:00 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> Do not check and fsck $_dev for nfs mount in mount-sys.sh
>>
> 
> For fsck_single, I think you need to fix fsck_single() to skip NFS case.


Good suggestion, will do

> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
