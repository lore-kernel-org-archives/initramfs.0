From: Jim Baxter <jim_baxter@mentor.com>
Subject: Re: [PATCH v4 0/3] initramfs: add support for xattrs in the initial
 ram disk
Date: Mon, 18 Jul 2022 17:36:06 +0100
Message-ID: <032ade35-6eb8-d698-ac44-aa45d46752dd@mentor.com>
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
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Language: en-GB
In-Reply-To: <20220615092712.GA4068@lxhi-065>
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Eugeniu Rosca <erosca@de.adit-jv.com>, Roberto Sassu <roberto.sassu@huawei.com>
Cc: Rob Landley <rob@landley.net>, "hpa@zytor.com" <hpa@zytor.com>, Masahiro Yamada <masahiroy@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Mimi Zohar <zohar@linux.ibm.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "initramfs@vger.kernel.org" <initramfs@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bug-cpio@gnu.org" <bug-cpio@gnu.org>, "zohar@linux.vnet.ibm.com" <zohar@linux.vnet.ibm.com>, Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>, Dmitry

On 15/06/2022 10:27, Eugeniu Rosca wrote:
> Hello Roberto,
> 
> On Fr, Jun 10, 2022 at 03:38:24 +0000, Roberto Sassu wrote:
>> I would be happy to address the remaining concerns, or take more
>> suggestions, and then develop a new version of the patch set.
> I face a number of conflicts when I try to rebase the latest openEuler
> commits against vanilla master (v5.19-rc2). Do you think it is possible
> to submit the rebased version to ML?
> 
> In addition, I can also see some open/unresolved points from Mimi [*].
> Did you by chance find some mutual agreement offline or do you think
> they would still potentially need some attention?
> 
> Maybe we can resume the discussion once you submit the rebased series?
> 
> Many thanks and looking forward to it.
> 
> [*] Potentially comments which deserve a reply/clarification/resolution
> 
> https://lore.kernel.org/lkml/1561985652.4049.24.camel@linux.ibm.com/#t
> https://lore.kernel.org/lkml/1561908456.3985.23.camel@linux.ibm.com/
> 
> BR, Eugeniu.
> 


Hello,

I have been testing these patches and do not see the xattr information when
trying to retrieve it within the initramfs, do you have an example of how
you tested this originally?


So far I have set the xattr in the rootfs before creating the cpio file like this:
$ setfattr -n user.comment -v "this is a comment" test.txt
If I access the data here it works:
$ getfattr test.txt 
# file: test.txt
user.comment


Then I package it and try to verify it with this command:
$getfattr /test.txt

Which returns to the command line without the data.



I believe the cpio is working because I see the file /METADATA\!\!\! in
the target root filesystem, which shows the following when viewed with cat -e:
00000028^A^Auser.comment^@this is a comment

This matches the data I fed in at the start, so I believe the data is being
transferred correctly but I am accessioning it with the wrong tools.

Thank you for any help.

Best regards,
Jim
