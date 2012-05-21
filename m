From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] add option --printsize
Date: Mon, 21 May 2012 10:50:53 +0200
Message-ID: <4FBA01ED.2000001@redhat.com>
References: <20120521083706.GA3040@localhost.localdomain> <4FBA003D.50103@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FBA003D.50103-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Am 21.05.2012 10:43, schrieb Cong Wang:
> On 05/21/2012 04:37 PM, Dave Young wrote:
>> Add --printsize for measuring module installed size to initramfs
>>
> ...
>> +
>> +        #print the module install size
>> +        if [ -n "$printsize" ]; then
>> +            _isize_new=$(du -sk ${initdir}|cut -f1)
>> +            _isize_delta=$(($_isize_new - $_isize))
>> +            echo "$_d_mod install size: ${_isize_delta}k"
>> +            _isize=$_isize_new
>> +        fi
>>       fi
> 
> Yeah, it is a nice feature, to calculate the module installation size by delta
> of the whole initrd size.
> 
> Could you include the sample output in the changelog?
> 
> Thanks.

What about files used by many modules, like shared libraries and tools? The
output should be taken with a grain of salt.
