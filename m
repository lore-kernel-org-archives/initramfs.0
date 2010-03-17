From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] silence xen-detect detection
Date: Wed, 17 Mar 2010 13:27:51 +0100
Message-ID: <20100317122751.GY2020@nb.net.home>
References: <20100307125208.GA26671@maude.comedia.it> <4BA0B55D.90007@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4BA0B55D.90007-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Mar 17, 2010 at 11:56:29AM +0100, Harald Hoyer wrote:
> On 03/07/2010 01:52 PM, Luca Berra wrote:
>> Signed-off-by: Luca Berra <bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org>
>> ---
>> modules.d/60xen/check | 2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/modules.d/60xen/check b/modules.d/60xen/check
>> index 420cdc2..f155582 100755
>> --- a/modules.d/60xen/check
>> +++ b/modules.d/60xen/check
>> @@ -1,7 +1,7 @@
>> #!/bin/bash
>>
>> # No Xen-detect? Boo!!
>> -XENDETECT=$(which xen-detect)
>> +XENDETECT=$(which xen-detect 2>/dev/null)
>> [ -z "$XENDETECT" ] && [ -d "/usr/lib/xen-default" ] &&
>> XENDETECT="/usr/lib/xen-default/bin/xen-detect"
>> [ -z "$XENDETECT" ] && exit 1

 BTW, lscpu(1) from util-linux-ng is able to detect KVM, Xen and 
 MS Hv and type of virtualization (para/full).

    Karel

-- 
 Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
