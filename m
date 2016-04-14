From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut: 99base: do not mount /run with the "noexec"
 option
Date: Thu, 14 Apr 2016 13:30:28 +0200
Message-ID: <570F7F54.5050904@redhat.com>
References: <1460470060.3152.3.camel@trentalancia.net>
 <570D0533.6070704@redhat.com> <1460472110.3152.14.camel@trentalancia.net>
 <570F71FD.3020101@redhat.com> <1460632714.2782.3.camel@trentalancia.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460632714.2782.3.camel-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 14.04.2016 13:18, Guido Trentalancia wrote:
> Hello Harald.
> 
> My reply follows the quoted text from previous messages...
> 
> On gio, 2016-04-14 at 12:33 +0200, Harald Hoyer wrote:
>> On 12.04.2016 16:41, Guido Trentalancia wrote:
>>> On mar, 2016-04-12 at 16:24 +0200, Harald Hoyer wrote:
>>>> Am 12.04.2016 um 16:07 schrieb Guido Trentalancia:
>>>>> Do not mount the /run directory with the "noexec" option,
>>>>> otherwise
>>>>> the
>>>>> system bootup fails (no binary can be executed, everything
>>>>> fails
>>>>> with
>>>>> permission denied errors).
>>>>>
>>>>> The bug was introduced in version 042 (11 Jun 2015) and affects
>>>>> all
>>>>> versions up to 044 (latest) and including git checked out on 12
>>>>> Apr
>>>>> 2016.
>>>>>
>>>>> Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
>>>>> ---
>>>>>  modules.d/99base/init.sh |    2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> --- dracut-044/modules.d/99base/init.sh	2015-11-25
>>>>> 14:22:28.000000000 +0100
>>>>> +++ dracut-044-99base-init-should-mount-newrun-as-
>>>>> exec/modules.d/99base/init.sh	2016-04-12
>>>>> 15:37:44.163185387
>>>>> +0200
>>>>> @@ -64,7 +64,7 @@ fi
>>>>>  
>>>>>  if ! ismounted /run; then
>>>>>      mkdir -m 0755 /newrun
>>>>> -    mount -t tmpfs -o
>>>>> mode=0755,noexec,nosuid,nodev,strictatime
>>>>> tmpfs /newrun >/dev/null
>>>>> +    mount -t tmpfs -o mode=0755,nosuid,nodev,strictatime tmpfs
>>>>> /newrun >/dev/null
>>>>>      cp -a /run/* /newrun >/dev/null 2>&1
>>>>>      mount --move /newrun /run
>>>>>      rm -fr -- /newrun
>>>>>
>>>>
>>>> Which binary resides in /run ??
>>>
>>>
>>> The whole initram filesystem binaries, including
>>> (/run/initramfs)/bin,
>>> (/run/initramfs)/sbin, (/run/initramfs)/usr/bin and
>>> (/run/initramfs)/usr/sbin.
> 
> [...]
> 
>>> The patch has been tested and it works fine. Without the patch,
>>> dracut
>>> is unusable (the system cannot be booted).
> 
> [...]
> 
>> I would prefer something like this. Care to check, if that solves it?
> 
> No, it does NOT work.
> 
> Harald, you should apply the patch I sent to you (and quoted above),
> unmodified in order to sort out this major bug which produces
> unbootable initram filesystems.

Well, this is a corner case.

May I ask:

Which distribution do you use?

Which dracut version do you use?

What is the output of:
# lsinitrd <initramfs_image>

What is the output of:
# egrep . /etc/dracut.conf /etc/dracut.conf.d/*.conf /usr/lib/dracut/dracut.conf.d/*.conf

