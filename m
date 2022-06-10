From: Roberto Sassu <roberto.sassu@huawei.com>
Subject: RE: [PATCH v4 0/3] initramfs: add support for xattrs in the initial
 ram disk
Date: Fri, 10 Jun 2022 15:38:24 +0000
Message-ID: <4bc349a59e4042f7831b1190914851fe@huawei.com>
References: <cf9d08ca-74c7-c945-5bf9-7c3495907d1e@huawei.com>
 <541e9ea1-024f-5c22-0b58-f8692e6c1eb1@landley.net>
 <33cfb804-6a17-39f0-92b7-01d54e9c452d@huawei.com>
 <1561909199.3985.33.camel@linux.ibm.com>
 <45164486-782f-a442-e442-6f56f9299c66@huawei.com>
 <1561991485.4067.14.camel@linux.ibm.com>
 <f85ed711-f583-51cd-34e2-80018a592280@huawei.com>
 <0c17bf9e-9b0b-b067-cf18-24516315b682@huawei.com>
 <20220609102627.GA3922@lxhi-065>
 <21b3aeab20554a30b9796b82cc58e55b@huawei.com>
 <20220610153336.GA8881@lxhi-065>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20220610153336.GA8881@lxhi-065>
Content-Language: en-US
List-ID: <initramfs.vger.kernel.org>
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Rob Landley <rob@landley.net>, "hpa@zytor.com" <hpa@zytor.com>, Masahiro Yamada <masahiroy@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Mimi Zohar <zohar@linux.ibm.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "initramfs@vger.kernel.org" <initramfs@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bug-cpio@gnu.org" <bug-cpio@gnu.org>, "zohar@linux.vnet.ibm.com" <zohar@linux.vnet.ibm.com>, Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>, Dmitry

> From: Eugeniu Rosca [mailto:erosca@de.adit-jv.com]
> Sent: Friday, June 10, 2022 5:34 PM
> Hello Roberto,
> 
> On Do, Jun 09, 2022 at 11:05:45 +0000, Roberto Sassu wrote:
> > > From: Eugeniu Rosca [mailto:erosca@de.adit-jv.com]
> > > Sent: Thursday, June 9, 2022 12:26 PM
> > > Dear Roberto,
> > > Cc: Yamada-san, linux-kbuild
> > >
> > > On Mi, Jul 24, 2019 at 05:34:53 +0200, Roberto Sassu wrote:
> > > > Is there anything I didn't address in this patch set, that is delaying
> > > > the review? I would appreciate if you can give me a feedback, positive
> > > > or negative.
> > > >
> > > > Thanks a lot!
> > > >
> > > > Roberto
> > >
> > > Some of our users have recently asked for this patch series.
> >
> > Hello
> >
> > thanks for your interest in this patch set.
> >
> > > Could you please feedback if this is the latest revision available or
> > > maybe there is a newer one developed and potentially not shared on LKML?
> >
> > Yes, it is the latest revision available. There might have been few
> > fixes in the final code. You may want to have a look at:
> 
> Many thanks for the links to the updated patch revisions. It looks
> like the new versions added a couple of bugfixes and refinements.
> 
> With more users now using this feature, do you think there is a higher
> chance for upstreaming, compared to 2019 (original submission date)?

Hello Eugeniu

I would be happy to address the remaining concerns, or take more
suggestions, and then develop a new version of the patch set.

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Yang Xi, Li He
