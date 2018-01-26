From: Taras Kondratiuk <takondra@cisco.com>
Subject: Re: [PATCH v2 01/15] Documentation: add newcx initramfs format description
Date: Fri, 26 Jan 2018 13:02:52 -0800
Message-ID: <151700057225.21956.4502484965110175077@takondra-t460s>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
 <1516850875-25066-2-git-send-email-takondra@cisco.com>
 <da9b623c-dd0c-9aff-8eaa-43afa4714b34@landley.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1263; q=dns/txt; s=iport;
  t=1517000578; x=1518210178;
  h=mime-version:content-transfer-encoding:to:from:
   in-reply-to:cc:references:message-id:subject:date;
  bh=5MaXy0cM5Z+btdzDubm4TMsHYZXiagofTuKPz8EQ2LU=;
  b=jZwLGG04HgQNZAT6mxIdiI77/bLeW0fJX/lXrK8oGUOW+lRcub18+jXX
   FnmM8eTvZl20Nx0R6Lpi6hRxgRSLx8In1w+KzW5Jg9vEdJStqNYZy8ZP9
   38yBDX3Myuf8LYcpRMA8lfMUaELWwpeKD3Gc7MSQchrkYmLIEVSMXv6vR
   I=;
In-Reply-To: <da9b623c-dd0c-9aff-8eaa-43afa4714b34@landley.net>
Sender: owner-linux-security-module@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, James McMechan <james.w.mcmechan@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Rob Landley <rob@landley.net>
Cc: initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, xe-linux-external@cisco.com

Quoting Rob Landley (2018-01-25 18:40:54)
> On 01/24/2018 09:27 PM, Taras Kondratiuk wrote:
> > diff --git a/Documentation/early-userspace/buffer-format.txt b/Document=
ation/early-userspace/buffer-format.txt
> > index e1fd7f9dad16..d818df4f72dc 100644
> > --- a/Documentation/early-userspace/buffer-format.txt
> > +++ b/Documentation/early-userspace/buffer-format.txt
> =

> > +compressed and/or uncompressed cpio archives; arbitrary amounts
> > +zero bytes (for padding) can be added between members.
> =

> Missing "of" between amounts and zero. (Yeah it was in the original, but
> if you're touching it anyway...)
> =

> > +c_xattrs_size  8 bytes                Size of xattrs field
> > +
> > +Most of the fields match cpio_newc_header except c_mtime that contains
> > +microseconds. c_chksum field is dropped.
> > +
> > +xattr_size is a total size of xattr_entry including 8 bytes of
> > +xattr_size. xattr_size has the same hexadecimal ASCII encoding as other
> > +fields of cpio header.
> =

> xattrs_size or xattr_size?
> =

> Total nitpicks, I know. :)

xattr_size here refers to size of each xattr_entry:
xattr_entry :=3D xattr_size[8] + xattr_name + "\0" + xattr_value

I'll move this paragraph closer to that line.
