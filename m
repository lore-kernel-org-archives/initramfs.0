From: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 4/4] Bring up multipath devices that are configured in
 multipath.conf.
Date: Wed, 25 Nov 2009 10:17:51 -0500
Message-ID: <4B0D4A9F.1090606@redhat.com>
References: <1259092378-14143-1-git-send-email-pjones@redhat.com> <4B0C40ED.9000909@redhat.com> <4B0D087E.1030502@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B0D087E.1030502-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 11/25/2009 05:35 AM, Hans de Goede wrote:
> Hi,
> 
> On 11/24/2009 09:24 PM, Peter Jones wrote:
>> This brings up multipath devices which are configured in multipath.conf
>> as we find them.
>> ---
>>   modules.d/90multipath/14-multipath-scan.rules |    9 +++++++++
>>   modules.d/90multipath/install                 |    3 +++
>>   modules.d/90multipath/multipath-scan.sh       |   16 ++++++++++++++++
>>   3 files changed, 28 insertions(+), 0 deletions(-)
>>   create mode 100644 modules.d/90multipath/14-multipath-scan.rules
>>   create mode 100644 modules.d/90multipath/multipath-scan.sh
>>
>> diff --git a/modules.d/90multipath/14-multipath-scan.rules
>> b/modules.d/90multipath/14-multipath-scan.rules
>> new file mode 100644
>> index 0000000..fcb8173
>> --- /dev/null
>> +++ b/modules.d/90multipath/14-multipath-scan.rules
>> @@ -0,0 +1,9 @@
>> +# scan for multipath devices
>> +SUBSYSTEM!="block", GOTO="end_mpath_scan"
>> +KERNEL!="sd*", GOTO="end_mpath_scan"
>> +PROGRAM=="/bin/sh -c 'for i in //holders/dm-[0-9]*; do [ -e 9429i
>> ]&&  exit 0; done; exit 1;' ", GOTO="end_mpath_scan"
> 
> What is this 9429i thingie ? a comment about this in the rules file
> might be good to have.

Something really funny happened and I'm not sure how or at what step.
It's supposed to be "$$i".  I'll post a corrected version with your
other suggestions.

-- 
        Peter

"I can imagine a world without war, without hate. I can imagine us
attacking it, because they'd never expect it."
