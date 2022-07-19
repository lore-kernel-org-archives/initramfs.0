From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH v4 0/3] initramfs: add support for xattrs in the initial
 ram disk
Date: Tue, 19 Jul 2022 06:00:04 -0500
Message-ID: <99ae4aa6-b55a-55a9-e836-b0b483a358d6@landley.net>
References: <33cfb804-6a17-39f0-92b7-01d54e9c452d@huawei.com>
 <1561909199.3985.33.camel@linux.ibm.com>
 <45164486-782f-a442-e442-6f56f9299c66@huawei.com>
 <1561991485.4067.14.camel@linux.ibm.com>
 <f85ed711-f583-51cd-34e2-80018a592280@huawei.com>
 <0c17bf9e-9b0b-b067-cf18-24516315b682@huawei.com>
 <20220609102627.GA3922@lxhi-065>
 <21b3aeab20554a30b9796b82cc58e55b@huawei.com>
 <20220610153336.GA8881@lxhi-065>
 <4bc349a59e4042f7831b1190914851fe@huawei.com>
 <20220615092712.GA4068@lxhi-065>
 <032ade35-6eb8-d698-ac44-aa45d46752dd@mentor.com>
 <f82d4961986547b28b6de066219ad08b@huawei.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ra5x2/muxSeeSQ3tlCgpeqbladVRxJnxCPl4bJq3p34=;
        b=2lKKxFzSTFfoAqHkPQJOZzk9NSwhvMVfz9AI6037udC8exCOdgmjJTCzLfGNh8TiZR
         juF5/5iF/lwpY0I4eBxOM7ch26XEY1pzvru00V28d56VKmfDdmUC/dvbNUXfD/GneoTj
         e62bDsHZKQ06qjQfN6BdAPe8q7wMqzTya9y9Oxq/85+9tv+FEcRChm48xzwJ+vVtJutJ
         ocu7WYAHxW+9letk5IuqILyJfJ0omA9TYCGqGI3ZW12BP0J1uMrdUw4g3mf6Dnq9iC2d
         KIoG/xTswyWySLrhFnRZ2Qa4cNrCubzn949cy5pGWP6ba+vFmgIdE/fnF+KPaKPeGBQd
         k/Zw==
Content-Language: en-US
In-Reply-To: <f82d4961986547b28b6de066219ad08b@huawei.com>
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Roberto Sassu <roberto.sassu@huawei.com>, Jim Baxter <jim_baxter@mentor.com>, Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: "hpa@zytor.com" <hpa@zytor.com>, Masahiro Yamada <masahiroy@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Mimi Zohar <zohar@linux.ibm.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "initramfs@vger.kernel.org" <initramfs@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bug-cpio@gnu.org" <bug-cpio@gnu.org>, "zohar@linux.vnet.ibm.com" <zohar@linux.vnet.ibm.com>, Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@huawei.co>

On 7/18/22 11:49, Roberto Sassu wrote:
> Uhm, I guess this could be solved with:
> 
> https://github.com/openeuler-mirror/kernel/commit/18a502f7e3b1de7b9ba0c70896ce08ee13d052da
> 
> and adding initramtmpfs to the kernel command line.

It's initmpfs. You can argue about whether it should have two t's (I was
consistent naming it in the patch series adding it), but ramfs and tmpfs are two
different things and saying "initramtmpfs" is like saying "mount -t ext4btrfs".

> You are probably using ramfs, which does not have xattr support.

Do not specify root= in your kernel command line. If you specify root= you're
saying "switch off of initramfs to a different root filesystem", so it doesn't
make the overmounted filesystem tmpfs because you told it you wouldn't be using it.

(The decision of what to mount has to be made before it examines the cpio.gz
contents, so root= is used to signal "we are not keeping this initramfs" because
that's literally what root= means. Your root filesystem is not initramfs, it is
instead this thing to be mounted over initramfs.)

You can tell which you're using via /proc/mounts having a line:

rootfs / rootfs rw,size=121832k,nr_inodes=30458 0 0

If it's got the size= then it's tmpfs: ramfs basically doesn't have bounds
checking and "cat /dev/null > filename" on ramfs will lock your system solid due
to unpinnable memory exhaustion.

If you don't have a "rootfs" line at ALL then root= was used to overmount and
part of the gratuitously magic behavior of root= is it hides the rootfs line
from /proc/mounts even though the filesystem is actually still there, which is
not something it does for ANY OTHER OVERMOUNT:

  $ mkdir sub
  $ mount -t proc proc sub
  $ mount -t ramfs sub sub
  $ grep sub /proc/mounts
  proc /sub proc rw,relatime 0 0
  sub /sub ramfs rw,relatime 0 0

I've never understood why they added that gratuitous special case to hide how
the system actually works, but it's a land mine you have to be told about after
you've stepped on it in order to understand what's going on. Part of the reason
people think initramfs is so "magic" when PID 1 isn't, we don't HIDE the fact
that PID 1 is always there but we hide the fact initramfs is...

Rob
