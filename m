From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: rdblacklist intent?
Date: Wed, 17 Jun 2009 15:57:55 -0400
Message-ID: <4A394AC3.9080104@redhat.com>
References: <4A3933F9.5080706@redhat.com> <4A394475.5040608@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A394475.5040608-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/17/2009 03:31 PM, Harald Hoyer wrote:
> Am 17.06.2009 20:20, schrieb Warren Togami:
>> http://sourceforge.net/apps/trac/dracut/wiki/commandline
>>> Misc =B6
>>>
>>> * rdblacklist=3D<modulename>
>>> o TBD: do not load modulename
>>
>>
>> I'm not sure how this is supposed to work. This page is full of kern=
el
>> cmdline parameters, but <modulename> no longer exists as an independ=
ent
>> named entity during initrd runtime.
>>
>
> this is for kernel module to blacklist, which are not to be autoloade=
d
> be udev
>

Seems it isn't implemented in dracut yet.

I am updating the documentation to reduce the confusion by calling it=20
<drivername> instead of <modulename>.

Warren
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
