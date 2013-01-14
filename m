From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2 v2] Add memory usage trace to diffrent hook points
Date: Mon, 14 Jan 2013 16:59:05 +0800
Message-ID: <50F3C8D9.2020603@redhat.com>
References: <20121126023852.GA6886@localhost.localdomain> <20121127223330.GG6964@redhat.com> <50B5CF24.6090006@redhat.com> <50EFD5D8.1070508@redhat.com> <50EFE2AC.7020704@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50EFE2AC.7020704-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jstancek-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 01/11/2013 06:00 PM, Harald Hoyer wrote:
> Am 11.01.2013 10:05, schrieb Dave Young:
>>
>> Hello harald
>>
>> What's your opinion about this patch? Could you take a look at it?
>>> --- dracut.orig/modules.d/99base/dracut-lib.sh
>>> +++ dracut/modules.d/99base/dracut-lib.sh
>>> @@ -998,3 +998,93 @@ listlist() {
>>>  are_lists_eq() {
>>>      listlist "$1" "$2" "$3" "$4" && listlist "$1" "$3" "$2" "$4"
>>>  }
>>> +
>>> +setmemdebug() {
>>> +    if [ -z "$DEBUG_MEM_LEVEL" ]; then
>>> +        export DEBUG_MEM_LEVEL=$(getargnum 0 0 3 rd.memdebug)
>>> +    fi
>>> +}
>>> +
>>> +setmemdebug
>>> +
>>> +# parameters: msg [trace_level:trace]...
>>> +function make_trace_mem()
>>> +{
>>> +    msg=$1
>>> +    shift
>>> +    if [ "$DEBUG_MEM_LEVEL" -gt 0 ]; then
>>> +        make_trace show_memstats $DEBUG_MEM_LEVEL "[debug_mem]" "$msg" "$@"
>>> +    fi
>>> +}
>>> +
>>> +# parameters: func log_level prefix msg [trace_level:trace]...
>>> +function make_trace()
>>> +{
>>> +    func=$1
>>> +    shift
>>> +
>>> +    log_level=`echo "$1" | grep -o '^[0-9]\+'`
> 
> * use $() instead of ``

Will do

> 
> 
> * grep is overkill use simple shell functions
> 
> There are in modules.d/99base/dracut-lib.sh
> strstr()
> str_starts()
> str_ends()
> 
> * or use "case"
> 
> case "$1" in
>     [0-9]*) log_level=$1;;
> esac

Will do

> 
>>> +    shift
>>> +
>>> +    prefix=$1
>>> +    shift
>>> +
>>> +    msg=$1
>>> +    shift
>>> +
>>> +    if [ -z "$log_level" ]; then
>>> +        return
>>> +    fi
>>> +
>>> +    msg=`echo "$msg" | sed 's/^\s\+//'`
> 
> sed is overkill for this. Use
> ${var%%...}
> ${var%...}
> ${var#...}
> ${var##...}
> 
> $ msg="foo+bar baz"
> $ echo ${msg#*+}
> bar baz
> 

Will do

> 
>>> +
>>> +    msg_printed=0
>>> +    while [ $# -gt 0 ]; do
>>> +        trace_level=`echo "$1" | grep -o '^[0-9]\+'`
>>> +        trace_in_higher_levels=`echo "$1" | grep -o '+'`
>>> +        trace=`echo $1 | sed "s/^.*://"`
> 
> same same
> 

Will do

-- 
Thanks
Dave

