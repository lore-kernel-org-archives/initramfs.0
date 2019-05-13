From: Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
Date: Mon, 13 May 2019 14:47:45 -0400
Message-ID: <20190513184744.GA12386@rani.riverdale.lan>
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
 <20190512194322.GA71658@rani.riverdale.lan>
 <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
 <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
 <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
 <20190513172007.GA69717@rani.riverdale.lan>
 <20190513175250.GC69717@rani.riverdale.lan>
 <1557772584.4969.62.camel@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fcj7AotgrHgaGk9eGLmWk2zeSnn906Cpfa2iryM3DoI=;
        b=SQuY2s+gOhhvRTsfAUBFH8LblnHzjFKVtQhD/ihRPsOB1DqyVzD7Xi9YbAmZb4Pvhp
         kKP0V+5w7UIAUrpkSD9JLaZbwAXLCTHvW7eaQ/mEMTNGQB40/4n8tgbWfXZ/4G2zW6Ds
         7E2h7E2DbLtKiFnN7K8LldVs7Hr00QujeCB/kKbDgjKuBjhTwnW+JBdrQm7JYY24v8RT
         Tw7OIi/fi6263Hsrvk66MGEe7JsiyomynLBElEePKLWgjiQrw0eMU/E+u06hTFjxo6sb
         Fqs08/Wd3j+ANlJUFbuqQHK0gbt7dVAKrvbS1KTWyBLhqFsLmeK7omiu8V5RLxEgjWe3
         6WVw==
Content-Disposition: inline
In-Reply-To: <1557772584.4969.62.camel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Arvind Sankar <niveditas98@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>, Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, initramfs@vger.kernel.org

On Mon, May 13, 2019 at 02:36:24PM -0400, Mimi Zohar wrote:
>=20
> > > How does this work today then? Is it actually the case that initramfs
> > > just cannot be used on an IMA-enabled system, or it can but it leaves
> > > the initramfs unverified and we're trying to fix that? I had assumed =
the
> > > latter.
> > Oooh, it's done not by starting IMA appraisal later, but by loading a
> > default policy to ignore initramfs?
>=20
> Right, when rootfs is a tmpfs filesystem, it supports xattrs, allowing
> for finer grained policies to be defined. =C2=A0This patch set would allow
> a builtin IMA appraise policy to be defined which includes tmpfs.
>=20
> Mimi
>=20
Ok, but wouldn't my idea still work? Leave the default compiled-in
policy set to not appraise initramfs. The embedded /init sets all the
xattrs, changes the policy to appraise tmpfs, and then exec's the real
init? Then everything except the embedded /init and the file with the
xattrs will be appraised, and the embedded /init was verified as part of
the kernel image signature. The only additional kernel change needed
then is to add a config option to the kernel to disallow overwriting the
embedded initramfs (or at least the embedded /init).
