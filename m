From: Taras Kondratiuk <takondra@cisco.com>
Subject: Re: [PATCH v2 11/15] gen_init_cpio: add newcx format
Date: Fri, 26 Jan 2018 12:37:14 -0800
Message-ID: <151699903485.21956.15795523878472133751@takondra-t460s>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
 <1516850875-25066-12-git-send-email-takondra@cisco.com>
 <b3451193-0666-d929-01f3-29d3872bd5d4@landley.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-doc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=894; q=dns/txt; s=iport;
  t=1516999040; x=1518208640;
  h=mime-version:content-transfer-encoding:to:from:
   in-reply-to:cc:references:message-id:subject:date;
  bh=f9aXahrgJ6W4s5lYFKzolVmaLj/rcUPEJlNVEhT2XTY=;
  b=YSbariS8KmOkOtib9vdVobbBEYAODDSg+N6OIgLL4TKux5OJaq568YbN
   EzTW5pdeWd+ZyTGuLBXPe+7dP8y4Ot7/N8Dlzicz+hiLW2Jylk8rES3MJ
   pAQTFD5YRiGVloHKT0R4EFqLet7e//KDzCXUg5+HqO66yEfNU0aSwI5A6
   Y=;
In-Reply-To: <b3451193-0666-d929-01f3-29d3872bd5d4@landley.net>
Sender: linux-doc-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, James McMechan <james.w.mcmechan@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Rob Landley <rob@landley.net>
Cc: initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, xe-linux-external@cisco.com

Quoting Rob Landley (2018-01-25 18:40:25)
> On 01/24/2018 09:27 PM, Taras Kondratiuk wrote:
> > diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
> > index 7a2a6d85345d..78a47a5bdcb1 100644
> > --- a/usr/gen_init_cpio.c
> > +++ b/usr/gen_init_cpio.c
> > @@ -10,6 +10,7 @@
> >  #include <errno.h>
> >  #include <ctype.h>
> >  #include <limits.h>
> > +#include <assert.h>
> =

> You're adding an assert? Really?
> =

> >       fputs(s, stdout);
> > -     offset +=3D 110;
> > +     assert((offset & 3) =3D=3D 0);
> > +     offset +=3D cpio_hdr_size;
> =

> Why?

Current code assumes that previous file entry in cpio is padded to 4
byte boundary. The assert just captures this assumption. It should be
true unless there is a bug in the code and some padding is missing.

Actually this assert should be a part of the next patch (#12) that
modifies padding code.
