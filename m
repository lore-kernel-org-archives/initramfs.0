From: Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH v4 3/3] gen_init_cpio: add support for file metadata
Date: Thu, 16 Jun 2022 16:47:59 +0200
Message-ID: <20220616144759.GA3967@lxhi-065>
References: <20190523121803.21638-1-roberto.sassu@huawei.com>
 <20190523121803.21638-4-roberto.sassu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-security-module-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190523121803.21638-4-roberto.sassu@huawei.com>
List-ID: <initramfs.vger.kernel.org>
Content-Transfer-Encoding: 7bit
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: viro@zeniv.linux.org.uk, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, initramfs@vger.kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, bug-cpio@gnu.org, zohar@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com, takondra@cisco.com, kamensky@cisco.com, hpa@zytor.com, arnd@arndb.de, rob@landley.net, james.w.mcmechan@gmail.com, niveditas98@gmail.com, Eugeniu Rosca <erosca@de.adit-jv.com>, Eugeniu Rosca <roscaeugeniu@gmail.com>

Hello Roberto,

On Do, Mai 23, 2019 at 02:18:03 +0200, Roberto Sassu wrote:
> This patch adds support for file metadata (only TYPE_XATTR metadata type).
> gen_init_cpio has been modified to read xattrs from files that will be
> added to the image and to include file metadata as separate files with the
> special name 'METADATA!!!'.
> 
> This behavior can be selected by setting the desired file metadata type as
> value for CONFIG_INITRAMFS_FILE_METADATA.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  usr/Kconfig               |   8 +++
>  usr/Makefile              |   4 +-
>  usr/gen_init_cpio.c       | 137 ++++++++++++++++++++++++++++++++++++--
>  usr/gen_initramfs_list.sh |  10 ++-
>  4 files changed, 150 insertions(+), 9 deletions(-)
> 
> diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
> index 03b21189d58b..e93cb1093e77 100644
> --- a/usr/gen_init_cpio.c
> +++ b/usr/gen_init_cpio.c

[..]

> +static int write_xattrs(const char *path)
> +{

[..]

> +
> +		snprintf(str, sizeof(str), "%.8lx",
> +			 sizeof(hdr) + name_len + 1 + value_len);

Cppcheck 2.7 reports at this line:

usr/gen_init_cpio.c:107,portability,invalidPrintfArgType_uint,%lx in format string (no. 1) requires 'unsigned long' but the argument type is 'size_t {aka unsigned long}'.

This can be addressed via 's/lx/zx/', according to https://www.kernel.org/doc/Documentation/printk-formats.txt .

BR, Eugeniu
