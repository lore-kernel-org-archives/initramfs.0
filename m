From: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Add a check file for multipath.
Date: Fri, 22 Jan 2010 10:56:25 -0500
Message-ID: <4B59CAA9.3030301@redhat.com>
References: <1264106501-31284-1-git-send-email-pjones@redhat.com> <4B596BEB.30401@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B596BEB.30401-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/22/2010 04:12 AM, Harald Hoyer wrote:
> On 01/21/2010 09:41 PM, Peter Jones wrote:
>> If multipath isn't installed, don't use it.  If we're in hostonly mode,
>> only install the multipath module if it's used for / .  Otherwise, if
>> the user was dumb enough to install it, they get it during bootup.
>> ---
>>   modules.d/90multipath/check |   27 +++++++++++++++++++++++++++
>>   1 files changed, 27 insertions(+), 0 deletions(-)
>>   create mode 100755 modules.d/90multipath/check
>>
>> diff --git a/modules.d/90multipath/check b/modules.d/90multipath/check
>> new file mode 100755
>> index 0000000..f602e3e
>> --- /dev/null
>> +++ b/modules.d/90multipath/check
>> @@ -0,0 +1,27 @@
>> +#!/bin/bash
>> +
>> +# if there's no multipath binary, no go.
>> +which multipath>/dev/null 2>&1 || exit 1
>> +
>> +[[ $1 = -d ]]&&  echo dm_multipath
> 
> hmm, there is no module dm_multipath

Oh, I completely misread how this works and parsed it as kernel module deps,
rather than dracut module deps.  I'll send a revised version with a fix.

-- 
        Peter

I'd like to start a religion. That's where the money is.
		-- L. Ron Hubbard to Lloyd Eshbach, in 1949;
			quoted by Eshbach in _Over My Shoulder_.
