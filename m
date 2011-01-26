From: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: inst not installing library dependencies of shared objects
Date: Wed, 26 Jan 2011 21:47:37 +0100
Message-ID: <AANLkTi=jb1_kyzDLisXnMigs6aCyuG2eQhvVGhQHZTqs@mail.gmail.com>
References: <AANLkTimXftdnoFMyoHHKF3H4B+x46Hpf8tJbYBEz5QwC@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=1/obVNQrULstmvQQN28/hWPXapWxGzOM6oIYaxWfA5k=;
        b=e/pdhXtZrZq4E/qBBHKAbCFfNJ4n90s4Je/yiAuQeKlhY3d2KxOK2QnZRhNMHMT+i7
         WoQi7u1rOrxV7aVN5xsiBEVI/m9aOpZCZRtOjq5bAbzrMy+xNKo9ZLBD/3I1DO3bZeLB
         rGibXPZNApJKG0TbBC8Hdo6ZhIZWBVkgljJ30=
In-Reply-To: <AANLkTimXftdnoFMyoHHKF3H4B+x46Hpf8tJbYBEz5QwC-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello,

2011/1/25 Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Hello,
>
> I'm trying to add plymouth support to dracut on Ubuntu, and I'm having
> some troubles because some files
> (/lib/plymouth/{script.so,renderers/drm.so,...}) are not executable
> (as Fedora does for example), and that makes inst not install some
> libraries as libpng, libply-splash-graphics.so.2...

I modified inst_binary to also act with non-executable shared objects.

I have also fixed a bug when installing a libraries whose directory
links to another directory (better explained which commands) :

$ ldd `which bash` | grep ld
	/lib64/ld-linux-x86-64.so.2 (0x00007fa1cc3ff000)

$ readlink -f /lib64/ld-linux-x86-64.so.2
/lib/ld-2.12.1.so

So inst_library /lib64/ld-linux-x86-64.so.2 was doing :

(cd "/tmp/initramfs.4uaeD9/lib64" && ln -s "/lib/ld-2.12.1.so"
"ld-linux-x86-64.so.2")

But, /tmp/initramfs.4uaeD9/lib64 -> /lib... :-S

diff --git a/dracut-functions b/dracut-functions
index 2232dc9..473c68c 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -299,6 +299,8 @@ inst_library() {
         lib=${src##*/}
         inst_simple "$reallib" "$reallib"
         inst_dir "${dest%/*}"
+        [[ -L ${initdir}${dest%/*} ]] && \
+        dest=$(readlink -f ${initdir}${dest%/*})/
         (cd "${initdir}${dest%/*}" && ln -s "$reallib" "$lib")
     else
         inst_simple "$src" "$dest"
@@ -317,7 +319,9 @@ inst_library() {
 # search in the usual places to find the binary.
 find_binary() {
     local binpath="/bin /sbin /usr/bin /usr/sbin" p
-    [[ -z ${1##/*} && -x $1 ]] && { echo $1; return 0; }
+    [[ -z ${1##/*} ]] &&
+    ( [[ -x $1 ]] || ( [[ -e $1 ]] && file $1 | grep -q "shared
object.*dynamically linked" )) &&
+    { echo $1; return 0; }
     for p in $binpath; do
         [[ -x $p/$1 ]] && { echo "$p/$1"; return 0; }
     done

Regards,

JonAn.
