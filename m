From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/4 branch usrmove] add ssh client module
Date: Mon, 26 Dec 2011 10:07:52 +0800
Message-ID: <4EF7D6F8.2040909@redhat.com>
References: <20111223080416.GA12662@darkstar.nay.redhat.com> <jd73sv$rf9$4@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <jd73sv$rf9$4@dough.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12/25/2011 08:11 PM, Cong Wang wrote:

> On Fri, 23 Dec 2011 at 08:04 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> Hi,
>>
>> This is a ssh-client module for dracut. The first user could be kdump
>> because kdump need to scp vmcore to remote machine.
>>
> 
> Nitpick: why not call it "ssh" module instead of "ssh-client" module?


ssh-client is better, maybe future there will be ssh-server come in.
In debian they are also two different packages.

> 
>>
>> I rebased his patch to usrmove branch of Harald, post along with ssh patches
>>
> 
> I will pick your patches into my tree, because:
> 
> 1) So that we can test them as a whole
> 2) Both your patches and mine are mainly for kdump
> 3) Harald is on vacation these days


Feel free to do it.

> 
> my tree is located at:
> 
>   git://github.com/congwang/dracut.git #kdump
> 
> Thanks.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
