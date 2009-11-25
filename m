From: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/4] Use glob for libdir when installing multipath libraries.
Date: Wed, 25 Nov 2009 10:10:53 -0500
Message-ID: <4B0D48FD.8080705@redhat.com>
References: <1259092378-14143-1-git-send-email-pjones@redhat.com> <4B0C40BC.5000107@redhat.com> <4B0D0531.2050401@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B0D0531.2050401-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 11/25/2009 05:21 AM, Hans de Goede wrote:
> Hi,
> 
> On 11/24/2009 09:23 PM, Peter Jones wrote:
>> Use "/lib*/" not "/lib/" so it works when they're in /lib/multipath as
>> well as when they're in /lib64/multipath
>> ---
>>   modules.d/90multipath/install |    5 +++--
>>   1 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/modules.d/90multipath/install
>> b/modules.d/90multipath/install
>> index 9552918..d20ea38 100755
>> --- a/modules.d/90multipath/install
>> +++ b/modules.d/90multipath/install
>> @@ -11,8 +11,9 @@ for f in  \
>>       /sbin/xdrgetuid \
>>       /sbin/xdrgetprio \
>>       /etc/xdrdevices.conf \
>> -    /lib/libmultipath*  \
>> -    /lib/multipath/* ;do
>> +    /lib*/libmultipath* \
>> +    /lib*/multipath/*
>> +        ;do
>>       inst $f
>>   done
>>
> 
> Not sure if we want to handle this this way, this way if both a 32 bit and
> 64 bit version are present on a system both will get copied to the
> initrd, I think it would be better to handle this how it is handled in
> for example:
> modules/01fips/install
> or
> modules/95nfs/install:
> 
> if ldd $(which rpc.idmapd) |grep -q lib64; then
>     LIBDIR="/lib64"
> else
>     LIBDIR="/lib"
> fi
> 
> dracut_install $(ls {/usr,}$LIBDIR/libnfsidmap_nsswitch.so* 2>/dev/null )

Fair point.  I'm really not sure why device-mapper-multipath is a multilib
package at all, but I guess it's best to do what you're saying.

-- 
        Peter

"I can imagine a world without war, without hate. I can imagine us
attacking it, because they'd never expect it."
