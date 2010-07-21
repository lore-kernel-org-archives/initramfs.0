From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut-functions: additional symlinks for library files
Date: Wed, 21 Jul 2010 13:39:57 +0200
Message-ID: <4C46DC8D.9010308@redhat.com>
References: <20100707163909.042ddb5e@etiriah>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100707163909.042ddb5e@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

pushed

On 07/07/2010 04:39 PM, Amadeusz =C5=BBo=C5=82nowski wrote:
> rev_lib_symlinks: it's new
> inst_library: creating additional symlinks for installed library file=
s
> ---
>   dracut-functions |   35 ++++++++++++++++++++++++++++++++++-
>   1 files changed, 34 insertions(+), 1 deletions(-)
>
> diff --git a/dracut-functions b/dracut-functions
> index 1f2528e..b9b4d43 100755
> --- a/dracut-functions
> +++ b/dracut-functions
> @@ -226,11 +226,36 @@ inst_simple() {
>       cp -pfL "$src" "${initdir}$target"
>   }
>
> +# find symlinks linked to given library file
> +# $1 =3D library file
> +# Function searches for symlinks by stripping version numbers append=
ed to
> +# library filename, checks if it points to the same target and final=
ly
> +# prints the list of symlinks to stdout.
> +#
> +# Example:
> +# rev_lib_symlinks libfoo.so.8.1
> +# output: libfoo.so.8 libfoo.so
> +# (Only if libfoo.so.8 and libfoo.so exists on host system.)
> +rev_lib_symlinks() {
> +    [[ ! $1 ]]&&  return 0
> +
> +    local fn=3D"$1" orig=3D"$(readlink -f "$1")" links=3D''
> +
> +    [[ ${fn} =3D~ .*\.so\..* ]] || return 1
> +
> +    until [[ ${fn##*.} =3D=3D so ]]; do
> +        fn=3D"${fn%.*}"
> +        [[ -L ${fn}&&  $(readlink -f "${fn}") =3D=3D ${orig} ]]&&  l=
inks+=3D" ${fn}"
> +    done
> +
> +    echo ${links}
> +}
> +
>   # Same as above, but specialized to handle dynamic libraries.
>   # It handles making symlinks according to how the original library
>   # is referenced.
>   inst_library() {
> -    local src=3D$1 dest=3D${2:-$1}
> +    local src=3D$1 dest=3D${2:-$1} lib reallib symlink
>       [[ -e $initdir$dest ]]&&  return 0
>       if [[ -L $src ]]; then
>   	reallib=3D$(readlink -f "$src")
> @@ -241,6 +266,14 @@ inst_library() {
>       else
>   	inst_simple "$src" "$dest"
>       fi
> +
> +    # Create additional symlinks.  See rev_symlinks description.
> +    for symlink in $(rev_lib_symlinks $src) $(rev_lib_symlinks $real=
lib); do
> +        [[ ! -e $initdir$symlink ]]&&  {
> +            dinfo "Creating extra symlink: $symlink"
> +            inst_symlink $symlink
> +        }
> +    done
>   }
>
>   # find a binary.  If we were not passed the full path directly,
