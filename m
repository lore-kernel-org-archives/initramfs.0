From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: build initramfs: .hmac symlink not preserved
Date: Tue, 30 Aug 2011 15:18:25 -0700
Message-ID: <4E5D61B1.2040602@bitwagon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Building an initramfs does not preserve symlinks for .hmac files.

For instance on Fedora 16 the symlink
   /lib64/.libcrypto.so.10.hmac -> .libcrypto.so.1.0.0d.hmac
becomes a separate regular file:
-----
$ lsinitrd test.img | grep hmac
-rw-r--r--   1 root     root           65 Jul 26 04:10 usr/lib64/.libssl.so.1.0.0d.hmac
-rw-r--r--   1 root     root           65 Jul 26 04:10 usr/lib64/.libssl.so.10.hmac
-rw-r--r--   1 root     root           65 Jul 26 04:10 lib64/.libcrypto.so.10.hmac
-rw-r--r--   1 root     root           65 Aug 14 22:09 lib64/.libgcrypt.so.11.hmac
-rw-r--r--   1 root     root           65 Jul 26 04:10 lib64/.libcrypto.so.1.0.0d.hmac
$ ls -l /lib64/.*.hmac
-rw-r--r--. 1 root root 65 Jul 26 04:10 /lib64/.libcrypto.so.1.0.0d.hmac
lrwxrwxrwx. 1 root root 25 Aug 25 10:31 /lib64/.libcrypto.so.10.hmac -> .libcrypto.so.1.0.0d.hmac
-rw-r--r--. 1 root root 65 Aug 14 22:09 /lib64/.libgcrypt.so.11.hmac
$
-----

-- 
