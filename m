From: Rob Landley <rob@landley.net>
Subject: Re: [RFC][PATCH] fs: set xattrs in initramfs from regular files
Date: Fri, 23 Nov 2018 14:21:34 -0600
Message-ID: <7f2b0288-a173-e2bb-70ee-d552610bfc1e@landley.net>
References: <20181122154942.18262-1-roberto.sassu@huawei.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0ztVUjuR029DPuq6x1COYKxRhgpBTvFYUQJdXiWMSsY=;
        b=QHg+1Glvk7KVsuJp7mdds9RnOMm9MUE5lHaigz6dVIESzE+lM0ulpzN3RurgPx8/ii
         oltlMRx9XnrOFFyipqW1iqq/3+l34wHxJO68tYHKDe0K6Frvg7OJRLQaH+bVOaBu3qeG
         2TAkwyR4ial7zcNN7GOeFafLky+ns+WP6SCDLsqNIw30P0RDH+uSbot5WHNOp6CEtyA8
         vDBb+VRd89QGXGkVklJ7euvqXEkxuiq6cEwlEK/GSJsQP1Bxfq0Y10/FyXafr6gbOoRY
         eFPPJVr/cDdevfu/HtrkDV4AHnJzUtCnCiCkNjZC52JaHoJ/rS9Fd+K2qMhfJ0QHdXGz
         7AgA==
In-Reply-To: <20181122154942.18262-1-roberto.sassu@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Roberto Sassu <roberto.sassu@huawei.com>, viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, initramfs@vger.kernel.org, linux-kernel@vger.kernel.org, zohar@linux.ibm.com, silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com, takondra@cisco.com, kamensky@cisco.com, hpa@zytor.com, arnd@arndb.de, james.w.mcmechan@gmail.com

On 11/22/18 9:49 AM, Roberto Sassu wrote:
> Although rootfs (tmpfs) supports xattrs, they are not set due to the
> limitation of the cpio format. A new format called 'newcx' was proposed to
> overcome this limitation.

I got email about that format the day before you posted this, by the way.

> However, it looks like that adding a new format is not simple: 15 kernel
> patches; user space tools must support the new format; mistakes made in the
> past should be avoided; it is unclear whether the kernel should switch from
> cpio to tar.

The kernel _can't_ switch from cpio to tar without breaking backwards
compatability, it could only add tar as a second format it supported (remember
cpio images can be sideloaded so a new rootfs can be used with an existing
initramfs, plus existing build systems generate them and would still need to if
they wanted to keep supporting older kernels), and then once you've got two
formats somebody will propose zip support, and let's just not go there please.

The changes to the userspace tools are trivial (I say that as the maintainer of
toybox, which has a cpio). The argument was about things like 64 bit timestamps
(y2038 problem), nanosecond support, sparse files, etc. And I think the argument
had largely died down?

Keep in mind the squashfs guy spent 5 years trying to get his filesystem merged
(https://lwn.net/Articles/563578/), I spent several years trying to get my perl
removal patch merged (and only work up the enthusiasm to resubmit
http://lists.busybox.net/pipermail/buildroot/2015-March/123385.html
https://patchwork.kernel.org/patch/9193529/ https://lkml.org/lkml/2017/9/13/651
about once a year because dealing with linux-kernel is just no fun for hobbyists
anymore).

> The aim of this patch is to provide the same functionality without
> introducing a new format. The value of xattrs is placed in regular files
> having the same file name as the files xattrs are added to, plus a
> separator and the xattr name (<filename>.xattr-<xattr name>).

I think you're solving the wrong problem, but that's just my opinion.

Rob
