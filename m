From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] rootfs: force mounting rootfs as tmpfs
Date: Wed, 31 Jan 2018 23:22:01 -0500
Message-ID: <1517458921.3329.2.camel@linux.vnet.ibm.com>
References: <1517348777.3469.5.camel@linux.vnet.ibm.com>
         <1814af5c-170d-39c0-58fd-02eb7216e008@landley.net>
         <1517436423.3469.237.camel@linux.vnet.ibm.com>
         <a538e55c-81ca-6d59-20cf-21b47387c3e2@landley.net>
         <20180201020331.GA3774@rani.riverdale>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180201020331.GA3774@rani.riverdale>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Arvind Sankar <nivedita@alum.mit.edu>, Rob Landley <rob@landley.net>
Cc: initramfs <initramfs@vger.kernel.org>, Taras Kondratiuk <takondra@cisco.com>, Victor Kamensky <kamensky@cisco.com>, linux-security-module <linux-security-module@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel <linux-kernel@vger.kernel.org>

On Wed, 2018-01-31 at 21:03 -0500, Arvind Sankar wrote:
> On Wed, Jan 31, 2018 at 05:48:20PM -0600, Rob Landley wrote:
> > On 01/31/2018 04:07 PM, Mimi Zohar wrote:
> > > On Wed, 2018-01-31 at 13:32 -0600, Rob Landley wrote:>> (The old "I c=
onfigured in tmpfs and am using rootfs but I want that
> > rootfs
> > >> to be ramfs, not tmpfs" code doesn't seem to be a real-world concern=
, does
> > >> it?)
> > >=20
> > > I must be missing something. =C2=A0Which systems don't specify "root=
=3D" on
> > > the boot command line.
> >=20
> > Any system using initrd or initramfs?
> >=20
>=20
> Don't a lot of initramfs setups use root=3D to tell the initramfs which
> actual root file system to switch to after early boot?

With your patch and specifying "root=3Dtmpfs", dracut is complaining:

dracut: FATAL: Don't know how to handle 'root=3Dtmpfs'
dracut: refusing to continue

Mimi

