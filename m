From: Eugeniu Rosca <erosca-Tbglbhd2jqSoSS7kgVBzIA@public.gmane.org>
Subject: Re: [PATCH v4 1/3] initramfs: add file metadata
Date: Wed, 15 Jun 2022 19:54:12 +0200
Message-ID: <20220615175412.GA7029@lxhi-065>
References: <20190523121803.21638-1-roberto.sassu@huawei.com>
 <20190523121803.21638-2-roberto.sassu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190523121803.21638-2-roberto.sassu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-ID: <initramfs.vger.kernel.org>
Content-Transfer-Encoding: 7bit
To: Roberto Sassu <roberto.sassu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Cc: viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-integrity-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bug-cpio-mXXj517/zsQ@public.gmane.org, silviu.vlasceanu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, dmitry.kasatkin-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, takondra-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, kamensky-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, james.w.mcmechan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, niveditas98-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>, Eugeniu Rosca <erosca-Tbglbhd2jqSoSS7kgVBzIA@public.gmane.org>, Eugeniu Rosca <roscaeugeniu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Hello Roberto,
Hello Mimi,

On Thu, May 23, 2019 at 02:18:01PM +0200, Roberto Sassu wrote:
> From: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
> 
> This patch adds metadata to a file from a supplied buffer. The buffer might
> contains multiple metadata records. The format of each record is:
> 
> <metadata len (ASCII, 8 chars)><version><type><metadata>
> 
> For now, only the TYPE_XATTR metadata type is supported. The specific
> format of this metadata type is:
> 
> <xattr #N name>\0<xattr #N value>
> 
> [kamensky: fixed restoring of xattrs for symbolic links by using
>            sys_lsetxattr() instead of sys_setxattr()]
> 
> [sassu: removed state management, kept only do_setxattrs(), added support
>         for generic file metadata, replaced sys_lsetxattr() with
>         vfs_setxattr(), added check for entry_size, added check for
>         hdr->c_size, replaced strlen() with strnlen(); moved do_setxattrs()
>         before do_name()]
> 
> Signed-off-by: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
> Signed-off-by: Victor Kamensky <kamensky-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Taras Kondratiuk <takondra-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Roberto Sassu <roberto.sassu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
>  include/linux/initramfs.h | 21 ++++++++++
>  init/initramfs.c          | 88 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 107 insertions(+), 2 deletions(-)
>  create mode 100644 include/linux/initramfs.h

[..]

> +static int __init do_setxattrs(char *pathname, char *buf, size_t size)
> +{
> +	struct path path;
> +	char *xattr_name, *xattr_value;
> +	size_t xattr_name_size, xattr_value_size;
> +	int ret;
> +
> +	xattr_name = buf;
> +	xattr_name_size = strnlen(xattr_name, size);
> +	if (xattr_name_size == size) {
> +		error("malformed xattrs");
> +		return -EINVAL;
> +	}
> +

[..]

> +
> +		switch (hdr->c_type) {
> +		case TYPE_XATTR:
> +			do_setxattrs(pathname, buf + sizeof(*hdr),
> +				     entry_size - sizeof(*hdr));

Is it on purpose not to check the return value of do_setxattrs?

I think I would have more comfort and piece of mind if I knew
the return value is properly checked and acted upon. Otherwise,
why returning an int from within do_setxattrs() at all?

BR, Eugeniu
