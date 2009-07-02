From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: initqueue
Date: Thu, 02 Jul 2009 16:10:54 +0200
Message-ID: <4A4CBFEE.2020500@redhat.com>
References: <4A4C87DF.10904@redhat.com> <4A4CAA92.9000401@bfh.ch> <4A4CAD9B.10503@redhat.com> <4A4CB136.6000109@bfh.ch> <4A4CB241.8080406@redhat.com> <4A4CB434.1010001@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A4CB434.1010001-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/02/2009 03:20 PM, Seewer Philippe wrote:
>>> Why not just put cryptsetup back into mountscripts as I've suggested
>>> before?
>>>
>>
>> Because so much more can be inside the crypto partition, which might
>> need further processing.
>
> That is correct. But if it's in mountscripts, it would fire more
> udev-events which are caught again by udevadm settle. I don't see
> a problem there.

Hmm, we maybe should think of merging pre-mount and mount.
pre-mount makes no sense, if mounting is done inside udev rules.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
