From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] 90crypt: keys on external devices support
Date: Wed, 21 Jul 2010 13:41:57 +0200
Message-ID: <4C46DD05.8060901@redhat.com>
References: <20100713191447.0d09d065@etiriah>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100713191447.0d09d065@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

pushed
On 07/13/2010 07:14 PM, Amadeusz =C5=BBo=C5=82nowski wrote:
> 99base/dracut-lib.sh: new fun.: getoptcomma, foreach_uuid_until
> ---
>   modules.d/90crypt/cryptroot-ask.sh |  121 +++++++++++++++++++++++++=
+++--------
>   modules.d/90crypt/parse-crypt.sh   |   45 +++++++++----
>   modules.d/99base/dracut-lib.sh     |   57 +++++++++++++++++
>   3 files changed, 182 insertions(+), 41 deletions(-)
>
> diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90crypt/c=
ryptroot-ask.sh
> index a6a9af1..58bf667 100755
> --- a/modules.d/90crypt/cryptroot-ask.sh
> +++ b/modules.d/90crypt/cryptroot-ask.sh
> @@ -26,40 +26,107 @@ fi
>
>   if [ -f /etc/crypttab ]&&  ! getargs rd_NO_CRYPTTAB; then
>       while read name dev rest; do
> -	# ignore blank lines and comments
> -	if [ -z "$name" -o "${name#\#}" !=3D "$name" ]; then
> -	    continue
> -	fi
> -
> -	# UUID used in crypttab
> -	if [ "${dev%%=3D*}" =3D "UUID" ]; then
> -	    if [ "luks-${dev##UUID=3D}" =3D "$2" ]; then
> -		luksname=3D"$name"
> -		break
> -	    fi
> -=09
> -	# path used in crypttab
> -	else
> -	    cdev=3D$(readlink -f $dev)
> -	    mdev=3D$(readlink -f $device)
> -	    if [ "$cdev" =3D "$mdev" ]; then
> -		luksname=3D"$name"
> -		break
> -	    fi
> -	fi
> +        # ignore blank lines and comments
> +        if [ -z "$name" -o "${name#\#}" !=3D "$name" ]; then
> +            continue
> +        fi
> +
> +        # UUID used in crypttab
> +        if [ "${dev%%=3D*}" =3D "UUID" ]; then
> +            if [ "luks-${dev##UUID=3D}" =3D "$2" ]; then
> +                luksname=3D"$name"
> +                break
> +            fi
> +
> +        # path used in crypttab
> +        else
> +            cdev=3D$(readlink -f $dev)
> +            mdev=3D$(readlink -f $device)
> +            if [ "$cdev" =3D "$mdev" ]; then
> +                luksname=3D"$name"
> +                break
> +            fi
> +        fi
>       done<  /etc/crypttab
>       unset name dev rest
>   fi
>
> +#
> +# Search key on external devices
> +#
> +
> +# Try to mount device specified by UUID and probe for existence of a=
ny of
> +# the paths.  On success return 0 and print "<uuid>  <first-existing=
-path>",
> +# otherwise return 1.
> +# Function leaves mount point created.
> +probe_keydev() {
> +    local uuid=3D"$1"; shift; local keypaths=3D"$*"
> +    local ret=3D1; local mount_point=3D/mnt/keydev
> +    local path
> +
> +    [ -n "${uuid}" -a -n "${keypaths}" ] || return 1
> +    [ -d ${mount_point} ] || mkdir -p "${mount_point}" || return 1
> +
> +    if mount -r -U "${uuid}" "${mount_point}" 2>/dev/null>/dev/null;=
 then
> +        for path in ${keypaths}; do
> +            if [ -f "${mount_point}/${path}" ]; then
> +                echo "${uuid} ${path}"
> +                ret=3D0
> +                break
> +            fi
> +        done
> +    fi
> +
> +    umount "${mount_point}" 2>/dev/null>/dev/null
> +
> +    return ${ret}
> +}
> +
> +keypaths=3D"$(getargs rd_LUKS_KEYPATH)"
> +unset keydev_uuid keypath
> +
> +if [ -n "$keypaths" ]; then
> +    keydev_uuids=3D"$(getargs rd_LUKS_KEYDEV_UUID)"
> +    [ -n "$keydev_uuids" ] || {
> +            warn 'No UUID of device storing LUKS key specified.'
> +            warn 'It is recommended to set rd_LUKS_KEYDEV_UUID.'
> +            warn 'Performing scan of *all* devices accessible by UUI=
D...'
> +    }
> +    tmp=3D$(foreach_uuid_until "probe_keydev \$full_uuid $keypaths" =
\
> +            $keydev_uuids)&&  {
> +        keydev_uuid=3D"${tmp%% *}"
> +        keypath=3D"${tmp#* }"
> +    } || {
> +        warn "Key for $device not found."
> +    }
> +    unset tmp keydev_uuids
> +fi
> +
> +unset keypaths
> +
> +#
> +# Open LUKS device
> +#
> +
>   info "luksOpen $device $luksname"
> -# flock against other interactive activities
> -{ flock -s 9;
> -    echo -n "$device ($luksname) is password protected"
> -    cryptsetup luksOpen -T1 $1 $luksname
> -} 9>/.console.lock
> +
> +if [ -n "$keydev_uuid" ]; then
> +    mntp=3D/mnt/keydev
> +    mkdir -p "$mntp"
> +    mount -r -U "$keydev_uuid" "$mntp"
> +    cryptsetup -d "$mntp/$keypath" luksOpen "$device" "$luksname"
> +    umount "$mntp"
> +    rmdir -p "$mntp" 2>/dev/null
> +else
> +    # flock against other interactive activities
> +    { flock -s 9;
> +        echo -n "$device ($luksname) is password protected"
> +        cryptsetup luksOpen -T1 $1 $luksname
> +    } 9>/.console.lock
> +fi
>
>   # mark device as asked
>   >>  /tmp/cryptroot-asked-$2
>
>   exit 0
> -# vim:ts=3D8:sw=3D4:sts=3D4:et
> \ No newline at end of file
> +# vim:ts=3D8:sw=3D4:sts=3D4:et
> diff --git a/modules.d/90crypt/parse-crypt.sh b/modules.d/90crypt/par=
se-crypt.sh
> index 04d9ecb..fce952d 100755
> --- a/modules.d/90crypt/parse-crypt.sh
> +++ b/modules.d/90crypt/parse-crypt.sh
> @@ -4,23 +4,40 @@ if getarg rd_NO_LUKS; then
>       rm -f /etc/udev/rules.d/70-luks.rules
>   else
>       {
> -	echo 'SUBSYSTEM!=3D"block", GOTO=3D"luks_end"'
> -	echo 'ACTION!=3D"add|change", GOTO=3D"luks_end"'
> +        echo 'SUBSYSTEM!=3D"block", GOTO=3D"luks_end"'
> +        echo 'ACTION!=3D"add|change", GOTO=3D"luks_end"'
>       }>  /etc/udev/rules.d/70-luks.rules
> -    LUKS=3D$(getargs rd_LUKS_UUID=3D)
> +
> +    LUKS=3D$(getargs rd_LUKS_UUID)
> +    unset settled
> +    [ -n "$(getargs rd_LUKS_KEYPATH)" ]&&  \
> +            [ -z "$(getargs rd_LUKS_KEYDEV_UUID)" ]&&  \
> +            settled=3D'--settled'
> +
>       if [ -n "$LUKS" ]; then
> -	echo '. /lib/dracut-lib.sh'>  /emergency/crypt.sh
> -	for luksid in $LUKS; do
> -	printf 'ENV{ID_FS_TYPE}=3D=3D"crypto_LUKS", ENV{ID_FS_UUID}=3D=3D"*=
%s*", RUN+=3D"/sbin/initqueue --unique --onetime --name cryptroot-ask-%=
%k /sbin/cryptroot-ask $env{DEVNAME} luks-$env{ID_FS_UUID}"\n' $luksid =
\
> -	>>  /etc/udev/rules.d/70-luks.rules=09
> -	printf '[ -e /dev/disk/by-uuid/*%s* ] || exit 1 \n'  $luksid>>  /in=
itqueue-finished/crypt.sh
> -	printf '[ -e /dev/disk/by-uuid/*%s* ] || warn "crypto LUKS UUID "%s=
" not found" \n' $luksid $luksid>>  /emergency/00-crypt.sh
> -	done
> +        echo '. /lib/dracut-lib.sh'>  /emergency/crypt.sh
> +        for luksid in $LUKS; do
> +            {
> +                printf 'ENV{ID_FS_TYPE}=3D=3D"crypto_LUKS", '
> +                printf 'ENV{ID_FS_UUID}=3D=3D"*%s*", ' $luksid
> +                printf 'RUN+=3D"/sbin/initqueue --unique --onetime %=
s ' "$settled"
> +                printf '--name cryptroot-ask-%%k /sbin/cryptroot-ask=
 '
> +                printf '$env{DEVNAME} luks-$env{ID_FS_UUID}"\n'
> +            }>>  /etc/udev/rules.d/70-luks.rules
> +
> +            printf '[ -e /dev/disk/by-uuid/*%s* ] || exit 1\n' $luks=
id \
> +>>  /initqueue-finished/crypt.sh
> +            {
> +                printf '[ -e /dev/disk/by-uuid/*%s* ] || ' $luksid
> +                printf 'warn "crypto LUKS UUID "%s" not found"\n' $l=
uksid
> +            }>>  /emergency/00-crypt.sh
> +        done
>       else
> -	echo 'ENV{ID_FS_TYPE}=3D=3D"crypto_LUKS", RUN+=3D"/sbin/initqueue -=
-unique --onetime --name cryptroot-ask-%k /sbin/cryptroot-ask $env{DEVN=
AME} luks-$env{ID_FS_UUID}"' \
> -	>>  /etc/udev/rules.d/70-luks.rules=09
> +        echo 'ENV{ID_FS_TYPE}=3D=3D"crypto_LUKS", RUN+=3D"/sbin/init=
queue' $settled \
> +                '--unique --onetime --name cryptroot-ask-%k' \
> +                '/sbin/cryptroot-ask $env{DEVNAME} luks-$env{ID_FS_U=
UID}"' \
> +>>  /etc/udev/rules.d/70-luks.rules
>       fi
> -    echo 'LABEL=3D"luks_end"'>>  /etc/udev/rules.d/70-luks.rules
>
> +    echo 'LABEL=3D"luks_end"'>>  /etc/udev/rules.d/70-luks.rules
>   fi
> -
> diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut=
-lib.sh
> index 2624f7d..84bb5fa 100755
> --- a/modules.d/99base/dracut-lib.sh
> +++ b/modules.d/99base/dracut-lib.sh
> @@ -48,6 +48,31 @@ getargs() {
>       return 1;
>   }
>
> +# Prints value of given option.  If option is a flag and it's presen=
t,
> +# it just returns 0.  Otherwise 1 is returned.
> +# $1 =3D options separated by commas
> +# $2 =3D option we are interested in
> +#
> +# Example:
> +# $1 =3D cipher=3Daes-cbc-essiv:sha256,hash=3Dsha256,verify
> +# $2 =3D hash
> +# Output:
> +# sha256
> +getoptcomma() {
> +    local line=3D",$1,"; local opt=3D"$2"; local tmp
> +
> +    case "${line}" in
> +        *,${opt}=3D*,*)
> +            tmp=3D"${line#*,${opt}=3D}"
> +            echo "${tmp%%,*}"
> +            return 0
> +        ;;
> +        *,${opt},*) return 0 ;;
> +    esac
> +
> +    return 1
> +}
> +
>   setdebug() {
>       if [ -z "$RDDEBUG" ]; then
>           if [ -e /proc/cmdline ]; then
> @@ -243,3 +268,35 @@ ip_to_var() {
>       esac
>   }
>
> +# Evaluate command for UUIDs either given as arguments for this func=
tion or all
> +# listed in /dev/disk/by-uuid.  UUIDs doesn't have to be fully speci=
fied.  If
> +# beginning is given it is expanded to all matching UUIDs.  To pass =
full UUID
> +# to your command use '${full_uuid}'.  Remember to escape '$'!
> +#
> +# $1 =3D command to be evaluated
> +# $2 =3D list of UUIDs separated by space
> +#
> +# The function returns after *first successful evaluation* of the gi=
ven command
> +# with status 0.  If evaluation fails for every UUID function return=
s with
> +# status 1.
> +#
> +# Example:
> +# foreach_uuid_until "mount -U \${full_uuid} /mnt; echo OK; umount /=
mnt" \
> +#       "01234 f512 a235567f-12a3-c123-a1b1-01234567abcb"
> +foreach_uuid_until() (
> +    cd /dev/disk/by-uuid
> +
> +    local cmd=3D"$1"; shift; local uuids_list=3D"$*"
> +    local uuid; local full_uuid
> +
> +    [ -n "${cmd}" ] || return 1
> +
> +    for uuid in ${uuids_list:-*}; do
> +        for full_uuid in ${uuid}*; do
> +            [ -e "${full_uuid}" ] || continue
> +            eval ${cmd}&&  return 0
> +        done
> +    done
> +
> +    return 1
> +)
