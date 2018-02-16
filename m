From: Taras Kondratiuk <takondra-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 01/15] Documentation: add newcx initramfs format description
Date: Fri, 16 Feb 2018 20:33:37 +0000
Message-ID: <1518813234-5874-2-git-send-email-takondra@cisco.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4410; q=dns/txt; s=iport;
  t=1518813238; x=1520022838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=yMQhh7trjXx0Imjbz7ZM1gjvUXuDiSEGQ+gn+V9SJXM=;
  b=bXDnpJN0aXyijdpY17xsN/r7NbAEypIkzil/n7K88V4RCoL8rU4221yl
   EKHPIHiJD58kjJUbDpkUjGP1gFI9i/hUx3Dzmr7WIFkvotJOtsLSTvQ1y
   +3stV4kF5n9iTa3tHy0/r37w5NZWq0SfTW6vlpu7p1Nc3HjmOHpp4d9JI
   8=;
In-Reply-To: <1518813234-5874-1-git-send-email-takondra-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, James McMechan <james.w.mcmechan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Victor Kamensky <kamensky-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xe-linux-external-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org

Many of the Linux security/integrity features are dependent on file
metadata, stored as extended attributes (xattrs), for making decisions.
These features need to be initialized during initcall and enabled as
early as possible for complete security coverage.

Initramfs (tmpfs) supports xattrs, but newc CPIO archive format does not
support including them into the archive.

This patch describes "extended" newc format (newcx) that is based on
newc and has following changes:
- extended attributes support
- increased size of filesize to support files >4GB
- increased mtime field size to have 64 bits of seconds and added a
  field for nanoseconds
- removed unused checksum field

Signed-off-by: Taras Kondratiuk <takondra-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Signed-off-by: Victor Kamensky <kamensky-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
---
 Documentation/early-userspace/buffer-format.txt | 46 ++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/Documentation/early-userspace/buffer-format.txt b/Documentation/early-userspace/buffer-format.txt
index e1fd7f9dad16..8349b2f28b4b 100644
--- a/Documentation/early-userspace/buffer-format.txt
+++ b/Documentation/early-userspace/buffer-format.txt
@@ -24,6 +24,7 @@ grammar, where:
 	+	indicates concatenation
 	GZIP()	indicates the gzip(1) of the operand
 	ALGN(n)	means padding with null bytes to an n-byte boundary
+	[n]	means size of field is n bytes
 
 	initramfs  := ("\0" | cpio_archive | cpio_gzip_archive)*
 
@@ -31,20 +32,33 @@ grammar, where:
 
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
+xattr_size is a total size of xattr_entry including 8 bytes of
+xattr_size. xattr_size has the same hexadecimal ASCII encoding as other
+fields of cpio header (see below).
+
+The structure of the cpio_newc_header is as follows (all fields contain
 hexadecimal ASCII numbers fully padded with '0' on the left to the
 full width of the field, for example, the integer 4780 is represented
 by the ASCII string "000012ac"):
@@ -81,6 +95,28 @@ algorithm used.
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
+c_mtime	      16 bytes		 Modification time (seconds)
+c_mtime_nsec   8 bytes		 Modification time (nanoseconds)
+c_filesize    16 bytes		 Size of data field
+c_maj	       8 bytes		 Major part of file device number
+c_min	       8 bytes		 Minor part of file device number
+c_rmaj	       8 bytes		 Major part of device node reference
+c_rmin	       8 bytes		 Minor part of device node reference
+c_namesize     8 bytes		 Length of filename, including final \0
+c_xattrs_size  8 bytes		 Size of xattrs field
+
+Most of the fields match cpio_newc_header. c_chksum field is dropped.
 
 *** Handling of hard links
 
-- 
2.10.3.dirty
