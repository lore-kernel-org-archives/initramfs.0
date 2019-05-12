From: hpa@zytor.com
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial ram disk
Date: Sun, 12 May 2019 03:18:16 -0700
Message-ID: <4E92753A-04BD-4018-A3A4-5E3E4242D8B9@zytor.com>
References: <20190509112420.15671-1-roberto.sassu@huawei.com> <20190512091748.s6fvy2f5p2a2o6ja@isilmar-4.linta.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x4CAIN7l2991902
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1557656306;
        bh=Sy4FTuOUSedIkErrZ5lDW71XRGPcUXqj45OdYbBsoqY=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=oImKz1LNFVMdrQxMMMNLKoqqQaVHc7Uv+sLqZpIK3Pm0CY+wCuE7fKdablrzkd94N
         WkffPQW3oiMcMefKNzH18l/Dg+JmFpXcrfIJNZ3IGvMnvkVZHmsQ8/ZGlVtQpbLhBe
         jh+p68S4gaKZ9Mrjy2ns5tiDv6u342eiv2k95evNdiNCRHs32SAuvcjTjixCpq+cQt
         w8tBfBWvV8jufKfqRP2VHsLZ27DeNHCtwmCjj+sTHf83JV7p4aPKkUDzcSgAxT9KjE
         j80F8tGt0xVmhCoQR5JNwkD8BqobjcASWIwhPgV32+tc5nd1bf4YfT0KhS/XF4RjmX
         5wPYnlqZ7/k5w==
In-Reply-To: <20190512091748.s6fvy2f5p2a2o6ja@isilmar-4.linta.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dominik Brodowski <linux@dominikbrodowski.net>, Roberto Sassu <roberto.sassu@huawei.com>
Cc: viro@zeniv.linux.org.uk, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, initramfs@vger.kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com, takondra@cisco.com, kamensky@cisco.com, arnd@arndb.de, rob@landley.net, james.w.mcmechan@gmail.com

On May 12, 2019 2:17:48 AM PDT, Dominik Brodowski <linux@dominikbrodowski=
=2Enet> wrote:
>On Thu, May 09, 2019 at 01:24:17PM +0200, Roberto Sassu wrote:
>> This proposal consists in marshaling pathnames and xattrs in a file
>called
>> =2Exattr-list=2E They are unmarshaled by the CPIO parser after all file=
s
>have
>> been extracted=2E
>
>Couldn't this parsing of the =2Exattr-list file and the setting of the
>xattrs
>be done equivalently by the initramfs' /init? Why is kernel involvement
>actually required here?
>
>Thanks,
>	Dominik

There are a lot of things that could/should be done that way=2E=2E=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
