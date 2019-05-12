From: Arvind Sankar <niveditas98@gmail.com>
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
Date: Sun, 12 May 2019 15:43:25 -0400
Message-ID: <20190512194322.GA71658@rani.riverdale.lan>
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FjkT8c0mYt5eWOwRncdXrIt5s86GnuaQ8y74QwZDscY=;
        b=fPKk/QKFELPkBCrMzjUg8GR7sOcdZ3YXVrhQo5F48CjmM2qmUgTqM/kqml7HljtQ6u
         WKtahah9PN3uW+IY8Wj35Pzz13qV1pHm2rOK9GeTHxa7P+tKhwkPbBT867K4kiidZMO5
         oPfH+vk/OhFvYDSEGf5osin8Be7nAf9vXLL5T6Nmmwhxy8w39qf5nevbdYprmCeQymMu
         1bGDYzT6DGQ3FSBKgbdvDcnk2MpbSY/63m9yd+eknnFwZ3O0pwxsaTMv0+utJQjb4G2E
         cYx5CQ9XtjVSAuPa/QoVfLrOzRvH+2/oZdLB28w4AMIs0iAGrWeyIy0M+4qeRKQdv2To
         j/Rg==
Content-Disposition: inline
In-Reply-To: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, initramfs@vger.kernel.org

On Sun, May 12, 2019 at 05:05:48PM +0000, Rob Landley wrote:
> On 5/12/19 7:52 AM, Mimi Zohar wrote:
> > On Sun, 2019-05-12 at 11:17 +0200, Dominik Brodowski wrote:
> >> On Thu, May 09, 2019 at 01:24:17PM +0200, Roberto Sassu wrote:
> >>> This proposal consists in marshaling pathnames and xattrs in a file called
> >>> .xattr-list. They are unmarshaled by the CPIO parser after all files have
> >>> been extracted.
> >>
> >> Couldn't this parsing of the .xattr-list file and the setting of the xattrs
> >> be done equivalently by the initramfs' /init? Why is kernel involvement
> >> actually required here?
> > 
> > It's too late.  The /init itself should be signed and verified.
> 
> If the initramfs cpio.gz image was signed and verified by the extractor, how is
> the init in it _not_ verified?
> 
> Ro

Wouldn't the below work even before enforcing signatures on external
initramfs:
1. Create an embedded initramfs with an /init that does the xattr
parsing/setting. This will be verified as part of the kernel image
signature, so no new code required.
2. Add a config option/boot parameter to panic the kernel if an external
initramfs attempts to overwrite anything in the embedded initramfs. This
prevents overwriting the embedded /init even if the external initramfs
is unverified.
