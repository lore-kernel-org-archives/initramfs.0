From: Jim Baxter <jim_baxter@mentor.com>
Subject: Re: [PATCH v4 0/3] initramfs: add support for xattrs in the initial
 ram disk
Date: Mon, 18 Jul 2022 19:08:04 +0100
Message-ID: <737ddf72-05f4-a47e-c901-fec5b1dfa7a6@mentor.com>
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
Content-Language: en-GB
In-Reply-To: <f82d4961986547b28b6de066219ad08b@huawei.com>
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Roberto Sassu <roberto.sassu@huawei.com>, Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Rob Landley <rob@landley.net>, "hpa@zytor.com" <hpa@zytor.com>, Masahiro Yamada <masahiroy@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Mimi Zohar <zohar@linux.ibm.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "initramfs@vger.kernel.org" <initramfs@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bug-cpio@gnu.org" <bug-cpio@gnu.org>, "zohar@linux.vnet.ibm.com" <zohar@linux.vnet.ibm.com>, Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>, Dmitry



Best regards,

*Jim Baxter*

Siemens Digital Industries Software
Automotive Business Unit
DI SW STS ABU
UK
Tel.: +44 (161) 926-1656
mailto:jim.baxter@siemens.com <mailto:jim.baxter@siemens.com>
sw.siemens.com <https://sw.siemens.com/>

On 18/07/2022 17:49, Roberto Sassu wrote:
>> From: Jim Baxter [mailto:jim_baxter@mentor.com]
>> Sent: Monday, July 18, 2022 6:36 PM
>>
>>
>> Hello,
>>
>> I have been testing these patches and do not see the xattr information when
>> trying to retrieve it within the initramfs, do you have an example of how
>> you tested this originally?
> 
> Hi Jim, all
> 
> apologies, I didn't find yet the time to look at this.

Hello Roberto,

Thank you for your response, I can wait until you have looked at the patches,
I asked the question to make sure it was not something wrong in my
configuration.

> 
> Uhm, I guess this could be solved with:
> 
> https://github.com/openeuler-mirror/kernel/commit/18a502f7e3b1de7b9ba0c70896ce08ee13d052da
> 
> and adding initramtmpfs to the kernel command line. You are
> probably using ramfs, which does not have xattr support.
> 


Thank you, I have tested that patch but the problem remained. Here is my
command line, I wonder if there is something wrong.

Kernel command line: rw rootfstype=initramtmpfs root=/dev/ram0 initrd=0x500000000 rootwait 


I also found that root is always mounted as rootfs in my initramfs system
which I understood to be tmpfs, is that incorrect?

sh-3.2# mount
none on / type rootfs (rw)


>> So far I have set the xattr in the rootfs before creating the cpio file like this:
>> $ setfattr -n user.comment -v "this is a comment" test.txt
>> If I access the data here it works:
>> $ getfattr test.txt
>> # file: test.txt
>> user.comment
>>
>>
>> Then I package it and try to verify it with this command:
>> $getfattr /test.txt
> 
> I assume you try to pack/unpack, right? If I remember correctly
> I only implemented the pack part. Unpacking is done by the kernel
> (but you are right, it should be done by user space too).
> 


I modified the file before packing. To pack I use the following commands:

$ ./usr/gen_initramfs.sh -l initramfs.list -e xattr ../rootfs > initramfs.cpio
$ gzip initramfs.cpio
$ mkimage -A arm64 -O linux -T ramdisk -d initramfs.cpio.gz uRamdisk

The kernel is loaded using:
booti ${kernaddr} ${initramaddr} ${dtbaddr}




>> Which returns to the command line without the data.
>>
>>
>>
>> I believe the cpio is working because I see the file /METADATA\!\!\! in
>> the target root filesystem, which shows the following when viewed with cat -e:
>> 00000028^A^Auser.comment^@this is a comment
>>
>> This matches the data I fed in at the start, so I believe the data is being
>> transferred correctly but I am accessioning it with the wrong tools.
> 
> Yes, xattrs are marshalled in the METADATA!!! file, one per regular file
> xattrs are applied to. Xattrs are applied to the previous regular file.
> That file name was preferred to adding a suffix to the file, to avoid
> reaching the filename size limit.
> 
> Roberto

Best regards,
Jim
