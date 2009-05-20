From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Netboot fails with multiple interfaces, wireless
Date: Wed, 20 May 2009 18:10:11 +0200
Message-ID: <4A142B63.9070909@redhat.com>
References: <4A137E3C.1040204@redhat.com> <4A13AD3B.4010606@bfh.ch> <4A14022F.8000809@redhat.com> <4A1423CB.1000306@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A1423CB.1000306-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 05/20/2009 05:37 PM, Warren Togami wrote:
> On 05/20/2009 09:14 AM, Harald Hoyer wrote:
>>
>> Warren, nfs now works for me for:
>> ip=dhcp
>> root=dhcp, root=192.168.1.1:/mnt/root, root=nfs://192.168.1.1/mnt/root
>
> You were not reading carefully. I said it does work, except it fails
> when you have multiple interfaces and it gets confused.
>
> Warren

I read that and I know, that it might get confused.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
