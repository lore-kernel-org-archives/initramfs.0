From: Arvind Sankar <nivedita-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>
Subject: Re: [RFC PATCH] rootfs: force mounting rootfs as tmpfs
Date: Wed, 31 Jan 2018 21:03:32 -0500
Message-ID: <20180201020331.GA3774@rani.riverdale>
References: <1517348777.3469.5.camel@linux.vnet.ibm.com>
 <1814af5c-170d-39c0-58fd-02eb7216e008@landley.net>
 <1517436423.3469.237.camel@linux.vnet.ibm.com>
 <a538e55c-81ca-6d59-20cf-21b47387c3e2@landley.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a538e55c-81ca-6d59-20cf-21b47387c3e2-VoJi6FS/r0vR7s880joybQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>
Cc: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Taras Kondratiuk <takondra-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, Victor Kamensky <kamensky-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, linux-security-module <linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-3bDd1+5oDREiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, Jan 31, 2018 at 05:48:20PM -0600, Rob Landley wrote:
> On 01/31/2018 04:07 PM, Mimi Zohar wrote:
> > On Wed, 2018-01-31 at 13:32 -0600, Rob Landley wrote:>> (The old "I con=
figured in tmpfs and am using rootfs but I want that
> rootfs
> >> to be ramfs, not tmpfs" code doesn't seem to be a real-world concern, =
does
> >> it?)
> >=20
> > I must be missing something. =C2=A0Which systems don't specify "root=3D=
" on
> > the boot command line.
>=20
> Any system using initrd or initramfs?
>=20

Don't a lot of initramfs setups use root=3D to tell the initramfs which
actual root file system to switch to after early boot?
