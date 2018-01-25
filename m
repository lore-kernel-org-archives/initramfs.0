From: Taras Kondratiuk <takondra@cisco.com>
Subject: [PATCH v2 01/15] Documentation: add newcx initramfs format description
Date: Thu, 25 Jan 2018 03:27:41 +0000
Message-ID: <1516850875-25066-2-git-send-email-takondra@cisco.com>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4385; q=dns/txt; s=iport;
  t=1516851451; x=1518061051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=NWU4LY/nH5TMUYT9fw9A8+lrhtNXYJvc6/0WZT8FYuI=;
  b=WW/BkkhqkFf658Ip5csD49l3OSZQNEWeji2IpJmb5iLaBFi0Ukj5FIiB
   bCp7jRFbPq7jkgD3RgFrKjWO+q4Z0K8Zqg7OVaSFB7N2DKzjthdF6ega5
   TQ5bsqqka8j5HT2SDluUc/TxXy/60JX3RALDrIhjJTKi3vUIkbdnTamGU
   A=;
In-Reply-To: <1516850875-25066-1-git-send-email-takondra@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Rob Landley <rob@landley.net>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Jonathan Corbet <corbet@lwn.net>, James McMechan <james.w.mcmechan@gmail.com>
Cc: initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, xe-linux-external@cisco.com

Many of the Linux security/integrity features are dependent on file
metadata, stored as extended attributes (xattrs), for making decisions.
These features need to be initialized during initcall and enabled as
early as possible for complete security coverage.

Initramfs (tmpfs) supports xattrs, but newc CPIO archive format does not
support including them into the archive.

This patch describes "extended" newc format (newcx) that is based on
newc and has following changes:
- extended attributes support
- increased size of filesize to support files >4GB.
- increased mtime field size to have usec precision and more than
  32-bit of seconds.
- removed unused checksum field.

Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Victor Kamensky <kamensky@cisco.com>
---
 Documentation/early-userspace/buffer-format.txt | 46 ++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/Documentation/early-userspace/buffer-format.txt b/Documentation/early-userspace/buffer-format.txt
index e1fd7f9dad16..d818df4f72dc 100644
--- a/Documentation/early-userspace/buffer-format.txt
+++ b/Documentation/early-userspace/buffer-format.txt
@@ -24,6 +24,7 @@ grammar, where:
 	+	indicates concatenation
 	GZIP()	indicates the gzip(1) of the operand
 	ALGN(n)	means padding with null bytes to an n-byte boundary
+	[n]	means size of field is n bytes
 
 	initramfs  := ("\0" | cpio_archive | cpio_gzip_archive)*
 
@@ -31,20 +32,29 @@ grammar, where:
 
 	cpio_archive := cpio_file* + (<nothing> | cpio_trailer)
 
-	cpio_file := ALGN(4) + cpio_header + filename + "\0" + ALGN(4) + data
+	cpio_file := (cpio_newc_file | cpio_newcx_file)
+
+	cpio_newc_file := ALGN(4) + cpio_newc_header + filename + "\0" + \
+			  ALGN(4) + data
+
+	cpio_newcx_file := ALGN(4) + cpio_newcx_header + filename + "\0" + \
+			   ALGN(4) + xattrs + ALGN(4) + data
+
+	xattrs := xattr_entry*
+
+	xattr_entry := xattr_size[8] + xattr_name + "\0" + xattr_value
 
 	cpio_trailer := ALGN(4) + cpio_header + "TRAILER!!!\0" + ALGN(4)
 
 
 In human terms, the initramfs buffer contains a collection of
-compressed and/or uncompressed cpio archives (in the "newc" or "crc"
-formats); arbitrary amounts zero bytes (for padding) can be added
-between members.
+compressed and/or uncompressed cpio archives; arbitrary amounts
+zero bytes (for padding) can be added between members.
 
 The cpio "TRAILER!!!" entry (cpio end-of-archive) is optional, but is
 not ignored; see "handling of hard links" below.
 
-The structure of the cpio_header is as follows (all fields contain
+The structure of the cpio_newc_header is as follows (all fields contain
 hexadecimal ASCII numbers fully padded with '0' on the left to the
 full width of the field, for example, the integer 4780 is represented
 by the ASCII string "000012ac"):
@@ -81,6 +91,32 @@ algorithm used.
 If the filename is "TRAILER!!!" this is actually an end-of-archive
 marker; the c_filesize for an end-of-archive marker must be zero.
 
+"Extended" newc format (newcx)
+"newcx" cpio format extends "newc" by increasing size of some fields
+and adding extended attributes support. cpio_newcx_header structure:
+
+Field name    Field size	 Meaning
+c_magic	       6 bytes		 The string "070703"
+c_ino	       8 bytes		 File inode number
+c_mode	       8 bytes		 File mode and permissions
+c_uid	       8 bytes		 File uid
+c_gid	       8 bytes		 File gid
+c_nlink	       8 bytes		 Number of links
+c_mtime	      16 bytes		 Modification time (microseconds)
+c_filesize    16 bytes		 Size of data field
+c_maj	       8 bytes		 Major part of file device number
+c_min	       8 bytes		 Minor part of file device number
+c_rmaj	       8 bytes		 Major part of device node reference
+c_rmin	       8 bytes		 Minor part of device node reference
+c_namesize     8 bytes		 Length of filename, including final \0
+c_xattrs_size  8 bytes		 Size of xattrs field
+
+Most of the fields match cpio_newc_header except c_mtime that contains
+microseconds. c_chksum field is dropped.
+
+xattr_size is a total size of xattr_entry including 8 bytes of
+xattr_size. xattr_size has the same hexadecimal ASCII encoding as other
+fields of cpio header.
 
 *** Handling of hard links
 
-- 
2.10.3.dirty

