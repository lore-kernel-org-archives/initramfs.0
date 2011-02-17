From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: inst not installing library dependencies of shared objects
Date: Thu, 17 Feb 2011 10:52:23 +0100
Message-ID: <4D5CEFD7.70604@redhat.com>
References: <AANLkTimXftdnoFMyoHHKF3H4B+x46Hpf8tJbYBEz5QwC@mail.gmail.com> <AANLkTi=jb1_kyzDLisXnMigs6aCyuG2eQhvVGhQHZTqs@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTi=jb1_kyzDLisXnMigs6aCyuG2eQhvVGhQHZTqs-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 26.01.2011 21:47, schrieb Jon Ander Hernandez:
> Hello,
> 
> 2011/1/25 Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>> Hello,
>>
>> I'm trying to add plymouth support to dracut on Ubuntu, and I'm having
>> some troubles because some files
>> (/lib/plymouth/{script.so,renderers/drm.so,...}) are not executable
>> (as Fedora does for example), and that makes inst not install some
>> libraries as libpng, libply-splash-graphics.so.2...
> 
> I modified inst_binary to also act with non-executable shared objects.
> 
> I have also fixed a bug when installing a libraries whose directory
> links to another directory (better explained which commands) :
> 
> $ ldd `which bash` | grep ld
> 	/lib64/ld-linux-x86-64.so.2 (0x00007fa1cc3ff000)
> 
> $ readlink -f /lib64/ld-linux-x86-64.so.2
> /lib/ld-2.12.1.so
> 
> So inst_library /lib64/ld-linux-x86-64.so.2 was doing :
> 
> (cd "/tmp/initramfs.4uaeD9/lib64" && ln -s "/lib/ld-2.12.1.so"
> "ld-linux-x86-64.so.2")
> 
> But, /tmp/initramfs.4uaeD9/lib64 -> /lib... :-S
> 
> diff --git a/dracut-functions b/dracut-functions
> index 2232dc9..473c68c 100755
> --- a/dracut-functions
> +++ b/dracut-functions
> @@ -299,6 +299,8 @@ inst_library() {
>          lib=${src##*/}
>          inst_simple "$reallib" "$reallib"
>          inst_dir "${dest%/*}"
> +        [[ -L ${initdir}${dest%/*} ]] && \
> +        dest=$(readlink -f ${initdir}${dest%/*})/
>          (cd "${initdir}${dest%/*}" && ln -s "$reallib" "$lib")
>      else
>          inst_simple "$src" "$dest"
> @@ -317,7 +319,9 @@ inst_library() {
>  # search in the usual places to find the binary.
>  find_binary() {
>      local binpath="/bin /sbin /usr/bin /usr/sbin" p
> -    [[ -z ${1##/*} && -x $1 ]] && { echo $1; return 0; }
> +    [[ -z ${1##/*} ]] &&
> +    ( [[ -x $1 ]] || ( [[ -e $1 ]] && file $1 | grep -q "shared
> object.*dynamically linked" )) &&
> +    { echo $1; return 0; }
>      for p in $binpath; do
>          [[ -x $p/$1 ]] && { echo "$p/$1"; return 0; }
>      done
> 
> Regards,
> 
> JonAn.

Thanks! Pushed.. Let me know, if
http://dracut.git.sourceforge.net/git/gitweb.cgi?p=dracut/dracut;a=commitdiff;h=81c6e7fb69a0b7ef5169d13f8b4a4025db923ead

works also for you.

The other patch is:
http://dracut.git.sourceforge.net/git/gitweb.cgi?p=dracut/dracut;a=commitdiff;h=172d85b9c949b321771d63dbd5f06ecf19cf94f0
