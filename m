From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] remove the global --sshkey parameter
Date: Thu, 12 Jan 2012 10:15:35 +0800
Message-ID: <4F0E4247.1010501@redhat.com>
References: <1326208786-24344-1-git-send-email-xiyou.wangcong@gmail.com> <1326208786-24344-2-git-send-email-xiyou.wangcong@gmail.com> <4F0CFB08.6030800@redhat.com> <4F0D5C64.1080203@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F0D5C64.1080203-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 01/11/2012 05:54 PM, Cong Wang wrote:

> On 01/11/2012 10:59 AM, Dave Young wrote:
>>
>> Hi,
> 
> Hi,
> 
>>
>> After removing --sshkey we need to parse dracut_module_args for module
>> use. Maybe in a general function of dracut-lib will be fine.
>>
>> Also need consider the multi-param case like below:
>> module:a=b,c=d,e=f,...
>>
>> Ie. in ssh-client module we need to parse "sshkey=/root/.ssh/id_rsa" for
>> installing sshkey
>>
> 
> It is already done by the first patch. :)


During my test, the $sshkey is only available in check() function,
finally the key was not installed to initramfs. Please see my another reply
 before.

> 
> Note that, I designed to use colons to separate parameters, not commas,
> even if you pass multiple parameters.


I think A:b,c,d looks better, but I have no strong opinion about this
because right half of first colon can be seen as param which can be
defined and parsed by specific module.

-- 
Thanks
Dave
