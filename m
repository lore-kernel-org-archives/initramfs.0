From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: 90kernel-modules-loaded must be --hostonly
Date: Fri, 29 May 2009 09:44:30 +0200
Message-ID: <4A1F925E.7020105@redhat.com>
References: <4A1ED743.3010107@redhat.com> <4A1F6B12.5050001@redhat.com> <4A1F8E18.2030400@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A1F8E18.2030400-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 05/29/2009 09:26 AM, Harald Hoyer wrote:
> On 05/29/2009 06:56 AM, Warren Togami wrote:
>> On 05/28/2009 02:26 PM, Warren Togami wrote:
>>>> /sbin/lsmod | while read mod rest; do
>>>> instmods "$mod"
>>>> done
>>>
>>> This part relies on looking at the running system, and thus must not be
>>> part of the default dracut run. This seems OK for --hostonly mode.
>>>
>>> Changing this will likely break some users depending on modules not
>>> otherwise pulled in elsewhere? Should I just go ahead and see what
>>> breaks?
>>
>> Oh, I now notice that the check script skips this entirely unless you
>> are in hostonly mode. This is the reason why I'm not getting the KMS
>> drivers loaded prior to plymouth (although plymouth itself is still
>> busted for other reasons.)
>>
>> [ "$1" != "-h" ] && exit 1
>>
>> But is this correct? It seems we should be checking the hostonly
>> variable and not if "-h" happens to be the first parameter.
>>
>> -h isn't -H.
>> -h isn't --hostonly
>
> This obviously broke by introducing the --help option.. just fix it.

oops, no "check" is called with -h in dracut if $hostonly is set by "-H --hostonly"
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
