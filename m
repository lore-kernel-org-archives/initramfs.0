From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: initqueue
Date: Fri, 03 Jul 2009 10:06:15 +0200
Message-ID: <4A4DBBF7.8010501@redhat.com>
References: <4A4C87DF.10904@redhat.com> <4A4CAA92.9000401@bfh.ch>	 <4A4CAD9B.10503@redhat.com> <4A4CB136.6000109@bfh.ch>	 <4A4CB241.8080406@redhat.com> <4A4CB434.1010001@bfh.ch>	 <4A4CBFEE.2020500@redhat.com> <1246579473.3339.96.camel@sentry-no.fnordovax.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1246579473.3339.96.camel-76q0VzFBGGr21HsLBtNmTckMGDeJXHgy@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/03/2009 02:04 AM, Victor Lowther wrote:
> On Thu, 2009-07-02 at 16:10 +0200, Harald Hoyer wrote:
>> On 07/02/2009 03:20 PM, Seewer Philippe wrote:
>>>>> Why not just put cryptsetup back into mountscripts as I've suggested
>>>>> before?
>>>>>
>>>> Because so much more can be inside the crypto partition, which might
>>>> need further processing.
>>> That is correct. But if it's in mountscripts, it would fire more
>>> udev-events which are caught again by udevadm settle. I don't see
>>> a problem there.
>> Hmm, we maybe should think of merging pre-mount and mount.
>> pre-mount makes no sense, if mounting is done inside udev rules.
>
> I would like to chime in again with the longstanding race condition
> inherent in having resume from hibernate and root fs mounting as udev
> rules.

Right. Maybe we really should not mount from udev rules, and only generate a 
/mount script or set a symlink to /dev/root.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
