From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/3] wait_for_if_up fix
Date: Thu, 16 Feb 2012 09:12:42 +0800
Message-ID: <4F3C580A.6070605@redhat.com>
References: <20120215064027.GA30110@darkstar.nay.redhat.com> <4F3B6B5A.6070007@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F3B6B5A.6070007-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 02/15/2012 04:22 PM, Harald Hoyer wrote:

> Am 15.02.2012 07:40, schrieb Dave Young:
>> wait_for_if_up will always return 0, fix it by change to use =~ to
>> check if link state is up
>>
>> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>>  modules.d/99base/dracut-lib.sh |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
>> index 6b70adf..85d4925 100755
>> --- a/modules.d/99base/dracut-lib.sh
>> +++ b/modules.d/99base/dracut-lib.sh
>> @@ -385,7 +385,7 @@ wait_for_if_up() {
>>      local cnt=0
>>      while [ $cnt -lt 200 ]; do
>>          li=$(ip link show $1)
>> -        [ -z "${li##*state UP*}" ] && return 0
>> +        [[ "$li" =~ "state UP" ]] && return 0
>>          sleep 0.1
>>          cnt=$(($cnt+1))
>>      done
> 
> 
> This is not posix shell compliant.
> 
> $ PS1="$ " dash
> $ li="my state DOWN test"
> $ [ -z "${li##*state UP*}" ] && echo OK
> $ li="my state UP test"
> $ [ -z "${li##*state UP*}" ] && echo OK
> OK
> $
> 
> works for me


Thanks for comment, above work for me as well.
Actually I tested with an non-exist nic. In that case $li will be nul

-- 
Thanks
Dave
