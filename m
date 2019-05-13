From: Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
Date: Mon, 13 May 2019 13:51:12 -0400
Message-ID: <20190513175111.GB69717@rani.riverdale.lan>
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
 <20190512194322.GA71658@rani.riverdale.lan>
 <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
 <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
 <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
 <20190513172007.GA69717@rani.riverdale.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=B5lit/bpHedf80sYMuDGoqL+WRq05MQP3LUFocwmKj8=;
        b=CRwAAJf3B+Jo51AmiQSTmmu3WgVp0umKtiWWhm4Zdu3fy2wFPHoSVZUGsizrpVaAIh
         s/+98ifo0DoxHThLPk4bOL9ovM7HpqFUhXaFVzfx/QrCKsXrak8E09gN8+CE5uL8Dp9k
         6B8fNz6u1rTw49VozW7Pb2GnBGpepAfJ32vmQ2Sbhq0CITX4WkpJAhCNLGDMK94eFpiK
         jc/0fazbh4Xbfpo6zIoAJOGCSp1dgvFV20j8JtWbwHci4zmYQEH4mEETSqWdr9YCEOhg
         otmS0DBS/EIxlza6hVC4g6yB8IL9YHawZiD8QWOtutuZsomFueyeNDV/HH7D5luHtEmM
         /4yQ==
Content-Disposition: inline
In-Reply-To: <20190513172007.GA69717@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Arvind Sankar <niveditas98@gmail.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, initramfs@vger.kernel.org

On Mon, May 13, 2019 at 01:20:08PM -0400, Arvind Sankar wrote:
> On Mon, May 13, 2019 at 02:47:04PM +0200, Roberto Sassu wrote:
> > On 5/13/2019 11:07 AM, Rob Landley wrote:
> > >=20
> > >=20
> > > On 5/13/19 2:49 AM, Roberto Sassu wrote:
> > >> On 5/12/2019 9:43 PM, Arvind Sankar wrote:
> > >>> On Sun, May 12, 2019 at 05:05:48PM +0000, Rob Landley wrote:
> > >>>> On 5/12/19 7:52 AM, Mimi Zohar wrote:
> > >>>>> On Sun, 2019-05-12 at 11:17 +0200, Dominik Brodowski wrote:
> > >>>>>> On Thu, May 09, 2019 at 01:24:17PM +0200, Roberto Sassu wrote:
> > >>>>>>> This proposal consists in marshaling pathnames and xattrs in a =
file called
> > >>>>>>> .xattr-list. They are unmarshaled by the CPIO parser after all =
files have
> > >>>>>>> been extracted.
> > >>>>>>
> > >>>>>> Couldn't this parsing of the .xattr-list file and the setting of=
 the xattrs
> > >>>>>> be done equivalently by the initramfs' /init? Why is kernel invo=
lvement
> > >>>>>> actually required here?
> > >>>>>
> > >>>>> It's too late.=C2=A0 The /init itself should be signed and verifi=
ed.
> > >>>>
> > >>>> If the initramfs cpio.gz image was signed and verified by the extr=
actor, how is
> > >>>> the init in it _not_ verified?
> > >>>>
> > >>>> Ro
> > >>>
> > >>> Wouldn't the below work even before enforcing signatures on external
> > >>> initramfs:
> > >>> 1. Create an embedded initramfs with an /init that does the xattr
> > >>> parsing/setting. This will be verified as part of the kernel image
> > >>> signature, so no new code required.
> > >>> 2. Add a config option/boot parameter to panic the kernel if an ext=
ernal
> > >>> initramfs attempts to overwrite anything in the embedded initramfs.=
 This
> > >>> prevents overwriting the embedded /init even if the external initra=
mfs
> > >>> is unverified.
> > >>
> > >> Unfortunately, it wouldn't work. IMA is already initialized and it w=
ould
> > >> verify /init in the embedded initial ram disk.
> How does this work today then? Is it actually the case that initramfs
> just cannot be used on an IMA-enabled system, or it can but it leaves
> the initramfs unverified and we're trying to fix that? I had assumed the
> latter.
Oooh, it's done not by starting IMA later, but by loading a default
policy that ignores the initramfs?
> > >=20
> > > So you made broken infrastructure that's causing you problems. Sounds=
 unfortunate.
> >=20
> > The idea is to be able to verify anything that is accessed, as soon as
> > rootfs is available, without distinction between embedded or external
> > initial ram disk.
> >=20
> > Also, requiring an embedded initramfs for xattrs would be an issue for
> > systems that use it for other purposes.
> >=20
> The embedded initramfs can do other things, it just has to do
> the xattr stuff in addition, no?
> >=20
> > >> The only reason why
> > >> opening .xattr-list works is that IMA is not yet initialized
> > >> (late_initcall vs rootfs_initcall).
> > >=20
> > > Launching init before enabling ima is bad because... you didn't think=
 of it?
> >=20
> > No, because /init can potentially compromise the integrity of the
> > system.
> >=20
> How? The /init in the embedded initramfs is part of a trusted kernel
> image that has been verified by the bootloader.
> >=20
> > >> Allowing a kernel with integrity enforcement to parse the CPIO image
> > >> without verifying it first is the weak point.
> > >=20
> > > If you don't verify the CPIO image then in theory it could have anyth=
ing in it,
> > > yes. You seem to believe that signing individual files is more secure=
 than
> > > signing the archive. This is certainly a point of view.
> >=20
> > As I wrote above, signing the CPIO image would be more secure, if this
> > option is available. However, a disadvantage would be that you have to
> > sign the CPIO image every time a file changes.
> >=20
> >=20
> > >> However, extracted files
> > >> are not used, and before they are used they are verified. At the time
> > >> they are verified, they (included /init) must already have a signatu=
re
> > >> or otherwise access would be denied.
> > >=20
> > > You build infrastructure that works a certain way, the rest of the sy=
stem
> > > doesn't fit your assumptions, so you need to change the rest of the s=
ystem to
> > > fit your assumptions.
> >=20
> > Requiring file metadata to make decisions seems reasonable. Also
> > mandatory access controls do that. The objective of this patch set is to
> > have uniform behavior regardless of the filesystem used.
> >=20
> >=20
> > >> This scheme relies on the ability of the kernel to not be corrupted =
in
> > >> the event it parses a malformed CPIO image.
> > >=20
> > > I'm unaware of any buffer overruns or wild pointer traversals in the =
cpio
> > > extraction code. You can fill up all physical memory with initramfs a=
nd lock the
> > > system hard, though.
> > >=20
> > > It still only parses them at boot time before launching PID 1, right?=
 So you
> > > have a local physical exploit and you're trying to prevent people fro=
m working
> > > around your Xbox copy protection without a mod chip?
> >=20
> > What do you mean exactly?
> >=20
> >=20
> > >> Mimi suggested to use
> > >> digital signatures to prevent this issue, but it cannot be used in a=
ll
> > >> scenarios, since conventional systems generate the initial ram disk
> > >> locally.
> > >=20
> > > So you use a proprietary init binary you can't rebuild from source, a=
nd put it
> > > in a cpio where /dev/urandom is a file with known contents? Clearly, =
not
> > > exploitable at all. (And we update the initramfs.cpio but not the ker=
nel because
> > > clearly keeping the kernel up to date is less important to security..=
.)
> >=20
> > By signing the CPIO image, the kernel wouldn't even attempt to parse it,
> > as the image would be rejected by the boot loader if the signature is
> > invalid.
> >=20
> If it were signed yes, but you just said that it isn't possible to sign
> it in all cases (if initramfs is generated locally). I actually didn't
> follow that bit -- if initramfs is generated locally, and it isn't
> possible to sign locally, where would the IMA hashes for the contents of
> the initramfs come from? Is the idea that each file within the initramfs
> would be an existing, signed, file, but you could locally create an initr=
amfs
> with some subset of those unmodified files? Even assuming this is the
> case, isn't the eventual intention to also appraise directories, to
> prevent holes where files might be moved around/deleted/renamed etc, so
> this problem would resurface anyway?
> Also eventually we need to check special nodes like device nodes etc to
> make sure they haven't been tampered with, as in Rob's urandom
> suggestion?
> >=20
> > > Whatever happened to https://lwn.net/Articles/532778/ ? Modules are s=
igned
> > > in-band in the file, but you need xattrs for some reason?
> >=20
> > Appending just the signature would be possible. It won't work if you
> > have multiple metadata for the same file.
> >=20
> > Also appending the signature alone won't solve the parsing issue. Still,
> > the kernel has to parse something that could be malformed.
> >=20
> > Roberto
> >=20
> >=20
> > >> Roberto
> > >=20
> > > Rob
> > >=20
> >=20
> > --=20
> > HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
> > Managing Director: Bo PENG, Jian LI, Yanli SHI
