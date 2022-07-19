From: Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v4 0/3] initramfs: add support for xattrs in the initial
 ram disk
Date: Tue, 19 Jul 2022 06:50:48 -0500
Message-ID: <dc86769f-0ac6-d9f3-c003-54d3793ccfec@landley.net>
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
 <737ddf72-05f4-a47e-c901-fec5b1dfa7a6@mentor.com>
 <8e6a723874644449be99fcebb0905058@huawei.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Va7Ue4HqT06P0u8ZRW43Z0Px0BXsVi2YgJ23VtJAGE4=;
        b=gmFEGz70M+E8Ceybb/tf91iagosJh4629EfUTFd5g6M7IY/U61Sb1imjd3ZPEpnUcH
         tFZ+VtRXyXJ7QQX6xctuIbayj1Lc/steGSVVSvV1TAQ4OCUC12MSz4qN2+j4eg14M67V
         EtP5cWAAtRhDGBrvIY7TwdwxJTwxjbbQm3DltE5mC5Q1kYv579w4cxu4DN2WTmSPaLn6
         jypi4VkBvW2XIIMDp1WDe1+wEYoxHGfqJRzFeoiyBDT/ABKOfLkFnK0jDxOfD3MUAZcO
         cD8SEDcHGKzsXc1kuCvNGFVTtnjw5FR0nq0aPjBK0FT4VDYg0kANyA0HOQjvQLxMIWFW
         17CA==
Content-Language: en-US
In-Reply-To: <8e6a723874644449be99fcebb0905058-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Roberto Sassu <roberto.sassu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Jim Baxter <jim_baxter-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Eugeniu Rosca <erosca-Tbglbhd2jqSoSS7kgVBzIA@public.gmane.org>
Cc: "hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Masahiro Yamada <masahiroy-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arvind Sankar <nivedita-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>, Mimi Zohar <zohar-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, "viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org" <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, "linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-integrity-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-integrity-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "bug-cpio-mXXj517/zsQ@public.gmane.org" <bug-cpio-mXXj517/zsQ@public.gmane.org>, "zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Silviu Vlasceanu <Silviu.Vlasceanu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Dmitry Kasatkin <dmitry.kasatkin-hv44wF8Li91hl2p70BpVqQ@public.gmane.org>

On 7/19/22 01:55, Roberto Sassu wrote:
>> Thank you, I have tested that patch but the problem remained. Here is my
>> command line, I wonder if there is something wrong.
>> 
>> Kernel command line: rw rootfstype=initramtmpfs root=/dev/ram0
>> initrd=0x500000000 rootwait
> 
> It is just initramtmpfs, without rootfstype=.

Whoever wrote that patch really doesn't understand how this stuff works. I can
tell from the name.

Technically, initramfs is the loader, I.E. "init ramfs". The filesystem instance
is called "rootfs" (hence the name in /proc/mounts when the insane special case
the kernel added doesn't hide information from people, making all this harder to
understand for no obvious reason).

ramfs and tmpfs are two different filesystems that COULD be used to implement
rootfs. (Last I checked they were the only ram backed filesystems in Linux.)

If a system administrator says they're going to install your server's root
partition using the "reiserxfs" filesystem, I would not be reassured.

> Roberto

Rob

P.S. Note: there IS another boot option, you can have a pipe backed root
filesystem! CONFIG_ROOT_NFS for NFS or CONFIG_CIFS_ROOT for Samba. No, I don't
know why the order isn't consistent.

P.P.S. If you want to run a command other than /init out of initramfs or initrd,
use the rdinit=/run/this option. Note the root= overmount mechanism is
completely different code and uses the init=/run/this argument instead, which
means nothing to initramfs. Again, specifying root= says we are NOT staying in
initramfs.
