From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] split out nfs rpc process startup
Date: Mon, 30 Jan 2012 17:03:32 +0800
Message-ID: <4F265CE4.2040002@redhat.com>
References: <20120130064350.GA7114@darkstar.nay.redhat.com> <jg5jov$3qk$2@dough.gmane.org> <4F26572E.7030806@redhat.com> <4F265712.7090302@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F265712.7090302-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/30/2012 04:38 PM, Cong Wang wrote:

> On 01/30/2012 04:39 PM, Dave Young wrote:
>>
>> no special reason for this, I'm fine to make it a script
>>
> 
> Sourcing a script under /sbin is odd. Please make it a single script,
> for other scripts to call it more easily. :)


Ok, will do

-- 
Thanks
Dave
