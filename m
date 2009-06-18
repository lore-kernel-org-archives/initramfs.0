From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: root=dhcp dhclient segfaulting on F-11
Date: Thu, 18 Jun 2009 10:18:42 +0200
Message-ID: <4A39F862.7060200@redhat.com>
References: <4A391744.4040607@redhat.com> <4A3923F7.6000900@bfh.ch> <4A3924B9.2090303@redhat.com> <4A398A7C.40003@redhat.com> <4A39A3D1.4070404@redhat.com> <4A39ED97.8040503@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A39ED97.8040503-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/18/2009 09:32 AM, Seewer Philippe wrote:
>
>
> Warren Togami wrote:
>> https://bugzilla.redhat.com/show_bug.cgi?id=506626
>>
>> Filed the dhclient segfault here. I've been trying to debug this for
>> the past 5 hours straight. I'm perplexed.
>>
>> Backing out to 1a945a576c0016c47f983d27727443ac33c5b6a8 prior to
>> Phillippe's patch series dhclient does not crash.
>
> That is weird. I have no problems at all with isc-dhclient-V3.1.1
>
> Question: Does it segfault in the test-suites as well?
>

WORKSFORME
fine with: dhclient-4.1.0-20.fc11.x86_64
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
