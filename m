From: "Li, David" <LiD-H5gcd31RMI4yhQnFlXSU7w@public.gmane.org>
Subject: RE: Q: mount initramfs as the final root fs
Date: Tue, 17 Jan 2012 07:12:21 -0800
Message-ID: <A0D5581BE022624487D06FF31DA39EAC46DBF15F3F@cs-mail.cloudshield.com>
References: <CAADET=cG8mdu-Je_MUGyKOP_G9sfU6sR3KHxybFMREjvexrKmg@mail.gmail.com>
 <jepo04$nc5$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <jepo04$nc5$1@dough.gmane.org>
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

I am not familiar with dracut internals. Can you or someone be a little more specific on how it's not supported to mount initramfs itself as final root fs? What are my options or alternatives?

David

>-----Original Message-----
>From: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:initramfs-
>owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Cong Wang
>Sent: Friday, January 13, 2012 9:01 AM
>To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>Subject: Re: Q: mount initramfs as the final root fs
>
>On Thu, 12 Jan 2012 at 00:54 GMT, David Li <w.david.li-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Hi Everyone,
>>
>> I need to let the kernel to mount the initramfs (created by dracut) as
>> the final root filesystem. No disk and no NFS either!
>>
>> I tried kernel option root=/dev/ram0 (the initrd way to mount init ram
>> disk) but dracut didn't recognize this option. What should I use to
>> accomplish this?
>>
>
>AFAIK, drauct doesn't support this currently. Think about that, who will mkfs
>your /dev/ram0? Dracut has to do that if you want this working. It would not
>be hard to make a patch for this, I think.
>
>
>--
>To unsubscribe from this list: send the line "unsubscribe initramfs" in the body
>of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at
>http://vger.kernel.org/majordomo-info.html
