From: hpa@zytor.com
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial ram disk
Date: Sun, 12 May 2019 17:21:17 -0700
Message-ID: <3723FF4B-FD47-47AE-A22B-A09C841C192B@zytor.com>
References: <20190512153105.GA25254@light.dominikbrodowski.net> <1557705750.10635.264.camel@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x4D0LPJI3267342
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1557706888;
        bh=MXOP1H5Q8wzqyUCZ5+/1Bn1fRnvon+xLVNozK6hblOE=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=E7K9LRPnT4UX45fInarVMN46V3FPpyDVbXvF5vpWco9jr+ghJt2M9yML3SRX5sUxB
         wvG7aLWJLZjaVLF3+k740kbO1XICJe4LFm+Cxf1EgypiI/LtsNZKGQ3RxaXzln5pbT
         rhK8E3cY8h4uqaHofGnU1knv2U3iU8nfPt1IqJ/ZEeBClaKjDIOQKDkX3+SKV+k4M+
         1dyFYS6PA5/Gdn40A3oNy9YYF3AQPZwWQdOZeqbpfoM30LFD1NsX8HRY9yZtgcqYDf
         mDw1OGUFsZPF+emsvS9NlrA8Cn2taXgAfN5psL8sA1cdYT8Cscbyk9YTzwCdNfuqcL
         CsoHOnDg0kuSQ==
In-Reply-To: <1557705750.10635.264.camel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Mimi Zohar <zohar@linux.ibm.com>, Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, viro@zeniv.linux.org.uk, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, initramfs@vger.kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com, takondra@cisco.com, kamensky@cisco.com, arnd@arndb.de, rob@landley.net, james.w.mcmechan@gmail.com

On May 12, 2019 5:02:30 PM PDT, Mimi Zohar <zohar@linux=2Eibm=2Ecom> wrote:
>On Sun, 2019-05-12 at 17:31 +0200, Dominik Brodowski wrote:
>> On Sun, May 12, 2019 at 08:52:47AM -0400, Mimi Zohar wrote:
>
>
>> > It's too late=2E  The /init itself should be signed and verified=2E
>>=20
>> Could you elaborate a bit more about the threat model, and why
>deferring
>> this to the initramfs is too late?
>
>The IMA policy defines a number of different methods of identifying
>which files to measure, appraise, audit=2E[1] =C2=A0Without xattrs, the
>granularity of the policy rules is severely limited=2E =C2=A0Without xatt=
rs,
>a filesystem is either in policy, or not=2E
>
>With an IMA policy rule requiring rootfs (tmpfs) files to be verified,
>then /init needs to be properly labeled, otherwise /init will fail to
>execute=2E
>
>Mimi
>
>[1] Documentation/ABI/testing/ima_policy

And the question is what is the sense in that, especially if /init is prov=
ided as play of the kernel itself=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
