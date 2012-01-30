From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] deal with nfs in fstab-sys
Date: Mon, 30 Jan 2012 17:20:27 +0800
Message-ID: <4F2660DB.8030105@redhat.com>
References: <20120130064451.GA7125@darkstar.nay.redhat.com> <jg5jri$3qk$3@dough.gmane.org> <4F2657B4.3030200@redhat.com> <4F26581B.4040305@gmail.com> <4F265CAA.2080804@redhat.com> <4F265EE1.7010505@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F265EE1.7010505-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/30/2012 05:12 PM, Cong Wang wrote:

> On 01/30/2012 05:02 PM, Dave Young wrote:
>> On 01/30/2012 04:43 PM, Cong Wang wrote:
>>
>>> On 01/30/2012 04:41 PM, Dave Young wrote:
>>>> On 01/30/2012 04:20 PM, Cong Wang wrote:
>>>>
>>>>> On Mon, 30 Jan 2012 at 06:44 GMT, Dave Young<dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>  
>>>>> wrote:
>>>>>> If we need to mount nonroot nfs in fstab we also need to launch rpc
>>>>>> processes
>>>>>> Add nfs-start-rpc code, also do not check and fsck $_dev in this case
>>>>>
>>>>> Isn't it nfs module's responsibility to call nfs-start-rpc code?
>>>>> Why do you put it in fs-systab?
>>>>
>>>>
>>>> nfs know nothing about fstab mount, it only deal with nfsroot thing. So
>>>> I have to do this in fstab-sys
>>>
>>> Sure, but nfs module knows it needs to start rpc before mounting NFS.
>>>
>>> So, what's the problem if we call nfs-start-rpc script in pre-pivot hook
>>> of nfs module (before mount-sys.sh, of course)?
>>
>>
>> Actually nfs-start-rpc need to know the fs is nfs or nfs4, If add it as
>> a hook, how does it accept the argument?
> 
> I think you can start rpc daemons unconditionally, no matter if it is
> nfs4 or nfs.


This will means once nfs module is installed in initramfs, the rpc
daemons will be started even if no nfs mount options in fstab or nfsroot

It looks not good to me :(

-- 
Thanks
Dave
