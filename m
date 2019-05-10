From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
Date: Fri, 10 May 2019 15:46:30 -0500
Message-ID: <3a9d717e-0e12-9d62-a3cf-afb7a5dbf166@landley.net>
References: <20190509112420.15671-1-roberto.sassu@huawei.com>
 <fca8e601-1144-1bb8-c007-518651f624a5@landley.net>
 <bf0d02fc-d6ce-ef1d-bb7d-7ca14432c6fd@huawei.com>
 <1557488971.10635.102.camel@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aj6INEqnnfoQNhyU5G7iw5JJmBhRXMSKlpuNHBS6Zik=;
        b=RUS1u52QMGXhtmf6NRCHIrzXEoaN3rFUW9pkgWLoZZ/UVaEQXywiJB9ZHGrvG+E5ca
         2GGYdp0mldCJnm1zE4Png/lpgHEWd0dki4rG2TWPVZNwPtjkH+onGmDNDap4ySjHRU5L
         ijk4gDOGgTTThNQTw5ZrovFwcwUUSI/K/+IuGRIx5qmh597mFvjxEiphK3DcL8ooFbWQ
         RBcyReeKi40Rtp24bcEnymoPElT6C/olCSYSrSYR6wHWipzRbOvrrPOMPa+oHTSeRWzd
         dAD9v7yG8hRCFFwcxwj2TLXadD6bRo2gBoaS2yo7q6lALLa0PJwQdD5xqR5xHr8xJArg
         tDzg==
In-Reply-To: <1557488971.10635.102.camel@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, viro@zeniv.linux.org.uk
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, initramfs@vger.kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com, takondra@cisco.com, kamensky@cisco.com, hpa@zytor.com, arnd@arndb.de, james.w.mcmechan@gmail.com

On 5/10/19 6:49 AM, Mimi Zohar wrote:
> On Fri, 2019-05-10 at 08:56 +0200, Roberto Sassu wrote:
>> On 5/9/2019 8:34 PM, Rob Landley wrote:
>>> On 5/9/19 6:24 AM, Roberto Sassu wrote:
>=20
>>>> The difference with another proposal
>>>> (https://lore.kernel.org/patchwork/cover/888071/) is that xattrs can be
>>>> included in an image without changing the image format, as opposed to
>>>> defining a new one. As seen from the discussion, if a new format has t=
o be
>>>> defined, it should fix the issues of the existing format, which requir=
es
>>>> more time.
>>>
>>> So you've explicitly chosen _not_ to address Y2038 while you're there.
>>
>> Can you be more specific?
>=20
> Right, this patch set avoids incrementing the CPIO magic number and
> the resulting changes required (eg. increasing the timestamp field
> size), by including a file with the security xattrs in the CPIO. =C2=A0In
> either case, including the security xattrs in the initramfs header or
> as a separate file, the initramfs, itself, needs to be signed.

The /init binary in the initramfs runs as root and launches all other proce=
sses
on the system. Presumably it can write any xattrs it wants to, and doesn't =
need
any extra permissions granted to it to do so. But as soon as you start putt=
ing
xattrs on _other_ files within the initramfs that are _not_ necessarily run=
ning
as PID 1, _that's_ when the need to sign the initramfs comes in?

Presumably the signing occurs on the gzipped file. How does that affect the=
 cpio
parsing _after_ it's decompressed? Why would that be part of _this_ patch?

Rob
