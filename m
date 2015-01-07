From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [RFC][PATCH 6/9] gen_initramfs_list.sh: include xattrs
Date: Wed,  7 Jan 2015 15:52:57 -0500
Message-ID: <1420663980-20842-7-git-send-email-zohar@linux.vnet.ibm.com>
References: <1420663980-20842-1-git-send-email-zohar@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420663980-20842-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, Al Viro <viro@ZenIV.linux.org.uk>, linux-ima-devel@lists.sourceforge.net, linux-security-module <linux-security-module@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

This patch modifies the gen_initramfs_list.sh script to include xattrs
in the initramfs.

Dracut creates the initramfs using the cpio tool on the system, not
the kernel's gen_init_cpio script. The following commands, for example,
would create an initramfs containing xattrs.

dracut -H -f /boot/initramfs-3.XX.0+.img 3.XX.0+ -M --keep \
	--noprelink --nostrip
gen_initramfs_list.sh /var/tmp/initramfs.XXXXXX/ > \
	/var/tmp/initramfs_list.XXXXXX

[Sign files here, if not already signed, using evmctl.]

gen_init_cpio -x /var/tmp/initramfs_list.XXXXXX >  \
	/boot/initramfs-3.XX.0+test.img

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 scripts/gen_initramfs_list.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gen_initramfs_list.sh b/scripts/gen_initramfs_list.sh
index 17fa901..20c3a80 100644
--- a/scripts/gen_initramfs_list.sh
+++ b/scripts/gen_initramfs_list.sh
@@ -307,7 +307,7 @@ if [ ! -z ${output_file} ]; then
 			fi
 		fi
 		cpio_tfile="$(mktemp ${TMPDIR:-/tmp}/cpiofile.XXXXXX)"
-		usr/gen_init_cpio $timestamp ${cpio_list} > ${cpio_tfile}
+		usr/gen_init_cpio $timestamp -x ${cpio_list} > ${cpio_tfile}
 	else
 		cpio_tfile=${cpio_file}
 	fi
-- 
1.8.1.4
