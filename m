From: Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v3 2/2] initramfs: introduce do_readxattrs()
Date: Fri, 17 May 2019 17:02:20 -0400
Message-ID: <20190517210219.GA5998@rani.riverdale.lan>
References: <20190517165519.11507-1-roberto.sassu@huawei.com>
 <20190517165519.11507-3-roberto.sassu@huawei.com>
 <CD9A4F89-7CA5-4329-A06A-F8DEB87905A5@zytor.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zm172sKuEoJHoST/QG9QtXQuShTwFrHdaf7AbMxHV/c=;
        b=NvtUMrEEEmOmOEaikDJJe53KWEzTe30PTlqu92ySPuycej06XQWJu+rFpdk/3OJM34
         Z/nasyQM0942f/xMmRcaxJ0PTSKm40p4bsqdWHJc/dhtrVKkV/XBz4tkFW4/510XTCoV
         K3pS0Kb28WteLZqychrKFcRjSeeZYCuQ2yc8lKGwBSF2ipldMpcAU3mPTWy/z8YfooI5
         JZYYB0RprvKbpK1U/ozZ8Xsf1SgOpBVU4Dx5qfRURfzXdP5ipFf4IFpGjaAEMt8k0vfN
         g1x3FVVHhUH9xIyb9Dk5mF0c6RkhD9/NYojUcLUPiO7Wdgi2UKlxtgN42mEDPoUv9nqM
         9vWA==
Content-Disposition: inline
In-Reply-To: <CD9A4F89-7CA5-4329-A06A-F8DEB87905A5@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hpa@zytor.com
Cc: Roberto Sassu <roberto.sassu@huawei.com>, viro@zeniv.linux.org.uk, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, initramfs@vger.kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com, takondra@cisco.com, kamensky@cisco.com, arnd@arndb.de, rob@landley.net, james.w.mcmechan@gmail.com, niveditas98@gmail.com

On Fri, May 17, 2019 at 01:18:11PM -0700, hpa@zytor.com wrote:
> 
> Ok... I just realized this does not work for a modular initramfs, composed at load time from multiple files, which is a very real problem. Should be easy enough to deal with: instead of one large file, use one companion file per source file, perhaps something like filename..xattrs (suggesting double dots to make it less likely to conflict with a "real" file.) No leading dot, as it makes it more likely that archivers will sort them before the file proper.
This version of the patch was changed from the previous one exactly to deal with this case --
it allows for the bootloader to load multiple initramfs archives, each
with its own .xattr-list file, and to have that work properly.
Could you elaborate on the issue that you see?
