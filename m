From: Eugeniu Rosca <erosca-Tbglbhd2jqSoSS7kgVBzIA@public.gmane.org>
Subject: Re: [PATCH v4 3/3] gen_init_cpio: add support for file metadata
Date: Thu, 16 Jun 2022 17:16:03 +0200
Message-ID: <20220616151603.GA4400@lxhi-065>
References: <20190523121803.21638-1-roberto.sassu@huawei.com>
 <20190523121803.21638-4-roberto.sassu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190523121803.21638-4-roberto.sassu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-ID: <initramfs.vger.kernel.org>
Content-Transfer-Encoding: 7bit
To: Roberto Sassu <roberto.sassu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-integrity-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bug-cpio-mXXj517/zsQ@public.gmane.org, zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, silviu.vlasceanu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, dmitry.kasatkin-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, takondra-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, kamensky-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, james.w.mcmechan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, niveditas98-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Eugeniu Rosca <erosca-Tbglbhd2jqSoSS7kgVBzIA@public.gmane.org>, Eugeniu Rosca <roscaeugeniu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

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
> Signed-off-by: Roberto Sassu <roberto.sassu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
>  usr/Kconfig               |   8 +++
>  usr/Makefile              |   4 +-
>  usr/gen_init_cpio.c       | 137 ++++++++++++++++++++++++++++++++++++--
>  usr/gen_initramfs_list.sh |  10 ++-
>  4 files changed, 150 insertions(+), 9 deletions(-)
> 
> diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c

[..]

> +static int write_xattrs(const char *path)
> +{

[..]

> +	while (list_ptr < xattr_list + list_len) {
> +		name_len = strlen(list_ptr);

PVS-Studio 7.19 reports at this line:

=> usr/gen_init_cpio.c	84	warn	V769
=> The 'xattr_list' pointer in the 'xattr_list + list_len' expression could be nullptr.
=> In such case, resulting value will be senseless and it should not be used. Check lines: 84, 69.

I guess the finding is valid and it's due to the fact that
the malloc return value is not being checked/sanitized?

BR, Eugeniu.
