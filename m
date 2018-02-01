From: Rob Landley <rob@landley.net>
Subject: Re: [RFC PATCH] rootfs: force mounting rootfs as tmpfs
Date: Thu, 1 Feb 2018 16:46:07 -0600
Message-ID: <a9249307-9c95-ea75-bc83-7b95412e6ec4@landley.net>
References: <1517348777.3469.5.camel@linux.vnet.ibm.com>
 <1814af5c-170d-39c0-58fd-02eb7216e008@landley.net>
 <1517436423.3469.237.camel@linux.vnet.ibm.com>
 <a538e55c-81ca-6d59-20cf-21b47387c3e2@landley.net>
 <20180201020331.GA3774@rani.riverdale>
 <1517458921.3329.2.camel@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EhmkdiV9F5KdvA+rvaEhA2Y0KqUjvJzAPh+0MPhVoMw=;
        b=l2tevXz2u0UEQr2LGTAtfoLW4m6g1+vUWTuHbLbh58PqCsLHuyQ+pjSQaeFxbmZMHU
         E5hT9ZVlaVphPh9307s2zeg1cR4HffK6ZRulUlDARiOP3S0es/LfSDwczhNAcelSuhR9
         SFkfjScjCsq19mvDMkRNXONN1cUnNANHSlKidzktrhZXrgMey9PQQaQRasG1XslFKXP8
         eWXKIFVjPg5vsn79MXAoYDiC4obWJxC1DOHP9MOFd9keN4/1vE3sOx0xf1TAD2WCCfTT
         w4OL3e7U+KzOD12X4zctYyKilDgvKaZfDwAB9C1eLU4jODmYsxpQRII3czp9JOKOTugA
         k11w==
In-Reply-To: <1517458921.3329.2.camel@linux.vnet.ibm.com>
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Mimi Zohar <zohar@linux.vnet.ibm.com>, Arvind Sankar <nivedita@alum.mit.edu>
Cc: initramfs <initramfs@vger.kernel.org>, Taras Kondratiuk <takondra@cisco.com>, Victor Kamensky <kamensky@cisco.com>, linux-security-module <linux-security-module@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel <linux-kernel@vger.kernel.org>



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
>=20
> With your patch and specifying "root=3Dtmpfs", dracut is complaining:
>=20
> dracut: FATAL: Don't know how to handle 'root=3Dtmpfs'
> dracut: refusing to continue

"The kernel can't break this buggy userspace package."

"The kernel must give access to a new feature to this buggy userspace
package".

I think kernel policy asks you to pick one, but I could be wrong...

Rob
--
To unsubscribe from this list: send the line "unsubscribe linux-security-mo=
dule" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
