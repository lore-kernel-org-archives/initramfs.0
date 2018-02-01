From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] rootfs: force mounting rootfs as tmpfs
Date: Thu, 01 Feb 2018 10:55:00 -0500
Message-ID: <1517500500.3974.45.camel@linux.vnet.ibm.com>
References: <1517348777.3469.5.camel@linux.vnet.ibm.com>
         <1814af5c-170d-39c0-58fd-02eb7216e008@landley.net>
         <1517436423.3469.237.camel@linux.vnet.ibm.com>
         <a538e55c-81ca-6d59-20cf-21b47387c3e2@landley.net>
         <20180201020331.GA3774@rani.riverdale>
         <1517458921.3329.2.camel@linux.vnet.ibm.com>
         <f9112881-772c-2568-ebfa-d2ca807124e9@landley.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-security-module-owner@vger.kernel.org>
In-Reply-To: <f9112881-772c-2568-ebfa-d2ca807124e9@landley.net>
Sender: owner-linux-security-module@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Rob Landley <rob@landley.net>, Arvind Sankar <nivedita@alum.mit.edu>
Cc: initramfs <initramfs@vger.kernel.org>, Taras Kondratiuk <takondra@cisco.com>, Victor Kamensky <kamensky@cisco.com>, linux-security-module <linux-security-module@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel <linux-kernel@vger.kernel.org>

On Thu, 2018-02-01 at 09:20 -0600, Rob Landley wrote:

> > With your patch and specifying "root=3Dtmpfs", dracut is complaining:
> >=20
> > dracut: FATAL: Don't know how to handle 'root=3Dtmpfs'
> > dracut: refusing to continue
>=20
> [googles]... I do not understand why this package exists.
>=20
> If you're switching to another root filesystem, using a tool that
> wikipedia[citation needed] says has no purpose but to switch to another
> root filesystem, (so let's reproduce the kernel infrastructure in
> userspace while leaving it the kernel too)... why do you need initramfs
> to be tmpfs? You're using it for half a second, then discarding it,
> what's the point of it being tmpfs?

Unlike the kernel image which is signed by the distros, the initramfs
doesn't come signed, because it is built on the target system. =C2=A0Even
if the initramfs did come signed, it is beneficial to measure and
appraise the individual files in the initramfs.

> Sigh. If people are ok with having rootfs just be tmpfs whenever tmpfs
> is configured in, even when you're then going to overmount it with
> something else like you're doing, let's just _remove_ the test. If it
> can be tmpfs, have it be tmpfs.

Very much appreciated!

thanks,

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-mo=
dule" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
