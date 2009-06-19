From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: How to find the root partition with root=dhcp root-path=iscsi:::...
Date: Fri, 19 Jun 2009 08:21:33 +0200
Message-ID: <4A3B2E6D.2000809@redhat.com>
References: <4A3A4F8F.8070204@redhat.com> <4A3A65EC.1010404@redhat.com> <4A3A72E9.3000605@redhat.com> <1245380152.28792.9.camel@lap75545.ornl.gov>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245380152.28792.9.camel-FqX9LgGZnHWDB2HL1qBt2PIbXMQ5te18@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/19/2009 04:55 AM, David Dillow wrote:
> On Thu, 2009-06-18 at 19:01 +0200, Harald Hoyer wrote:
>> On 06/18/2009 06:06 PM, Warren Togami wrote:
>>> On 06/18/2009 10:30 AM, Harald Hoyer wrote:
>>>> If we have root=dhcp and root-path from dhcp with "iscsi::... " nothing
>>>> is know about the partition where root lives in.
>>>>
>>>> RFC:
>>>> provide a pre-mount fallback, which tries to mount
>>>>
>>>> /dev/disk/by-label/\x2f (LABEL=/)
>>>> /dev/disk/by-label/ROOT (LABEL=ROOT)
>>> I think this was the intent of netroot=dhcp for remote block device
>>> protocols, then you can define something else in root=. Whether it is
>>> implemented yet I don't know.
>>>
>>> Warren
>> Well, but the root-path does not specify the root partition!
>> Either we extend the iscsi:::: spec with a root partition or we make
>> requirements like I did above.
>
> The RFC only says we need to boot off the LUN specified, 0 if none
> listed. That's your default partition.

ok, so the LUN is the partition number?
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
