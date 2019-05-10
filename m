From: Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 1/3] fs: add ksys_lsetxattr() wrapper
Date: Fri, 10 May 2019 23:28:31 +0200
Message-ID: <20190510212831.GD253532@google.com>
References: <20190509112420.15671-1-roberto.sassu@huawei.com>
 <20190509112420.15671-2-roberto.sassu@huawei.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ULvb6m5Ct7N+U+Hk+TL0VPodYz5yvNtcE2Pdidu8130=;
        b=OpeS/e5yAb8uvpLXYNqA6N1MI8D7JXLjmHyNft0qks+8R/zc45m3XbQH7ZLcDfretb
         NJx/g0yV7jox/sIORLwOrxO1a9CV1jZa4gZ98sX8gwy7R8ojzc6s0LmwQEN7UABbk8mb
         Fxhe8bCtYUg4ePrk9piZU6axZgBrTRfXt2Nca9QBNovg68zQtj8GUi/rd7SCaOGE7XQG
         maBuJVPgPv8M7/MFnTidvVHklN5G7hqvUjLYWauPMuQewufDa3+DR5c2bfu6JIzKNOi0
         rmTdxIt5cPg9YEIjCngJ1xtbJ4MWbtHDYD1wkUYVwYJKhe+0vPHojo8IZxOQPW4XrFjy
         V9dA==
Content-Disposition: inline
In-Reply-To: <20190509112420.15671-2-roberto.sassu@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: viro@zeniv.linux.org.uk, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, initramfs@vger.kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com, takondra@cisco.com, kamensky@cisco.com, hpa@zytor.com, arnd@arndb.de, rob@landley.net, james.w.mcmechan@gmail.com

On Thu, May 09, 2019 at 01:24:18PM +0200, Roberto Sassu wrote:
> Similarly to commit 03450e271a16 ("fs: add ksys_fchmod() and do_fchmodat()
> helpers and ksys_chmod() wrapper; remove in-kernel calls to syscall"), this
> patch introduces the ksys_lsetxattr() helper to avoid in-kernel calls to
> the sys_lsetxattr() syscall.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
[...]
> +int ksys_lsetxattr(const char __user *pathname,
> +		   const char __user *name, const void __user *value,
> +		   size_t size, int flags)
> +{
> +	return path_setxattr(pathname, name, value, size, flags, 0);
> +}

Instead of exposing ksys_lsetxattr(), wouldn't it be cleaner to use
kern_path() and vfs_setxattr(), or something like that? Otherwise you're
adding more code that has to cast between kernel and user pointers.
