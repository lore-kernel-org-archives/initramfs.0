From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC] 90crypt: key on rem. device enhancements
Date: Fri, 1 Oct 2010 01:28:09 +0200
Message-ID: <20100930232719.GC6389@nb.net.home>
References: <4c9e7c0d.d39ccc0a.676a.684a@mx.google.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4c9e7c0d.d39ccc0a.676a.684a-ATjtLOhZ0NVl57MIdRCFDg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Amadeusz =?utf-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, Sep 24, 2010 at 11:18:07PM +0200, Amadeusz =C5=BBo=C5=82nowski =
wrote:
> +# Evaluate command for every given device.  Every single device must=
 be
> +# specified either by path, by label prefixed with 'LABEL=3D' or UUI=
D prefixed
> +# with 'UUID=3D'.  UUIDs are processed by 'foreach_uuid_until'.  Lis=
t elements'
> +# order is preserved.
> +#
> +# foreach_dev_until command devices
> +#
> +# command - command to be evaluated
> +# devices - list of devices separated by space
> +#
> +# The function returns after *first successful evaluation* of the gi=
ven command
> +# with status 0.  If evaluation fails for every device, function ret=
urns with
> +# status 1.
> +#
> +# Example:
> +# foreach_dev_until "echo \$___; false" "/dev/sda1 LABEL=3Dboot UUID=
=3D123a"
> +foreach_dev_until() {
> +    local cmd=3D"$1"; shift; local devs_list=3D"$*"
> +    local dev; local ___
> +
> +    [ -n "${cmd}" ] || return 1
> +
> +    if [ -n "${devs_list}" ]; then
> +        for dev in ${devs_list}; do
> +            if strstarts "${dev}" 'UUID=3D'; then
> +                foreach_uuid_until -p 'UUID=3D' "${cmd}" "${dev#UUID=
=3D*}" && \
> +                        return 0
> +            else
> +                [ -e "${dev}" ] || [ -e "/dev/disk/by-label/${dev#LA=
BEL=3D}" ] \

 hmm.. how does it work with blank or non-ascii chars in LABELs?

 ...

> +# It's a wrapper around 'mount' command.  In addition to 'mount' you=
 can specify
> +# device name like "UUID=3D01234567-89ab-cdef-0123-4567890abcde" and
> +# "LABEL=3Dfun_label".  'do_mount' mounts device as read-only for de=
fault.  To
> +# mount as writable pass '-w' option.  'mount_point' argument is req=
uired.
> +#
> +# do_mount [options] dev mount_point
> +#
> +# Extra options:
> +#   -q    Suppress any output.
> +#
> +# Example:
> +# do_mount -q -w LABEL=3Dblah /mnt/disk
> +do_mount() {
> +    local args; local quiet
> +
> +    while [ $# -gt 2 ]; do
> +        case $1 in
> +            -q) quiet=3D'2>/dev/null >/dev/null' ;;
> +            -v) quiet=3D''; args=3D"${args} $1" ;;
> +            *) args=3D"${args} $1" ;;
> +        esac
> +        shift
> +    done
> +
> +    local dev_name=3D"$1"; local dev=3D"${dev_name#*=3D}"; local mou=
nt_point=3D"$2"
> +
> +    case ${dev_name} in
> +        -*) die 'do_mount - wrong usage!' ;;
> +        UUID=3D*) args=3D"${args} -U" ;;
> +        LABEL=3D*) args=3D"${args} -L" ;;

 mount(8) supports LABEL=3D and UUID=3D tags, for example
=20
    mount LABEL=3Dboot /mnt/test
=20
 so, you does not need to convert these tags to -L or -U options.

    Karel

--=20
 Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
 http://karelzak.blogspot.com
