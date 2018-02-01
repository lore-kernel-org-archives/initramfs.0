From: Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>
Subject: Re: [RFC PATCH] rootfs: force mounting rootfs as tmpfs
Date: Thu, 1 Feb 2018 09:20:23 -0600
Message-ID: <f9112881-772c-2568-ebfa-d2ca807124e9@landley.net>
References: <1517348777.3469.5.camel@linux.vnet.ibm.com>
 <1814af5c-170d-39c0-58fd-02eb7216e008@landley.net>
 <1517436423.3469.237.camel@linux.vnet.ibm.com>
 <a538e55c-81ca-6d59-20cf-21b47387c3e2@landley.net>
 <20180201020331.GA3774@rani.riverdale>
 <1517458921.3329.2.camel@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2w1nOcy6Ju6Um/TmjufEdPg1TIXTYOU+rv4g044PIzw=;
        b=HBiGi6Kvz5d1x+Ij60RqC/Us3dEHn74Ki/kQUL5GMxHYkS7VUMKV2czcnwMwRuEvhx
         cQi68+ajl6TcT/3oPvVMBSxsh8gx0/rELSqduMxl/xXrSIuy4dfkdpcS/dqVSCIlbzKE
         8yxFHoAcIJiqk/Qhppu4ukr/9XU1/jUIq60Xc894XxlKhqO925mVUabYbEIEIGK9g0v5
         qB8gwlaJvZg0N+U057rxZknrq6QPQAPDh1yNMdFhxNnHkLoXrqF2c8huiWD6OlHLKMAa
         T00eJwBeHMu9y1dGSgisEOURoGrRQufUqWa70xNkgiNFgC90ORKUV6nnVXcI95LaPAPh
         ehDQ==
In-Reply-To: <1517458921.3329.2.camel-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Arvind Sankar <nivedita-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Taras Kondratiuk <takondra-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, Victor Kamensky <kamensky-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, linux-security-module <linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-3bDd1+5oDREiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



On 01/31/2018 10:22 PM, Mimi Zohar wrote:
> On Wed, 2018-01-31 at 21:03 -0500, Arvind Sankar wrote:
>> On Wed, Jan 31, 2018 at 05:48:20PM -0600, Rob Landley wrote:
>>> On 01/31/2018 04:07 PM, Mimi Zohar wrote:
>>>> On Wed, 2018-01-31 at 13:32 -0600, Rob Landley wrote:>> (The old "I co=
nfigured in tmpfs and am using rootfs but I want that
>>> rootfs
>>>>> to be ramfs, not tmpfs" code doesn't seem to be a real-world concern,=
 does
>>>>> it?)
>>>>
>>>> I must be missing something. =C2=A0Which systems don't specify "root=
=3D" on
>>>> the boot command line.
>>>
>>> Any system using initrd or initramfs?
>>>
>>
>> Don't a lot of initramfs setups use root=3D to tell the initramfs which
>> actual root file system to switch to after early boot?

You mean the option that _isn't_ passed through as an environment
variable (the way ROOT=3D would be) so you have to parse /proc/cmdline to
to see if it was passed in?

If you really, really, really, really, really want to double down on the
"no, this is the button, it doesn't do what I thought but I will MAKE it
work" obsession, sure.

> With your patch and specifying "root=3Dtmpfs", dracut is complaining:
>=20
> dracut: FATAL: Don't know how to handle 'root=3Dtmpfs'
> dracut: refusing to continue

[googles]... I do not understand why this package exists.

If you're switching to another root filesystem, using a tool that
wikipedia[citation needed] says has no purpose but to switch to another
root filesystem, (so let's reproduce the kernel infrastructure in
userspace while leaving it the kernel too)... why do you need initramfs
to be tmpfs? You're using it for half a second, then discarding it,
what's the point of it being tmpfs?

Sigh. If people are ok with having rootfs just be tmpfs whenever tmpfs
is configured in, even when you're then going to overmount it with
something else like you're doing, let's just _remove_ the test. If it
can be tmpfs, have it be tmpfs.

Rob
