From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] omit drivers fix
Date: Wed, 21 Aug 2013 16:25:59 +0800
Message-ID: <52147997.2020303@redhat.com>
References: <5203350e.L97Tg2G2L47GaDix%dyoung@redhat.com> <52146FF7.8050904@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52146FF7.8050904-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 08/21/2013 03:44 PM, Dave Young wrote:
> On 08/08/2013 02:05 PM, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org wrote:
>>
>> Because omit_drivers list use underline always, so when maching with it
>> the _mod need to be converted as well or sometimes omit-drivers will fail
>> silently.
>>
>> Fix this by replace '-' with '_' in instmods function.
>>
>> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>>  dracut-functions.sh |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> --- dracut.orig/dracut-functions.sh
>> +++ dracut/dracut-functions.sh
>> @@ -1617,7 +1617,8 @@ instmods() {
>>                      return $_ret
>>                  fi
>>  
>> -                if [[ $omit_drivers ]] && [[ "$1" =~ $omit_drivers ]]; then
>> +                _mod=${_mod/-/_}
>> +                if [[ $omit_drivers ]] && [[ "$_mod" =~ $omit_drivers ]]; then
>>                      dinfo "Omitting driver ${_mod##$srcmods}"
>>                      return 0
>>                  fi
>> --
>> To unsubscribe from this list: send the line "unsubscribe initramfs" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> Hi, Harald
> 
> Could you help to review this patch?
> 

Just find it has been merged, cancel the question..


-- 
Thanks
Dave
