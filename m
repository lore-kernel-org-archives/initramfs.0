From: Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v3 2/2] initramfs: introduce do_readxattrs()
Date: Fri, 17 May 2019 17:10:15 -0400
Message-ID: <20190517211014.GA9198@rani.riverdale.lan>
References: <20190517165519.11507-1-roberto.sassu@huawei.com>
 <20190517165519.11507-3-roberto.sassu@huawei.com>
 <CD9A4F89-7CA5-4329-A06A-F8DEB87905A5@zytor.com>
 <20190517210219.GA5998@rani.riverdale.lan>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fziPkUVPPd8pNB7Q6ntU7Mk+rKbDI7+Yj/Vwva8hPrU=;
        b=JlnpXgjAvmojHhaoUZEOu7nWYTbT1WVJxhAQg/ltq3l00FQgUC0dvQZf2p22una2rm
         9NInH+w++1EZSp6c9V4ArJNMj0EAJLDYIfxVCMfM8rM9MLmdVhjb+eHTRl+Ra78QFxXX
         IG9d8DqbnCZutAMOvfYCXCVqJ5r6A4eEaaUJATicMAJMWc5TGj7ByHGEXGpxYZnxfpyb
         ZYNmbMJhbE7AzeziqiEnETar43KaaApisrhb3zr50qmubOxdvXZfP7n45h3hE/eMx/ho
         FxWTz+5OCOQzvUJxsZDqZhuohZlwCwT9v0M4p5yk49olx6EVw3thkj8ReeaQbn+Tq7sT
         Gltg==
Content-Disposition: inline
In-Reply-To: <20190517210219.GA5998@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arvind Sankar <nivedita@alum.mit.edu>
Cc: hpa@zytor.com, Roberto Sassu <roberto.sassu@huawei.com>, viro@zeniv.linux.org.uk, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, initramfs@vger.kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com, takondra@cisco.com, kamensky@cisco.com, arnd@arndb.de, rob@landley.net, james.w.mcmechan@gmail.com, niveditas98@gmail.com

On Fri, May 17, 2019 at 05:02:20PM -0400, Arvind Sankar wrote:
> On Fri, May 17, 2019 at 01:18:11PM -0700, hpa@zytor.com wrote:
> > 
> > Ok... I just realized this does not work for a modular initramfs, composed at load time from multiple files, which is a very real problem. Should be easy enough to deal with: instead of one large file, use one companion file per source file, perhaps something like filename..xattrs (suggesting double dots to make it less likely to conflict with a "real" file.) No leading dot, as it makes it more likely that archivers will sort them before the file proper.
> This version of the patch was changed from the previous one exactly to deal with this case --
> it allows for the bootloader to load multiple initramfs archives, each
> with its own .xattr-list file, and to have that work properly.
> Could you elaborate on the issue that you see?
Roberto, are you missing a changelog entry for v2->v3 change?
