From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] allow ifup bring up network manually even without
 netroot
Date: Wed, 11 Jan 2012 17:48:14 +0800
Message-ID: <4F0D5ADE.4020800@gmail.com>
References: <20111230083858.GA13018@darkstar.nay.redhat.com> <jehm6n$7q8$1@dough.gmane.org> <4F0CEE74.6020102@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=dcKfio9K44kBx73l+ZcNxpNoTEJ4iegpABq/OB6XfkM=;
        b=XnwlE+TTfIhk0fxN8ZYVO4mDOTJ8BQdoIMR/oQ9iRs9S8FMjhbFd6vlx5UB/0mWJpx
         LkP0ZkCdtfqbGNeem5TpHy5Sj0LcPaq+L06MWuISG+dZ8yHhFrACC34XcYfSj59R/AOD
         DtLe5es8JFZRbHldpu0AjRHiGl2F/ktLj3HrE=
In-Reply-To: <4F0CEE74.6020102-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/11/2012 10:05 AM, Dave Young wrote:
> Hi, I have some additional comments
>
> On 01/10/2012 11:41 PM, Cong Wang wrote:
>
>> On Fri, 30 Dec 2011 at 08:38 GMT, Dave Young<dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>  wrote:
>>> For kdump we need scp vmcore to remote machine, the nic to be used is
>>> not limited to netroot one. we need a feature for manually bringing up
>>>   network interface. Also it is useful for emergency shell with
>>> ssh-client for recovery or test purpose
>>>
>>> I implement this by adding one argument to ifup script, user can use
>>> `/sbin/ifup eth0 -m` to bring up eth0, note ifup will regard it a
>>> manual operation for the nic specified in 1st argument if there's
>>> the 2nd argument.
>>>
>>> If same nic is used for netroot the 2nd argument will be ignored,
>>> in this case we will leave netroot bring up it automatically to
>>> avoid side effect. And in this case hooks such as kdump will need to
>>> execute after netroot mounted.
>>>
>>> `ifup eth0 -m` will create /tmp/net.eth0.manualup stamp file,
>>> later dhclient-script can check this and pass $2 to netroot,
>>> then netroot script will bring eth0 up
>>>
>>
>> As we talked on IRC, we still need to discuss if this is really
>> needed, from kdump perspective.
>
>
> manually ifup nic also benefit to emergency shell use case. I want to
> use dracut initramfs as a minimal system without real root for kernel
> testing


For emergency shell, yeah, it make senses.

>
>> If we need to invoke `ifup` by
>> ourselves, then we also need to determine which NIC we should bring
>> up, this will make kdump code larger.
>>
>> So, I hope, we can have some kernel cmdline (like ip=...) to tell
>> dracut which NIC we want to bring up in the second kernel, provided by
>> either ssh-client module or nfs module.
>
>
> If we need to pass the nic name to cmdline then we still need to
> determine which one should be use.


Sure, but this will go to ssh-client or nfs module, not kdump.

>
> If we just bring up all nics, then use the manual ifup is also easy.
>


If there are lots of NIC, and we only use one (for remote kdump),
bringing all NIC up is a waste. Nor to say when we only use eth0, you 
also bring up bond0, br0 etc...

> current dracut udev rules is: if there's no nic specified it will ifup
> all possible nics, but all will be put in initqueue which finally be
> brought up by netroot script.


We need to specify at least one, the one that reach the remote dump server.

Thanks.
