From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: Where to load dm_mod?
Date: Wed, 14 Oct 2009 10:58:04 +0200
Message-ID: <4AD5929C.8070004@bfh.ch>
References: <4AD58F2D.3030806@bfh.ch> <4AD5921C.9080104@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AD5921C.9080104-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Harald Hoyer wrote:
> On 10/14/2009 10:43 AM, Seewer Philippe wrote:
>> Some kernels configurations may build dm as a module. dracut makes sure
>> that dm_mod et al are included in the initramfs, but dm_mod is not
>> automatically loaded when needed.
>>
>> As I'm no expert on this, my question: which module and hook should
>> ensure that dm_mod is properly loaded? Currently I have it
>> 90mdraid/mdmon-pre-udev.sh but I'm really not sure if this is the right
>> place.
>>
>> Thanks,
>> Philippe
> 
> dm_mod ? if that is device-mapper, I would say
> (90dmraid and 90lvm)  or (a new 90dm)

Yes, it's the "device-mapper driver"
