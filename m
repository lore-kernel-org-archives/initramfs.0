From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: build initramfs: .hmac symlink not preserved
Date: Wed, 31 Aug 2011 15:21:51 +0200
Message-ID: <4E5E356F.4050503@redhat.com>
References: <4E5D61B1.2040602@bitwagon.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060106040504020407030002"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E5D61B1.2040602-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a multi-part message in MIME format.
--------------060106040504020407030002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 31.08.2011 00:18, John Reiser wrote:
> Building an initramfs does not preserve symlinks for .hmac files.
>
> For instance on Fedora 16 the symlink
>     /lib64/.libcrypto.so.10.hmac ->  .libcrypto.so.1.0.0d.hmac
> becomes a separate regular file:
> -----
> $ lsinitrd test.img | grep hmac
> -rw-r--r--   1 root     root           65 Jul 26 04:10 usr/lib64/.libssl.so.1.0.0d.hmac
> -rw-r--r--   1 root     root           65 Jul 26 04:10 usr/lib64/.libssl.so.10.hmac
> -rw-r--r--   1 root     root           65 Jul 26 04:10 lib64/.libcrypto.so.10.hmac
> -rw-r--r--   1 root     root           65 Aug 14 22:09 lib64/.libgcrypt.so.11.hmac
> -rw-r--r--   1 root     root           65 Jul 26 04:10 lib64/.libcrypto.so.1.0.0d.hmac
> $ ls -l /lib64/.*.hmac
> -rw-r--r--. 1 root root 65 Jul 26 04:10 /lib64/.libcrypto.so.1.0.0d.hmac
> lrwxrwxrwx. 1 root root 25 Aug 25 10:31 /lib64/.libcrypto.so.10.hmac ->  .libcrypto.so.1.0.0d.hmac
> -rw-r--r--. 1 root root 65 Aug 14 22:09 /lib64/.libgcrypt.so.11.hmac
> $
> -----
>

fixed with the attached patch. Thanks!

--------------060106040504020407030002
Content-Type: text/plain;
 name="hmac.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hmac.patch"

diff --git a/dracut-functions b/dracut-functions
index c28766e..3edd4c7 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -320,7 +320,7 @@ inst_simple() {
     fi
     # install checksum files also
     if [[ -e "${_src%/*}/.${_src##*/}.hmac" ]]; then
-        inst_simple "${_src%/*}/.${_src##*/}.hmac" "${target%/*}/.${target##*/}.hmac"
+        inst "${_src%/*}/.${_src##*/}.hmac" "${target%/*}/.${target##*/}.hmac"
     fi
     ddebug "Installing $_src"
     cp -pfL "$_src" "${initdir}$target" 
@@ -360,7 +360,7 @@ inst_library() {
     if [[ -L $_src ]]; then
         # install checksum files also
         if [[ -e "${_src%/*}/.${_src##*/}.hmac" ]]; then
-            inst_simple "${_src%/*}/.${_src##*/}.hmac" "${_dest%/*}/.${_dest##*/}.hmac"
+            inst "${_src%/*}/.${_src##*/}.hmac" "${_dest%/*}/.${_dest##*/}.hmac"
         fi
         _reallib=$(readlink -f "$_src")
         inst_simple "$_reallib" "$_reallib"

--------------060106040504020407030002--
