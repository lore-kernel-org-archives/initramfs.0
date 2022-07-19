From: Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v4 0/3] initramfs: add support for xattrs in the initial
 ram disk
Date: Tue, 19 Jul 2022 06:33:42 -0500
Message-ID: <14f9274e-87bd-9202-59c0-7f2ca836144d@landley.net>
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
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=020GL0O0hflXIxVwmtfRiD+2r8usxk+LpcYhr4gv+S8=;
        b=jTC6FmREwwRm6mWYH7G34+k++tluRwbkr8cS0HSWRGwVLzTj+m4tF48rD3YjRQr3+L
         gtQ7k1PWASf2VskYTcp9cMIrGDV/Rn1Br+cFrmDn6WpQaxOYKGirm6oDYmQ1HbrGEUXG
         W+ZW/je304Bx1ohhsGP0TgQquEH5m5vDnA6Q/FaHnWvLpp8YcHPK7aD2W37sBKT40JV2
         0kMXTdElzVdfKGd/ut+q/eDzqjq+mPt01qdKu+m/j2RHRzjdB/lcwvw2kG+JYZLLpi9Y
         whdPBeRqdkgP6b4vauNBo1eCvEpSy036spvRs6EPK+66TAg1gjDmfNO9viCGyQAofFJg
         x1uA==
Content-Language: en-US
In-Reply-To: <737ddf72-05f4-a47e-c901-fec5b1dfa7a6-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jim Baxter <jim_baxter-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Roberto Sassu <roberto.sassu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Eugeniu Rosca <erosca-Tbglbhd2jqSoSS7kgVBzIA@public.gmane.org>
Cc: "hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Masahiro Yamada <masahiroy-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arvind Sankar <nivedita-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>, Mimi Zohar <zohar-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, "viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org" <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, "linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-integrity-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-integrity-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "bug-cpio-mXXj517/zsQ@public.gmane.org" <bug-cpio-mXXj517/zsQ@public.gmane.org>, "zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Silviu Vlasceanu <Silviu.Vlasceanu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Dmitry Kasatkin <dmitry.kasatkin-hv44wF8Li91hl2p70BpVqQ@public.gmane.org>



On 7/18/22 13:08, Jim Baxter wrote:
> 
> 
> Best regards,
> 
> *Jim Baxter*
> 
> Siemens Digital Industries Software
> Automotive Business Unit
> DI SW STS ABU
> UK
> Tel.: +44 (161) 926-1656
> mailto:jim.baxter-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org <mailto:jim.baxter-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
> sw.siemens.com <https://sw.siemens.com/>
> 
> On 18/07/2022 17:49, Roberto Sassu wrote:
>>> From: Jim Baxter [mailto:jim_baxter-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org]
>>> Sent: Monday, July 18, 2022 6:36 PM
>>>
>>>
>>> Hello,
>>>
>>> I have been testing these patches and do not see the xattr information when
>>> trying to retrieve it within the initramfs, do you have an example of how
>>> you tested this originally?
>> 
>> Hi Jim, all
>> 
>> apologies, I didn't find yet the time to look at this.
> 
> Hello Roberto,
> 
> Thank you for your response, I can wait until you have looked at the patches,
> I asked the question to make sure it was not something wrong in my
> configuration.
> 
>> 
>> Uhm, I guess this could be solved with:
>> 
>> https://github.com/openeuler-mirror/kernel/commit/18a502f7e3b1de7b9ba0c70896ce08ee13d052da
>> 
>> and adding initramtmpfs to the kernel command line. You are
>> probably using ramfs, which does not have xattr support.
>> 
> 
> 
> Thank you, I have tested that patch but the problem remained. Here is my
> command line, I wonder if there is something wrong.
> 
> Kernel command line: rw rootfstype=initramtmpfs root=/dev/ram0 initrd=0x500000000 rootwait 

/dev/ram0 is a block device. Trying to provide it to tmpfs is like trying to say:

  mount -t proc /dev/sda1 /proc

There's nowhere for the block device to GO because it's not a block backed
filesystem.

There's four types of filesystem: block back, pipe backed, ram backed, and
synthetic.

- Only block backed filesystems take a block device argument. Block backed
filesystems require two drivers: one to handle I/O to the block device and one
to interpret the filesystem format with the block device. You do not "format"
any other kind of filesystem. (There's no mkfs.nfs or mkfs.proc: it doesn't work
that way.)

- Pipe backed ones include network filesystems (nfs, samba), FUSE filesystems,
or hybrid weirdness like https://wiki.qemu.org/Documentation/9psetup . These
drivers talk a protocol over a pipe (or network socket, or char device, or...)
to a server at the far end that serves up the filesystem contents. Usually their
source argument is a server address plus filesystem identification plus login
credentials. Often they have a wrapper program that assembles this argument for you.

- Ram backed filesystems (ramfs, tmpfs) treat the "source" argument to mount(2)
as basically a comment, and ignore it. When you're adding things like size
limitations, it goes in the "data" argument (I.E. mount -o thingy).

- synthetic filesystems are just interfaces to the kernel that make up their
contents programmatically (proc, sys, cgroup...) and no two are alike, although
they generally ignore their "source" argument and look at "data" too.

I wrote up documention about this many years ago...

  https://landley.net/toybox/doc/mount.html

> I also found that root is always mounted as rootfs in my initramfs system
> which I understood to be tmpfs, is that incorrect?

Yes, although the kernel tries to hide this by lying in /proc/mounts for bad
reasons.
> I modified the file before packing. To pack I use the following commands:
> 
> $ ./usr/gen_initramfs.sh -l initramfs.list -e xattr ../rootfs > initramfs.cpio
> $ gzip initramfs.cpio
> $ mkimage -A arm64 -O linux -T ramdisk -d initramfs.cpio.gz uRamdisk
> 
> The kernel is loaded using:
> booti ${kernaddr} ${initramaddr} ${dtbaddr}

Remove the root= argument from your kernel command line. It is explicitly
telling the kernel "we will not be staying in rootfs" and thus it doesn't use
tmpfs for it. In your case, you're saying "we're going to overmount the initial
ramfs with a ram disk block device", which is nonsensical because nothing can
have populated it so it will be all zeroes (unformatted) and thus the filesystem
type detection staircase in
https://github.com/torvalds/linux/blob/v5.18/init/do_mounts_rd.c#L38 won't be
able to find a filesystem type to mount on it and it's guaranteed to fail.

Note: initramfs was introduced in the early 2000s, and back in the 1990s there
was an older "initrd" mechanism that DID use ramdisks (which are a chunk of ram
used as a block device). I wrote documention about THAT too:

  https://www.kernel.org/doc/Documentation/filesystems/ramfs-rootfs-initramfs.txt

Basically the mechanism you're feeding init.cpio.gz in through was originally
written to populate a ramdisk, and you'd make an ext2 image or something and
gzip that. These days, the kernel decompresses the first few bytes of the file
and if the result is a cpio signature it calls the initramfs plumbing
(extracting the archive into the ram backed filesystem) and if not it extracts
it into the /dev/ram0 block device and treats it as an initial ram disk. In
NEITHER case do you need root= because that's used AFTER initramfs and initrd
have both failed to find an /init program. (Well initrd looks for /linuxrc
instead of /init because historical cruft, and then there was pivot_root...
Don't go there.)

Rob
