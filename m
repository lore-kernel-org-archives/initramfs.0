From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] Add an exception handle check function
Date: Fri, 18 Jan 2013 10:06:22 +0800
Message-ID: <50F8AE1E.1090603@redhat.com>
References: <76d7b2f339455dcea6a2827b004bfcd9c6fa2315.1356080083.git.bhe@redhat.com> <50F7CC85.5060303@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50F7CC85.5060303-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/17/2013 06:03 PM, Dave Young wrote:
> On 12/21/2012 04:55 PM, Baoquan He wrote:
>> In some cases, exception happened, default handling is called. However,
>> user may not like the handling, want to specify a handler for these
>> exceptions.
>>
>> Add an exception handle check function. Call it where exceptions happened,
>> and specify a extra special handler. If user want the special handler handles
>> this exception, related cmdline is added.
>>
>> Then Dracut will check the cmdline, if related cmdline exists, call the
>> specified handler; if not, call the default handler.
>>
>> The function can be called like below:
>> exception_handle_check -h continue_on_fail
> 
> I think exception_handle is not a good name, how about use "failaction"
> instead?
> 
> And maybe use below action names:
> failaction=continue/shell
> 
> IMHO, reboot is not useful for usual initrd. For kdump add a "continue"
> is enough because kdump module will handle failure of itself as long as
> dracut ignore previous failures.
> 
> These 3 patches should better to be one patch. Or split them to 2
> patches as below
> 1/2: make emergency_shell as a fail action
> 2/2: add a new fail action of "continue"
> 
>>
>> Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>>  modules.d/99base/dracut-lib.sh |   40 ++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 40 insertions(+), 0 deletions(-)
>>
>> diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
>> index cc6c7e8..35ed3a3 100755
>> --- a/modules.d/99base/dracut-lib.sh
>> +++ b/modules.d/99base/dracut-lib.sh
>> @@ -938,6 +938,46 @@ emergency_shell()
>>      [ -e /run/initramfs/.die ] && exit 1
>>  }
>>  
>> +exception_handle_check()
>> +{
>> +    local action_wanted
>> +    if [ "$1" = "-h" ]; then
>> +        [ $# -le 1 ] && echo "No exception handler specified" && emergency_shell
> 
> Not necessary use "-h", just make shell as the default action.
> 
> Add a functions like get_fail_action(), and do_fail_action(), call them
> at different points.
> 
>> +        action_wanted=$2; 
>> +        case "$action_wanted" in
>> +        continue_on_fail)
>> +            ;;
>> +        reboot)
>> +            ;;
>> +        emergency_shell)
>> +            ;;
>> +        *)
>> +            echo "Wrong exception handler input: $action_wanted"
>> +            action_wanted=emergency_shell
>> +        esac
>> +    else
>> +        action_wanted=emergency_shell
>> +    fi
>> +
>> +    case "$action_wanted" in
>> +    continue_on_fail)
>> +        action=$(getarg rd.exceptionhandler=)

Another thing is, doc also need update for the new cmdline param

>> +        [ -z "$action" -o  "$action" != "continue_on_fail" ]  && emergency_shell
>> +        ;;
>> +    emergency_shell)
>> +        emergency_shell
>> +        ;;
>> +    reboot)
>> +        reboot -f
>> +        ;;
>> +    *) #default
>> +        ##impossible come here
>> +        ;;
>> +    esac
>> +
>> +    return 0
>> +}
>> +
>>  # Retain the values of these variables but ensure that they are unexported
>>  # This is a POSIX-compliant equivalent of bash's "export -n"
>>  export_n()
>>
> 
> 


-- 
Thanks
Dave

