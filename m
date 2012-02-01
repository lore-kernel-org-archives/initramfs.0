From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2 v2] split nfsroot rpc start code
Date: Wed, 01 Feb 2012 16:16:48 +0800
Message-ID: <4F28F4F0.205@redhat.com>
References: <20120201020054.GA9567@darkstar.nay.redhat.com> <jgaqo7$n39$1@dough.gmane.org> <4F28F017.3030908@redhat.com> <4F28F01C.4020208@gmail.com> <4F28F123.4050807@redhat.com> <4F28F21D.4070509@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F28F21D.4070509-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 02/01/2012 04:04 PM, Cong Wang wrote:

> On 02/01/2012 04:00 PM, Dave Young wrote:
>> On 02/01/2012 03:56 PM, Cong Wang wrote:
>>
>>> On 02/01/2012 03:56 PM, Dave Young wrote:
>>>> On 02/01/2012 03:48 PM, Cong Wang wrote:
>>>>> On Wed, 01 Feb 2012 at 02:00 GMT, Dave Young<dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>  
>>>>> wrote:
>>>>>> Index: dracut/modules.d/95nfs/module-setup.sh
>>>>>> ===================================================================
>>>>>> --- dracut.orig/modules.d/95nfs/module-setup.sh
>>>>>> +++ dracut/modules.d/95nfs/module-setup.sh
>>>>>> @@ -57,6 +57,7 @@ install() {
>>>>>>        dracut_install $(for _i in $(ls {/usr,}$libdir/libnss*.so
>>>>>> 2>/dev/null); do echo $_i;done | egrep "$_nsslibs")
>>>>>>
>>>>>>        inst_hook cmdline 90 "$moddir/parse-nfsroot.sh"
>>>>>> +    inst_hook cmdline 91 "$moddir/nfs-start-rpc.sh"
>>>>>
>>>>> I am sure this is wrong. You need pre-pivot.
>>>>
>>>>
>>>> I want to start them as early as we can, I always think about user use
>>>> dracut as a minimal recovery system, they need do something manually.
>>>>
>>>
>>> Then install it as pre-pivot 00.
>>
>>
>> What if I use rdbreak=point which is before pre-pivot?
>>
> 
> Take a look at all existing cmdline hooks, all of them handle cmdline,
> but nfs-start-rpc doesn't, so not cmdline hook please. You are abusing
> cmdline hooks.



Maybe current cmdline hooks all deal with cmdline things, but as my
understand cmdline hook point is just a point for injecting anything we
need to handle at this point.


-- 
Thanks
Dave
