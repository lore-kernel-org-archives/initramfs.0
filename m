From: Roberto Sassu <roberto.sassu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH v4 0/3] initramfs: add support for xattrs in the initial
 ram disk
Date: Thu, 9 Jun 2022 11:05:45 +0000
Message-ID: <21b3aeab20554a30b9796b82cc58e55b@huawei.com>
References: <20190523121803.21638-1-roberto.sassu@huawei.com>
 <cf9d08ca-74c7-c945-5bf9-7c3495907d1e@huawei.com>
 <541e9ea1-024f-5c22-0b58-f8692e6c1eb1@landley.net>
 <33cfb804-6a17-39f0-92b7-01d54e9c452d@huawei.com>
 <1561909199.3985.33.camel@linux.ibm.com>
 <45164486-782f-a442-e442-6f56f9299c66@huawei.com>
 <1561991485.4067.14.camel@linux.ibm.com>
 <f85ed711-f583-51cd-34e2-80018a592280@huawei.com>
 <0c17bf9e-9b0b-b067-cf18-24516315b682@huawei.com>
 <20220609102627.GA3922@lxhi-065>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20220609102627.GA3922@lxhi-065>
Content-Language: en-US
List-ID: <initramfs.vger.kernel.org>
To: Eugeniu Rosca <erosca-Tbglbhd2jqSoSS7kgVBzIA@public.gmane.org>
Cc: Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Masahiro Yamada <masahiroy-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arvind Sankar <nivedita-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>, Mimi Zohar <zohar-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, "viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org" <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, "linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-integrity-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-integrity-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "bug-cpio-mXXj517/zsQ@public.gmane.org" <bug-cpio-mXXj517/zsQ@public.gmane.org>, "zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Silviu Vlasceanu <Silviu.Vlasceanu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Dmitry

> From: Eugeniu Rosca [mailto:erosca-Tbglbhd2jqSoSS7kgVBzIA@public.gmane.org]
> Sent: Thursday, June 9, 2022 12:26 PM
> Dear Roberto,
> Cc: Yamada-san, linux-kbuild
> 
> On Mi, Jul 24, 2019 at 05:34:53 +0200, Roberto Sassu wrote:
> > Is there anything I didn't address in this patch set, that is delaying
> > the review? I would appreciate if you can give me a feedback, positive
> > or negative.
> >
> > Thanks a lot!
> >
> > Roberto
> 
> Some of our users have recently asked for this patch series.

Hello

thanks for your interest in this patch set.

> Could you please feedback if this is the latest revision available or
> maybe there is a newer one developed and potentially not shared on LKML?

Yes, it is the latest revision available. There might have been few
fixes in the final code. You may want to have a look at:

https://github.com/openeuler-mirror/kernel/commit/888460f17775b62f77e33e774e6673587c61cabd
https://github.com/openeuler-mirror/kernel/commit/4adaeecd5d23cc75ffd1883d9b677bbd67c535d1
https://github.com/openeuler-mirror/kernel/commit/59db8952e91c2ac443bccdcacfd37ae94c49a259

and:

https://gitee.com/src-openeuler/cpio/blob/master/add-option-to-add-metadata-in-copy-out-mode.patch
https://gitee.com/src-openeuler/cpio/blob/master/Fix-use-after-free-and-return-appropriate-error.patch

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Yang Xi, Li He
