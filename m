From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: mktemp in slackware
Date: Fri, 30 Sep 2011 18:02:11 +0800
Message-ID: <4E8593A3.3090300@redhat.com>
References: <4E852172.9090208@redhat.com> <j63v7o$r0p$2@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <j63v7o$r0p$2@dough.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 09/30/2011 04:39 PM, WANG Cong wrote:

> On Fri, 30 Sep 2011 09:54:58 +0800, Dave Young wrote:
> 
>> Hi,
>>
>> The mktemp in slackware is from "bin" package, the mktemp-gnu is from
>> coreutils instead, so it will fail to create initramfs
>>
>> I think there's maybe such problem in other distribution as well, So how
>> to deal with this? Adding a option or giving out a warning on install?
> 
> What is the difference between mktemp-gnu and mktemp on slackware?


mktemp-gnu is from coreutils, mktemp is not.

In my case there's no --tmpdir in mktemp options, so it will fail,
change to mktemp-gnu, it will success.

>

> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
