From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC][PATCH] fs: set xattrs in initramfs from regular files
Date: Fri, 23 Nov 2018 11:03:54 -0800
Message-ID: <3d1bfbd7-7d45-4cf1-32d6-7f6985b42393@schaufler-ca.com>
References: <20181122154942.18262-1-roberto.sassu@huawei.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1542999845; bh=+mpW5xSOh9pK415LA4XI29oBu1LkOiJlnczzG3Cdrzc=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=uJj+LkTSjoG7IG+XzqflKi9/fQ2wYT+fV2mSaN5YmeBTvYTZo9i/53vfm6sgj1HYAGRtxyx3P2Oui9tI/1jVdMbGmdgUBhq6mubyLz3VrnP75wAUz2PddX0zSKKDjxMNvhrpnFgPIWYni4yp+SMPyp63mwSaRZXD4XozLnQUNBhBw08SjTak8Po7vYrfObkb4ij1ssO1ARSIHe+WOnaPVGKx3BnCBOKGTtvDsN8qLwBi5CbYxG5RIkOuQgLr5+Oq78dSinJmjbtxzp8PY2hCm5K76iFCrg/aAXHXQDCCMuJxrC5EX1utKBs2HFCeUThEMUJ4nYpQsxDsGK9Zz1IoNQ==
In-Reply-To: <20181122154942.18262-1-roberto.sassu@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Roberto Sassu <roberto.sassu@huawei.com>, viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, initramfs@vger.kernel.org, linux-kernel@vger.kernel.org, zohar@linux.ibm.com, silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com, takondra@cisco.com, kamensky@cisco.com, hpa@zytor.com, arnd@arndb.de, rob@landley.net, james.w.mcmechan@gmail.com

On 11/22/2018 7:49 AM, Roberto Sassu wrote:
> Although rootfs (tmpfs) supports xattrs, they are not set due to the
> limitation of the cpio format. A new format called 'newcx' was proposed to
> overcome this limitation.
>
> However, it looks like that adding a new format is not simple: 15 kernel
> patches; user space tools must support the new format; mistakes made in t=
he
> past should be avoided; it is unclear whether the kernel should switch fr=
om
> cpio to tar.
>
> The aim of this patch is to provide the same functionality without
> introducing a new format. The value of xattrs is placed in regular files
> having the same file name as the files xattrs are added to, plus a
> separator and the xattr name (<filename>.xattr-<xattr name>).
>
> Example:
>
> '/bin/cat.xattr-security.ima' is the name of a file containing the value =
of
> the security.ima xattr to be added to /bin/cat.
>
> At kernel initialization time, the kernel iterates over the rootfs
> filesystem, and if it encounters files with the '.xattr-' separator, it
> reads the content and adds the xattr to the file without the suffix.

No.

Really, no.

It would be incredibly easy to use this mechanism to break
into systems.
=C2=A0

> This proposal requires that LSMs and IMA allow the read and setxattr
> operations. This should not be a concern since: files with xattr values
> are not parsed by the kernel; user space processes are not yet executed.
>
> It would be possible to include all xattrs in the same file, but this
> increases the risk of the kernel being compromised by parsing the content.

The kernel mustn't do this.

>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  fs/Makefile        |   2 +-
>  fs/readxattr.c     | 171 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |   2 +
>  init/main.c        |   1 +
>  4 files changed, 175 insertions(+), 1 deletion(-)
>  create mode 100644 fs/readxattr.c
>
> diff --git a/fs/Makefile b/fs/Makefile
> index 293733f61594..738e1a4e4aff 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -12,7 +12,7 @@ obj-y :=3D	open.o read_write.o file_table.o super.o \
>  		attr.o bad_inode.o file.o filesystems.o namespace.o \
>  		seq_file.o xattr.o libfs.o fs-writeback.o \
>  		pnode.o splice.o sync.o utimes.o d_path.o \
> -		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o
> +		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o readxattr.o
> =20
>  ifeq ($(CONFIG_BLOCK),y)
>  obj-y +=3D	buffer.o block_dev.o direct-io.o mpage.o
> diff --git a/fs/readxattr.c b/fs/readxattr.c
> new file mode 100644
> index 000000000000..01838f6f1e92
> --- /dev/null
> +++ b/fs/readxattr.c
> @@ -0,0 +1,171 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Huawei Technologies Duesseldorf GmbH
> + *
> + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation, version 2 of the
> + * License.
> + *
> + * File: readxattr.c
> + *      Read extended attributes from regular files in the initial ram d=
isk
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/export.h>
> +#include <linux/xattr.h>
> +#include <linux/file.h>
> +#include <linux/cred.h>
> +#include <linux/namei.h>
> +#include <linux/fs.h>
> +
> +#include "internal.h"
> +
> +#define SETXATTR_FILENAME ".setxattr"
> +#define FILENAME_XATTR_SEP ".xattr-"
> +
> +
> +struct readdir_callback {
> +	struct dir_context ctx;
> +	struct path *path;
> +};
> +
> +LIST_HEAD(dir_list);
> +
> +struct dir_path {
> +	struct list_head next;
> +	struct path path;
> +};
> +
> +static int __init read_set_xattr(struct dir_context *__ctx, const char *=
name,
> +				 int namelen, loff_t offset, u64 ino,
> +				 unsigned int d_type)
> +{
> +	struct readdir_callback *ctx =3D container_of(__ctx, typeof(*ctx), ctx);
> +	struct path *dir =3D ctx->path, source_path, target_path;
> +	char filename[NAME_MAX + 1], *xattrname, *separator;
> +	struct dir_path *subdir;
> +	struct file *file;
> +	void *datap;
> +	loff_t size;
> +	int result;
> +
> +	if (!strcmp(name, ".") || !strcmp(name, ".."))
> +		return 0;
> +
> +	result =3D vfs_path_lookup(dir->dentry, dir->mnt, name, 0, &source_path=
);
> +	if (result)
> +		return 0;
> +
> +	size =3D i_size_read(source_path.dentry->d_inode);
> +	if (size > XATTR_SIZE_MAX)
> +		goto out;
> +
> +	if (source_path.dentry->d_inode->i_sb !=3D dir->dentry->d_inode->i_sb)
> +		goto out;
> +
> +	if (!S_ISREG(source_path.dentry->d_inode->i_mode) &&
> +	    !S_ISDIR(source_path.dentry->d_inode->i_mode))
> +		goto out;
> +
> +	if (S_ISREG(source_path.dentry->d_inode->i_mode)) {
> +		separator =3D strstr(name, FILENAME_XATTR_SEP);
> +		if (!separator)
> +			goto out;
> +
> +		xattrname =3D separator + sizeof(FILENAME_XATTR_SEP) - 1;
> +		if (strlen(xattrname) > XATTR_NAME_MAX)
> +			goto out;
> +	} else {
> +		subdir =3D kmalloc(sizeof(*subdir), GFP_KERNEL);
> +		if (subdir) {
> +			subdir->path.dentry =3D source_path.dentry;
> +			subdir->path.mnt =3D source_path.mnt;
> +
> +			list_add(&subdir->next, &dir_list);
> +		}
> +
> +		return 0;
> +	}
> +
> +	file =3D dentry_open(&source_path, O_RDONLY, current_cred());
> +	if (IS_ERR(file))
> +		goto out;
> +
> +	result =3D kernel_read_file(file, &datap, &size, 0, READING_XATTR);
> +	if (result)
> +		goto out_fput;
> +
> +	if (separator !=3D name) {
> +		snprintf(filename, sizeof(filename), "%.*s",
> +			 (int)(namelen - strlen(separator)), name);
> +
> +		result =3D vfs_path_lookup(dir->dentry, dir->mnt, filename, 0,
> +					&target_path);
> +		if (result)
> +			goto out_vfree;
> +
> +		inode_lock(target_path.dentry->d_inode);
> +	} else {
> +		target_path.dentry =3D dir->dentry;
> +		target_path.mnt =3D dir->mnt;
> +	}
> +
> +	__vfs_setxattr_noperm(target_path.dentry, xattrname, datap, size, 0);
> +
> +	if (separator !=3D name) {
> +		inode_unlock(target_path.dentry->d_inode);
> +		path_put(&target_path);
> +	}
> +out_vfree:
> +	vfree(datap);
> +out_fput:
> +	fput(file);
> +out:
> +	path_put(&source_path);
> +	return 0;
> +}
> +
> +void __init set_xattrs_initrd(void)
> +{
> +	struct readdir_callback buf =3D {
> +		.ctx.actor =3D read_set_xattr,
> +	};
> +
> +	struct dir_path dir, *cur_dir;
> +	struct path path;
> +	struct file *file;
> +	int result;
> +
> +	result =3D kern_path(SETXATTR_FILENAME, 0, &path);
> +	if (result)
> +		return;
> +
> +	path_put(&path);
> +
> +	result =3D kern_path("/", 0, &dir.path);
> +	if (result)
> +		return;
> +
> +	list_add(&dir.next, &dir_list);
> +
> +	while (!list_empty(&dir_list)) {
> +		cur_dir =3D list_first_entry(&dir_list, typeof(*cur_dir), next);
> +
> +		file =3D dentry_open(&cur_dir->path, O_RDONLY, current_cred());
> +		if (file) {
> +			buf.path =3D &cur_dir->path;
> +			iterate_dir(file, &buf.ctx);
> +			fput(file);
> +		}
> +
> +		path_put(&cur_dir->path);
> +		list_del(&cur_dir->next);
> +
> +		if (cur_dir !=3D &dir)
> +			kfree(cur_dir);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(set_xattrs_initrd);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c95c0807471f..b04edc1c32e9 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2894,6 +2894,7 @@ extern int do_pipe_flags(int *, int);
>  	id(KEXEC_INITRAMFS, kexec-initramfs)	\
>  	id(POLICY, security-policy)		\
>  	id(X509_CERTIFICATE, x509-certificate)	\
> +	id(XATTR, xattr)	\
>  	id(MAX_ID, )
> =20
>  #define __fid_enumify(ENUM, dummy) READING_ ## ENUM,
> @@ -3156,6 +3157,7 @@ const char *simple_get_link(struct dentry *, struct=
 inode *,
>  extern const struct inode_operations simple_symlink_inode_operations;
> =20
>  extern int iterate_dir(struct file *, struct dir_context *);
> +extern void set_xattrs_initrd(void);
> =20
>  extern int vfs_statx(int, const char __user *, int, struct kstat *, u32);
>  extern int vfs_statx_fd(unsigned int, struct kstat *, u32, unsigned int);
> diff --git a/init/main.c b/init/main.c
> index ee147103ba1b..a2f63bc8f9d4 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1180,5 +1180,6 @@ static noinline void __init kernel_init_freeable(vo=
id)
>  	 */
> =20
>  	integrity_load_keys();
> +	set_xattrs_initrd();
>  	load_default_modules();
>  }

