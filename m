From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] auto setup network without netroot
Date: Tue, 31 Jan 2012 09:42:27 +0800
Message-ID: <4F274703.30003@redhat.com>
References: <20120130064305.GA7108@darkstar.nay.redhat.com> <jg5kl4$3qk$4@dough.gmane.org> <4F265A0B.1000402@redhat.com> <4F265A22.2090407@gmail.com> <4F265C01.4010701@redhat.com> <4F265CDB.7070204@gmail.com> <4F266004.5080501@redhat.com> <4F266389.70303@gmail.com> <4F2667A4.4080203@redhat.com> <4F266AEE.703@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F266AEE.703-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 01/30/2012 06:03 PM, Cong Wang wrote:

> On 01/30/2012 05:49 PM, Dave Young wrote:
>> On 01/30/2012 05:31 PM, Cong Wang wrote:
>>
>>> On 01/30/2012 05:16 PM, Dave Young wrote:
>>>>
>>>> How to say...
>>>> There's many different configs for network like:
>>>> 1. ip={dhcp|on|any|dhcp6|auto6|ibft}
>>>> 2. ip=<interface>:{dhcp|on|any|dhcp6|auto6}
>>>> 3. ip=<client-IP>:[<server-id>
>>>> ]:<gateway-IP>:<netmask>:<client_hostname>:<interface>:{none|off}
>>>> 4. ifname=
>>>> 5. bootdev=
>>>> 6. root=nfs:[snip]
>>>>
>>>> They are all possibly be used, IHMO they are not good options for this
>>>> patch using. For example there's no NIC specified in 1 and 3, we will
>>>> still have to bring up the default
>>>
>>>
>>> Kdump module can make sure that at least one NIC will be specified, if
>>> there is ip=.
>>>
>>>>
>>>> Also this is a general feature, maybe it will be used by users other
>>>> than kdump. For kdump I think we can use proper ip= plus rd.neednet=1
>>>>
>>>
>>> Why? If we can re-use ip=, it will imply rd.neednet=1, so again,
>>> rd.neednet is not needed.
>>
>>
>> why choose ip=? what if user pass ifname= or bootdev= without ip=? I
> 
> For kdump, ip= is the one we need, it has the NIC, and dhcp etc,
> everything we need to bring up an NIC.
> 
> If ifname= or bootdev= is provided but no ip=, we can just bring the NIC
> up without assigning any IP address.
> 
>> want to benefit to other user as well, from semantic point of view one
>> global switch like rd.neednet is more clear then reuse the various other
>> options.
> 
> I can't agree, only specifying ip= also means bringing up network
> apparently.


Harald, what's your opnion? especially about the previous patch to allow
manually bring up network with like 'ifup eth0 -m'? Can you give comments?

-- 
Thanks
Dave
