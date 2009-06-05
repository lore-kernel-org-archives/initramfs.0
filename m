From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Use dhclient.conf instead of -R
Date: Fri, 05 Jun 2009 18:54:08 +0200
Message-ID: <4A294DB0.6070704@redhat.com>
References: <4A293933.80601@bfh.ch> <20090605160253.GJ5107@nostromo.devel.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090605160253.GJ5107-Zdt1ptygihhQcNjhGXsBABcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/05/2009 06:02 PM, Bill Nottingham wrote:
> Seewer Philippe (philippe.seewer-omB+W0Dpw2o@public.gmane.org) said:
>> diff --git a/modules.d/40network/install b/modules.d/40network/install
>> index 836c57f..eb6cbcc 100755
>> --- a/modules.d/40network/install
>> +++ b/modules.d/40network/install
>> @@ -13,6 +13,7 @@ done
>>   inst "$moddir/ifup" "/sbin/ifup"
>>   inst "$moddir/netroot" "/sbin/netroot"
>>   inst "$moddir/dhclient-script" "/sbin/dhclient-script"
>> +inst "$moddir/dhclient.conf" "/sbin/dhclient.conf"
>
> We have a /etc on the initramfs ... conf files should go there.
>

agreed
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
