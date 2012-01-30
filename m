From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] auto setup network without netroot
Date: Mon, 30 Jan 2012 17:16:52 +0800
Message-ID: <4F266004.5080501@redhat.com>
References: <20120130064305.GA7108@darkstar.nay.redhat.com> <jg5kl4$3qk$4@dough.gmane.org> <4F265A0B.1000402@redhat.com> <4F265A22.2090407@gmail.com> <4F265C01.4010701@redhat.com> <4F265CDB.7070204@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F265CDB.7070204-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/30/2012 05:03 PM, Cong Wang wrote:

> On 01/30/2012 04:59 PM, Dave Young wrote:
>> On 01/30/2012 04:51 PM, Cong Wang wrote:
>>
>>> On 01/30/2012 04:51 PM, Dave Young wrote:
>>>>
>>>> We will also setup network when rd.neednet=1 in case no special ip=
>>>> provided for convenience.
>>>>
>>>
>>> With rd.neednet=1 but without ip=, how can you know which nic we need to
>>> bring up?
>>
>>
>> current behavior of net-genrule.sh is below:
>>
>> # Default: We don't know the interface to use, handle all
>>
>> It will be ok and convenient at least when we have only one nic
> 
> So, rd.neednet=1 will bring up all when there is no ip=, what kdump
> needs is a cmdline that tells dracut to bring up only the ones we need.
> 
> You still don't tell why re-using ip= doesn't work. So far, I think ip=
> can be re-used for kdump case, and is better than your rd.neeednet=1.



How to say...
There's many different configs for network like:
1. ip={dhcp|on|any|dhcp6|auto6|ibft}
2. ip=<interface>:{dhcp|on|any|dhcp6|auto6}
3. ip=<client-IP>:[ <server-id>
]:<gateway-IP>:<netmask>:<client_hostname>:<interface>:{none|off}
4. ifname=
5. bootdev=
6. root=nfs:[snip]

They are all possibly be used, IHMO they are not good options for this
patch using. For example there's no NIC specified in 1 and 3, we will
still have to bring up the default

Also this is a general feature, maybe it will be used by users other
than kdump. For kdump I think we can use proper ip= plus rd.neednet=1

-- 
Thanks
Dave
