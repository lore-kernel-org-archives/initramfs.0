From: Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>
Subject: Re: [RFC PATCH] rootfs: force mounting rootfs as tmpfs
Date: Thu, 1 Feb 2018 17:34:41 -0600
Message-ID: <8d6b1fcc-1a21-1707-dd8e-43529e1d644c@landley.net>
References: <1517348777.3469.5.camel@linux.vnet.ibm.com>
 <1814af5c-170d-39c0-58fd-02eb7216e008@landley.net>
 <1517436423.3469.237.camel@linux.vnet.ibm.com>
 <a538e55c-81ca-6d59-20cf-21b47387c3e2@landley.net>
 <20180201020331.GA3774@rani.riverdale>
 <1517458921.3329.2.camel@linux.vnet.ibm.com>
 <f9112881-772c-2568-ebfa-d2ca807124e9@landley.net>
 <1517500500.3974.45.camel@linux.vnet.ibm.com>
 <875e5d2d-9ffe-14ab-090a-4a9632af0f35@landley.net>
 <1517521912.3619.0.camel@linux.vnet.ibm.com>
 <151752488608.10051.146219644323454814@takondra-t460s>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EP/X+caNgvEmT1s8gQX1wRLe8EpymstDb7t7iX/YB4E=;
        b=WVNZ/OGg5gxTTVcISfb9MjvPeQRGFOuEp7VPWltYiqpoc0kFg3v/AKfvJ+DD80/i/U
         HwQyhAqIiEPpDeST9B/3JG00HLZyXB3lbE137SNEv9WYiuVfOh6LTgvE1rUS0233WA05
         p4CiB5BxxzV0dl0fvI0nf0yx0lA6iy2MOK9t2DtRZBgf0Q2j7mMzwGHEtQ7CP5x9hY0o
         AD2EdIpoMfUGTdQvTEf2IiPEC5xcUW6m74NBM3otxDP5AqGkBnmTOPCyvpS/ih1nvAUu
         XPTY/6Fh2T9yYvjx04ZRdDdQ7Q5V5J/J6VHtOCFMGK4oGVoGFjoY+rZ4E1cQJOwHeEJI
         WXPg==
In-Reply-To: <151752488608.10051.146219644323454814@takondra-t460s>
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Taras Kondratiuk <takondra-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, Arvind Sankar <nivedita-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>, Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Victor Kamensky <kamensky-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, linux-security-module <linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-3bDd1+5oDREiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



On 02/01/2018 04:41 PM, Taras Kondratiuk wrote:
> Quoting Mimi Zohar (2018-02-01 13:51:52)
>> On Thu, 2018-02-01 at 11:09 -0600, Rob Landley wrote:
>>> On 02/01/2018 09:55 AM, Mimi Zohar wrote:
>>>> On Thu, 2018-02-01 at 09:20 -0600, Rob Landley wrote:
>>>>
>>>>>> With your patch and specifying "root=3Dtmpfs", dracut is complaining:
>>>>>>
>>>>>> dracut: FATAL: Don't know how to handle 'root=3Dtmpfs'
>>>>>> dracut: refusing to continue
>>>>>
>>>>> [googles]... I do not understand why this package exists.
>>>>>
>>>>> If you're switching to another root filesystem, using a tool that
>>>>> wikipedia[citation needed] says has no purpose but to switch to anoth=
er
>>>>> root filesystem, (so let's reproduce the kernel infrastructure in
>>>>> userspace while leaving it the kernel too)... why do you need initram=
fs
>>>>> to be tmpfs? You're using it for half a second, then discarding it,
>>>>> what's the point of it being tmpfs?
>>>>
>>>> Unlike the kernel image which is signed by the distros, the initramfs
>>>> doesn't come signed, because it is built on the target system. =C2=A0E=
ven
>>>> if the initramfs did come signed, it is beneficial to measure and
>>>> appraise the individual files in the initramfs.
>>>
>>> You can still shoot yourself in the foot with tmpfs. People mount a /run
>>> and a /tmp and then as a normal user you can go
>>> https://twitter.com/landley/status/959103235305951233 and maybe the
>>> default should be a little more clever there...
>>>
>>> I'll throw it on the todo heap. :)
>>>
>>>>> Sigh. If people are ok with having rootfs just be tmpfs whenever tmpfs
>>>>> is configured in, even when you're then going to overmount it with
>>>>> something else like you're doing, let's just _remove_ the test. If it
>>>>> can be tmpfs, have it be tmpfs.
>>>>
>>>> Very much appreciated!
>>>
>>> Not yet tested, but something like the attached? (Sorry for the
>>> half-finished doc changes in there, I'm at work and have a 5 minute
>>> break. I can test properly this evening if you don't get to it...)
>>
>> Yes, rootfs is being mounted as tmpfs.
>=20
> I don't think you can unconditionally replace ramfs with initramfs by
> default. Their behavior is different in some cases (e.g. pivot_root vs
> switch_root)

Both are switch_root, you can't pivot_root off of either one. (Yes, I
hit that bug and reported it, and they fixed it, back in the day...
http://lists.busybox.net/pipermail/busybox/2006-March/053529.html )

> and it can break many systems that expect ramfs by default.

The use case I told Mimi about off-list (since they stopped cc:ing the
list in one of their replies but the conversation continued) was the guy
who was extracting an initramfs bigger than 50% of system memory, which
worked with initramfs but failed with initmpfs. A quick google didn't
find the original message but it resulted in this blog entry from the
affected party:

http://www.lightofdawn.org/blog/?viewDetailed=3D00128

I.E. yeah, I know, I need to redo these patches tonight.

Rob
