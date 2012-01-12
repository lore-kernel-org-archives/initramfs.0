From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 1/2] support adding module-specific parameters
Date: Thu, 12 Jan 2012 10:19:59 +0800
Message-ID: <4F0E434F.9080002@redhat.com>
References: <1326208786-24344-1-git-send-email-xiyou.wangcong@gmail.com> <4F0CF43E.1020901@redhat.com> <4F0D5D57.9000804@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F0D5D57.9000804-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 01/11/2012 05:58 PM, Cong Wang wrote:

> On 01/11/2012 10:30 AM, Dave Young wrote:
>> Hi,
>>
>> Thanks for the effort, before test it I have two comments
>>
>> On 01/10/2012 11:19 PM, xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>>
>>> From: Cong Wang<xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>
>>> ssh-client module needs a specific parameter, --ssh-key, but
>>> this parameter is totally useless for other modules. So, introduce
>>> a way to let users to pass module-specific parameters, that is,
>>> using colons to separate module name and its parameters, like,
>>>
>>>     --add ssh-client:sshkey=/root/.ssh/kdump_id_rsa.pub
>>
>>
>> Seems no way to add param to modules which is not add explicitly
>> such as simply run
>> ./dracut -l
>>
>> So also need to find way to add params to the implicit-added modules?
> 
> 
> I think you mean -H? Yeah, for cases like -H which selects modules
> automatically, I think we need to add an option in dracut.conf to let
> users specify the module parameters. I will add this...


I mean not only -H but also run dracut without any arguments

> 
> 
>>>
>>> +declare -A dracut_module_args
>>> +read_module_args() {
>>> +    local _key="${1%%:*}"
>>> +    local _val="${1#*:}"
>>
>>> +    dracut_module_args["$_key"]="$_val"
>>
>> [ -z "$_key" ] above will fail
>>
> 
> Yeah, but only when users forget the module name, right? :)


Yes

> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
