From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: multipath device issue
Date: Thu, 02 Aug 2012 15:18:34 +0200
Message-ID: <501A7E2A.4020601@redhat.com>
References: <501A0B87.9070506@redhat.com> <501A3532.7010907@redhat.com> <501A7590.3010701@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <501A7590.3010701-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chao Wang <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Am 02.08.2012 14:41, schrieb Dave Young:
> On 08/02/2012 04:07 PM, Harald Hoyer wrote:
> 
>> Am 02.08.2012 07:09, schrieb Dave Young:
>>> Hi,
>>>
>>> The multipath device node was not created during testing kdump on
>>> multipath target. dracut drop into emergency shell,  I checked that
>>> 'multipathd -B' was running in background. Any idea?
>>>
>>> Attached the full log of debug info.
>>>
>>
>> hmm.. I hope, this did not introduce a regression:
>> http://git.kernel.org/?p=boot/dracut/dracut.git;a=commitdiff;h=c0cae7f702b5ccf27a80913642aec8bf15fe710e
> 
> 
> Revert this commit does not help in this case.
> 
> I tried manually run `multipath` in the emergency shell the
> /dev/mapper/mpathb will be created..
> 

oh.. can you retry with dracut-023? I think your version is missing this patch:

http://git.kernel.org/?p=boot/dracut/dracut.git;a=blobdiff;f=modules.d/90multipath/module-setup.sh;h=31d11088bd65932460f036cabbd7a33cab5c5ec7;hp=f9c1f81354f8932a28561822452107da3aa6c349;hb=24a38bc1cbe461c344ce61c7e10b6d51d5689c93;hpb=82b1739dcee8853c07675d3e79b2f4623c60a364

from

http://git.kernel.org/?p=boot/dracut/dracut.git;a=commitdiff;h=24a38bc1cbe461c344ce61c7e10b6d51d5689c93
