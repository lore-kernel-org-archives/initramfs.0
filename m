From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
Date: Thu, 9 May 2019 13:34:13 -0500
Message-ID: <fca8e601-1144-1bb8-c007-518651f624a5@landley.net>
References: <20190509112420.15671-1-roberto.sassu@huawei.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6LDuh9KBtjyZgSBqOPlt4ghOhYRTyR7+OimbX5fXjTc=;
        b=m7MZm5jn+yUTyqYeKP+3U2AfIk2e/Jl7gRlj1d0vNElu89qzzwPGU4WFh2pRN3iGK8
         6NkXYiIaZxmWqTWtDTsXMCjBrxg3Wi+ON8VLjl28KeXWmZ1yCAk7U2iA9U5wOLGpVrf6
         4C4jvycCm53aEaILky7UnN3UKRuEHLH4DYCjk6kbWNpnMsPw3O4PTkZ34RDNe5jWnbck
         UmNUnENCXk7ZL3MZ1rYS34gPy7dbedYHUod/vucgxDHzv2UGKYZZ9m/Ped5rsgK+BFk/
         Fy+UM5SnDsH5pIswj8zYSyHMqUWESF+i8+t6ovRwRYGQ/c3kpcWuWIDJlTrTTBHJz/6S
         zOfA==
In-Reply-To: <20190509112420.15671-1-roberto.sassu@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Roberto Sassu <roberto.sassu@huawei.com>, viro@zeniv.linux.org.uk
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, initramfs@vger.kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com, takondra@cisco.com, kamensky@cisco.com, hpa@zytor.com, arnd@arndb.de, james.w.mcmechan@gmail.com

On 5/9/19 6:24 AM, Roberto Sassu wrote:
> This patch set aims at solving the following use case: appraise files from
> the initial ram disk. To do that, IMA checks the signature/hash from the
> security.ima xattr. Unfortunately, this use case cannot be implemented
> currently, as the CPIO format does not support xattrs.
> 
> This proposal consists in marshaling pathnames and xattrs in a file called
> .xattr-list. They are unmarshaled by the CPIO parser after all files have
> been extracted.

So it's in-band signalling that has a higher peak memory requirement.

> The difference with another proposal
> (https://lore.kernel.org/patchwork/cover/888071/) is that xattrs can be
> included in an image without changing the image format, as opposed to
> defining a new one. As seen from the discussion, if a new format has to be
> defined, it should fix the issues of the existing format, which requires
> more time.

So you've explicitly chosen _not_ to address Y2038 while you're there.

Rob
