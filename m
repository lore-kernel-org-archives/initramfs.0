From: Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [RFC][PATCH] fs: set xattrs in initramfs from regular files
Date: Mon, 26 Nov 2018 07:51:50 -0500
Message-ID: <1543236710.3902.43.camel@linux.ibm.com>
References: <20181122154942.18262-1-roberto.sassu@huawei.com>
         <3d1bfbd7-7d45-4cf1-32d6-7f6985b42393@schaufler-ca.com>
         <1543001453.4298.23.camel@linux.ibm.com>
         <6d6f3a60-7c80-4107-6d9b-be3d53cefefc@schaufler-ca.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6d6f3a60-7c80-4107-6d9b-be3d53cefefc@schaufler-ca.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Casey Schaufler <casey@schaufler-ca.com>, Roberto Sassu <roberto.sassu@huawei.com>, viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, initramfs@vger.kernel.org, linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com, takondra@cisco.com, kamensky@cisco.com, hpa@zytor.com, arnd@arndb.de, rob@landley.net, james.w.mcmechan@gmail.com, Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>

On Fri, 2018-11-23 at 18:07 -0800, Casey Schaufler wrote:
> On 11/23/2018 11:30 AM, Mimi Zohar wrote:
> > On Fri, 2018-11-23 at 11:03 -0800, Casey Schaufler wrote:
> >> On 11/22/2018 7:49 AM, Roberto Sassu wrote:
> >>> Although rootfs (tmpfs) supports xattrs, they are not set due to the
> >>> limitation of the cpio format. A new format called 'newcx' was proposed to
> >>> overcome this limitation.
> >>>
> >>> However, it looks like that adding a new format is not simple: 15 kernel
> >>> patches; user space tools must support the new format; mistakes made in the
> >>> past should be avoided; it is unclear whether the kernel should switch from
> >>> cpio to tar.
> >>>
> >>> The aim of this patch is to provide the same functionality without
> >>> introducing a new format. The value of xattrs is placed in regular files
> >>> having the same file name as the files xattrs are added to, plus a
> >>> separator and the xattr name (<filename>.xattr-<xattr name>).
> >>>
> >>> Example:
> >>>
> >>> '/bin/cat.xattr-security.ima' is the name of a file containing the value of
> >>> the security.ima xattr to be added to /bin/cat.
> >>>
> >>> At kernel initialization time, the kernel iterates over the rootfs
> >>> filesystem, and if it encounters files with the '.xattr-' separator, it
> >>> reads the content and adds the xattr to the file without the suffix.
> >> No.
> >>
> >> Really, no.
> >>
> >> It would be incredibly easy to use this mechanism to break
> >> into systems.

Assuming that the initramfs itself was signed, how?

> >>
> >>> This proposal requires that LSMs and IMA allow the read and setxattr
> >>> operations. This should not be a concern since: files with xattr values
> >>> are not parsed by the kernel; user space processes are not yet executed.
> >>>
> >>> It would be possible to include all xattrs in the same file, but this
> >>> increases the risk of the kernel being compromised by parsing the content.
> >> The kernel mustn't do this.
> > Mustn't do what?  Store the xattr as separate detached files, 
> > include all the xattrs in a single or per security/LSM xattr attribute
> > file(s), or either?
> 
> Any and all of the above. The proposed behavior is a kludge
> around making the installation tools work correctly. Sure, it
> may be easier to change the kernel than to change the utilities.
> That's doesn't make it right.

Modifying userspace tools, as Rob Landley pointed out in terms of
toybox, isn't difficult.  The difficulty has been in reviewing and
upstreaming the kernel CPIO changes.

This patch was posted in order to address the lack of xattr support in
the initramfs.  Before totally dismissing this or a similar solution,
is there a safe method for including the xattrs?

Would defining an LSM hook here help?  Each LSM would define its own
method for storing and applying, or restoring, xattr labels.

Mimi

