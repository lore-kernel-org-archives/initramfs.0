From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] 99base/dracut-lib.sh: 5 new functions & 1 modified
Date: Fri, 12 Nov 2010 14:52:28 +0100
Message-ID: <4CDD469C.2010309@redhat.com>
References: <1289553710-7568-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1289553710-7568-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 12.11.2010 10:21, schrieb Amadeusz =C5=BBo=C5=82nowski:
> New:
>    str_starts, str_replace
>    funiq - print new unique file name
>    mkuniqdir - create and print new unique dir
>    splitsep - splits given string 'str' with separator 'sep' into var=
s
>    udevmatch - create udev rule match for a device
>
> Modified:
>    foreach_uuid_until - use $___ as a place holder
> ---
>   modules.d/99base/dracut-lib.sh |  137 +++++++++++++++++++++++++++++=
++++++++--
>   1 files changed, 130 insertions(+), 7 deletions(-)
>
> diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut=
-lib.sh
> index 596dae2..f0c030b 100755
> --- a/modules.d/99base/dracut-lib.sh
> +++ b/modules.d/99base/dracut-lib.sh
> @@ -6,6 +6,29 @@ strstr() {
>       [ "${1#*$2*}" !=3D "$1" ]
>   }
>
> +# returns OK if $1 contains $2 at the beginning
> +str_starts() {
> +    [ "${1#$2*}" !=3D "$1" ]
> +}
> +
> +# replaces all occurrences of 'search' in 'str' with 'replacement'
> +#
> +# str_replace str search replacement
> +#
> +# example:
> +# str_replace '  one two  three  ' ' ' '_'
> +str_replace() {
> +    local in=3D"$1"; local s=3D"$2"; local r=3D"$3"
> +    local out=3D''
> +
> +    while strstr "${in}" "$s"; do
> +        chop=3D"${in%%$s*}"
> +        out=3D"${out}${chop# }$r"
> +        in=3D"${in#*$s}"
> +    done
> +    echo "${out}${in}"
> +}
> +
>   _getcmdline() {
>       local _line
>       unset _line
> @@ -142,6 +165,34 @@ getoptcomma() {
>       return 1
>   }
>
> +# Splits given string 'str' with separator 'sep' into variables 'var=
1', 'var2',
> +# 'varN'.  If number of fields is less than number of variables, rem=
aining are
> +# not set.  If number of fields is greater than number of variables,=
 the last
> +# variable takes remaining fields.  In short - it acts similary to '=
read'.
> +#
> +# splitsep sep str var1 var2 varN
> +#
> +# example:
> +#   splitsep ':' 'foo:bar:baz' v1 v2
> +# in result:
> +#   v1=3D'foo', v2=3D'bar:baz'
> +#
> +# TODO: ':' inside fields.
> +splitsep() {
> +    local sep=3D"$1"; local str=3D"$2"; shift 2
> +    local tmp
> +
> +    while [ -n "$str" -a -n "$*" ]; do
> +        tmp=3D"${str%%:*}"
> +        eval "$1=3D${tmp}"
> +        str=3D"${str#$tmp}"
> +        str=3D"${str#:}"
> +        shift
> +    done
> +
> +    return 0
> +}
> +
>   setdebug() {
>       if [ -z "$RDDEBUG" ]; then
>           if [ -e /proc/cmdline ]; then
> @@ -337,32 +388,104 @@ ip_to_var() {
>       esac
>   }
>
> -# Evaluate command for UUIDs either given as arguments for this func=
tion or all
> +# Create udev rule match for a device with its device name, or the u=
dev property
> +# ID_FS_UUID or ID_FS_LABEL
> +#
> +# example:
> +#   udevmatch LABEL=3Dboot
> +# prints:
> +#   ENV{ID_FS_LABEL}=3D"boot"
> +#
> +# TOOD: symlinks
> +udevmatch() {
> +    case "$1" in
> +    UUID=3D????????-????-????-????-????????????|LABEL=3D*)
> +        printf 'ENV{ID_FS_%s}=3D=3D"%s"' "${1%%=3D*}" "${1#*=3D}"
> +        ;;
> +    UUID=3D*)
> +        printf 'ENV{ID_FS_UUID}=3D=3D"%s*"' "${1#*=3D}"
> +        ;;
> +    /dev/?*) printf 'KERNEL=3D=3D"%s"' "${1#/dev/}" ;;
> +    *) return 255 ;;
> +    esac
> +}
> +
> +# Prints unique path for potential file inside specified directory. =
 It consists
> +# of specified directory, prefix and number at the end which is incr=
emented
> +# until non-existing file is found.
> +#
> +# funiq dir prefix
> +#
> +# example:
> +# # ls /mnt
> +# cdrom0 cdrom1
> +#
> +# # funiq /mnt cdrom
> +# /mnt/cdrom2
> +funiq() {
> +    local dir=3D"$1"; local prefix=3D"$2"
> +    local i=3D0
> +
> +    [ -d "${dir}" ] || return 1
> +
> +    while [ -e "${dir}/${prefix}$i" ]; do
> +        i=3D$(($i+1)) || return 1
> +    done
> +
> +    echo "${dir}/${prefix}$i"
> +}
> +
> +# Creates unique directory and prints its path.  It's using funiq to=
 generate
> +# path.
> +#
> +# mkuniqdir subdir new_dir_name
> +mkuniqdir() {
> +    local dir=3D"$1"; local prefix=3D"$2"
> +    local retdir; local retdir_new
> +
> +    [ -d "${dir}" ] || mkdir -p "${dir}" || return 1
> +
> +    retdir=3D$(funiq "${dir}" "${prefix}") || return 1
> +    until mkdir "${retdir}" 2>/dev/null; do
> +        retdir_new=3D$(funiq "${dir}" "${prefix}") || return 1
> +        [ "$retdir_new" =3D "$retdir" ]&&  return 1
> +        retdir=3D"$retdir_new"
> +    done
> +
> +    echo "${retdir}"
> +}
> +
> +# Evaluates command for UUIDs either given as arguments for this fun=
ction or all
>   # listed in /dev/disk/by-uuid.  UUIDs doesn't have to be fully spec=
ified.  If
> -# beginning is given it is expanded to all matching UUIDs.  To pass =
full UUID
> -# to your command use '${full_uuid}'.  Remember to escape '$'!
> +# beginning is given it is expanded to all matching UUIDs.  To pass =
full UUID to
> +# your command use '$___' as a place holder.  Remember to escape '$'=
!
> +#
> +# foreach_uuid_until [ -p prefix ] command UUIDs
>   #
> -# $1 =3D command to be evaluated
> -# $2 =3D list of UUIDs separated by space
> +# prefix - string to put just before $___
> +# command - command to be evaluated
> +# UUIDs - list of UUIDs separated by space
>   #
>   # The function returns after *first successful evaluation* of the g=
iven command
>   # with status 0.  If evaluation fails for every UUID function retur=
ns with
>   # status 1.
>   #
>   # Example:
> -# foreach_uuid_until "mount -U \${full_uuid} /mnt; echo OK; umount /=
mnt" \
> +# foreach_uuid_until "mount -U \$___ /mnt; echo OK; umount /mnt" \
>   #       "01234 f512 a235567f-12a3-c123-a1b1-01234567abcb"
>   foreach_uuid_until() (
>       cd /dev/disk/by-uuid
>
> +    [ "$1" =3D -p ]&&  local prefix=3D"$2"&&  shift 2
>       local cmd=3D"$1"; shift; local uuids_list=3D"$*"
> -    local uuid; local full_uuid
> +    local uuid; local full_uuid; local ___
>
>       [ -n "${cmd}" ] || return 1
>
>       for uuid in ${uuids_list:-*}; do
>           for full_uuid in ${uuid}*; do
>               [ -e "${full_uuid}" ] || continue
> +            ___=3D"${prefix}${full_uuid}"
>               eval ${cmd}&&  return 0
>           done
>       done

pushed all three
