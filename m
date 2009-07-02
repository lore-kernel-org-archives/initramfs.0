From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: initqueue
Date: Thu, 02 Jul 2009 14:52:43 +0200
Message-ID: <4A4CAD9B.10503@redhat.com>
References: <4A4C87DF.10904@redhat.com> <4A4CAA92.9000401@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A4CAA92.9000401-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/02/2009 02:39 PM, Seewer Philippe wrote:
> Harald Hoyer wrote:
>> To move all "big" jobs out of the udev event handling, I introduce the
>> "initqueue". This prevents the job from being killed by udev timeouts.
>>
>> See
>> http://dracut.git.sourceforge.net/git/gitweb.cgi?p=dracut;a=commit;h=eab677a2164bccb3990487dc5ef4549b30cb1055
>>
>>
>> for the patch.
>>
>> Basically inside a udev event, you don't do
>>
>> RUN+="/sbin/ifup $env{INTERFACE}"
>>
>> you now queue this in the initqueue with:
>>
>> RUN+="/sbin/initqueue /sbin/ifup $env{INTERFACE}"
>>
>> Inside init all jobs are worked on in serial order by the
>> do_initqueue() function.
>>
>> Now we have no more side effects due to the parallel nature of udev
>> and still be fast, in case udev supports "udevadm settle
>> --exit-if-exists="
>
> Please don't do that. That way we actually loose the benefit of doing as
> much in parallel as possible. Instead please consider the patch below.
> I've been fiddling with this for a few weeks now. It basically replaces
> the current "wait-for-root" loop with a loop that queries the udev-queue
> and only exits if either root is available or all udev events have been
> processed.
>
> It works, except if a udev event takes longer than the default 180s as is
> the case with an unpatches cryptsetup and/or if we do user-interaction
> from within udev which we shouldn't do anyway.
>
> Thank you,
> Philippe
>

Well, you could remove the initqueue for ifup events, but I would like to keep 
it at least for cryptsetup.

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
