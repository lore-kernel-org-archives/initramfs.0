From: Minfei Huang <mhuang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Add new file to export the common functions
Date: Thu, 29 Oct 2015 14:04:53 +0800
Message-ID: <20151029060453.GA32560@dhcp-128-25.nay.redhat.com>
References: <1441871080-10392-1-git-send-email-mhuang@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441871080-10392-1-git-send-email-mhuang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Hi, Harald.

Ping. Do you have any feedback about this patch?

Thanks
Minfei

On 09/10/15 at 03:44pm, Minfei Huang wrote:
> For now, it will raise many warnings and errors, if third part script
> tries to source the dracut common script(eg. dracut-functions.sh).
> 
> There is a new script file dracut-export-functions.sh to be created
> to solve this issue. This script file is independent with the dracut.
> Any common function can be added in this file to be used by third part
> script.
> 
> Signed-off-by: Minfei Huang <mhuang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  Makefile                   |   2 +
>  dracut-export-functions.sh | 129 +++++++++++++++++++++++++++++++++++++++++++++
>  dracut-functions.sh        | 115 ++--------------------------------------
>  dracut.spec                |   2 +
>  4 files changed, 137 insertions(+), 111 deletions(-)
>  create mode 100755 dracut-export-functions.sh
> 
> diff --git a/Makefile b/Makefile
> index f3a5c07..41cf14c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -120,8 +120,10 @@ install: all
>  	mkdir -p $(DESTDIR)$(pkglibdir)/dracut.conf.d
>  	install -m 0755 dracut-init.sh $(DESTDIR)$(pkglibdir)/dracut-init.sh
>  	install -m 0755 dracut-functions.sh $(DESTDIR)$(pkglibdir)/dracut-functions.sh
> +	install -m 0755 dracut-export-functions.sh $(DESTDIR)$(pkglibdir)/dracut-export-functions.sh
>  	install -m 0755 dracut-version.sh $(DESTDIR)$(pkglibdir)/dracut-version.sh
>  	ln -fs dracut-functions.sh $(DESTDIR)$(pkglibdir)/dracut-functions
> +	ln -fs dracut-export-functions.sh $(DESTDIR)$(pkglibdir)/dracut-export-functions
>  	install -m 0755 dracut-logger.sh $(DESTDIR)$(pkglibdir)/dracut-logger.sh
>  	install -m 0755 dracut-initramfs-restore.sh $(DESTDIR)$(pkglibdir)/dracut-initramfs-restore
>  	cp -arx modules.d $(DESTDIR)$(pkglibdir)
> diff --git a/dracut-export-functions.sh b/dracut-export-functions.sh
> new file mode 100755
> index 0000000..758511c
> --- /dev/null
> +++ b/dracut-export-functions.sh
> @@ -0,0 +1,129 @@
> +#!/bin/bash
> +#
> +# functions used by dracut and other tools.
> +#
> +# Copyright 2015 Red Hat, Inc.  All rights reserved.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +# Generic substring function.  If $2 is in $1, return 0.
> +strstr() { [[ $1 = *"$2"* ]]; }
> +# Generic glob matching function. If glob pattern $2 matches anywhere in $1, OK
> +strglobin() { [[ $1 = *$2* ]]; }
> +# Generic glob matching function. If glob pattern $2 matches all of $1, OK
> +strglob() { [[ $1 = $2 ]]; }
> +# returns OK if $1 contains literal string $2 at the beginning, and isn't empty
> +str_starts() { [ "${1#"$2"*}" != "$1" ]; }
> +# returns OK if $1 contains literal string $2 at the end, and isn't empty
> +str_ends() { [ "${1%*"$2"}" != "$1" ]; }
> +
> +# get_maj_min <device>
> +# Prints the major and minor of a device node.
> +# Example:
> +# $ get_maj_min /dev/sda2
> +# 8:2
> +get_maj_min() {
> +    local _maj _min _majmin
> +    _majmin="$(stat -L -c '%t:%T' "$1" 2>/dev/null)"
> +    printf "%s" "$((0x${_majmin%:*})):$((0x${_majmin#*:}))"
> +}
> +
> +# get a persistent path from a device
> +get_persistent_dev() {
> +    local i _tmp _dev
> +
> +    _dev=$(get_maj_min "$1")
> +    [ -z "$_dev" ] && return
> +
> +    for i in \
> +        /dev/mapper/* \
> +        /dev/disk/${persistent_policy:-by-uuid}/* \
> +        /dev/disk/by-uuid/* \
> +        /dev/disk/by-label/* \
> +        /dev/disk/by-partuuid/* \
> +        /dev/disk/by-partlabel/* \
> +        /dev/disk/by-id/* \
> +        /dev/disk/by-path/* \
> +        ; do
> +        [[ -e "$i" ]] || continue
> +        [[ $i == /dev/mapper/control ]] && continue
> +        [[ $i == /dev/mapper/mpath* ]] && continue
> +        _tmp=$(get_maj_min "$i")
> +        if [ "$_tmp" = "$_dev" ]; then
> +            printf -- "%s" "$i"
> +            return
> +        fi
> +    done
> +    printf -- "%s" "$1"
> +}
> +
> +# ugly workaround for the lvm design
> +# There is no volume group device,
> +# so, there are no slave devices for volume groups.
> +# Logical volumes only have the slave devices they really live on,
> +# but you cannot create the logical volume without the volume group.
> +# And the volume group might be bigger than the devices the LV needs.
> +check_vol_slaves() {
> +    local _lv _vg _pv _dm
> +    for i in /dev/mapper/*; do
> +        [[ $i == /dev/mapper/control ]] && continue
> +        _lv=$(get_maj_min $i)
> +        _dm=/sys/dev/block/$_lv/dm
> +        [[ -f $_dm/uuid  && $(<$_dm/uuid) =~ LVM-* ]] || continue
> +        if [[ $_lv = $2 ]]; then
> +            _vg=$(lvm lvs --noheadings -o vg_name $i 2>/dev/null)
> +            # strip space
> +            _vg=$(printf "%s\n" "$_vg")
> +            if [[ $_vg ]]; then
> +                for _pv in $(lvm vgs --noheadings -o pv_name "$_vg" 2>/dev/null)
> +                do
> +                    check_block_and_slaves $1 $(get_maj_min $_pv) && return 0
> +                done
> +            fi
> +        fi
> +    done
> +    return 1
> +}
> +
> +# Not every device in /dev/mapper should be examined.
> +# If it is an LVM device, touch only devices which have /dev/VG/LV symlink.
> +lvm_internal_dev() {
> +    local dev_dm_dir=/sys/dev/block/$1/dm
> +    [[ ! -f $dev_dm_dir/uuid || $(<$dev_dm_dir/uuid) != LVM-* ]] && return 1 # Not an LVM device
> +    local DM_VG_NAME DM_LV_NAME DM_LV_LAYER
> +    eval $(dmsetup splitname --nameprefixes --noheadings --rows "$(<$dev_dm_dir/name)" 2>/dev/null)
> +    [[ ${DM_VG_NAME} ]] && [[ ${DM_LV_NAME} ]] || return 0 # Better skip this!
> +    [[ ${DM_LV_LAYER} ]] || [[ ! -L /dev/${DM_VG_NAME}/${DM_LV_NAME} ]]
> +}
> +
> +# Walk all the slave relationships for a given block device.
> +# Stop when our helper function returns success
> +# $1 = function to call on every found block device
> +# $2 = block device in major:minor format
> +check_block_and_slaves() {
> +    local _x
> +    [[ -b /dev/block/$2 ]] || return 1 # Not a block device? So sorry.
> +    if ! lvm_internal_dev $2; then "$1" $2 && return; fi
> +    check_vol_slaves "$@" && return 0
> +    if [[ -f /sys/dev/block/$2/../dev ]]; then
> +        check_block_and_slaves $1 $(<"/sys/dev/block/$2/../dev") && return 0
> +    fi
> +    [[ -d /sys/dev/block/$2/slaves ]] || return 1
> +    for _x in /sys/dev/block/$2/slaves/*/dev; do
> +        [[ -f $_x ]] || continue
> +        check_block_and_slaves $1 $(<"$_x") && return 0
> +    done
> +    return 1
> +}
> diff --git a/dracut-functions.sh b/dracut-functions.sh
> index d559903..de8bc1e 100755
> --- a/dracut-functions.sh
> +++ b/dracut-functions.sh
> @@ -17,6 +17,10 @@
>  # You should have received a copy of the GNU General Public License
>  # along with this program.  If not, see <http://www.gnu.org/licenses/>.
>  #
> +
> +exportfunctions=$dracutbasedir/dracut-export-functions.sh
> +. $exportfunctions
> +
>  export LC_MESSAGES=C
>  
>  if [[ $DRACUT_KERNEL_LAZY ]] && ! [[ $DRACUT_KERNEL_LAZY_HASHDIR ]]; then
> @@ -25,17 +29,6 @@ if [[ $DRACUT_KERNEL_LAZY ]] && ! [[ $DRACUT_KERNEL_LAZY_HASHDIR ]]; then
>      fi
>  fi
>  
> -# Generic substring function.  If $2 is in $1, return 0.
> -strstr() { [[ $1 = *"$2"* ]]; }
> -# Generic glob matching function. If glob pattern $2 matches anywhere in $1, OK
> -strglobin() { [[ $1 = *$2* ]]; }
> -# Generic glob matching function. If glob pattern $2 matches all of $1, OK
> -strglob() { [[ $1 = $2 ]]; }
> -# returns OK if $1 contains literal string $2 at the beginning, and isn't empty
> -str_starts() { [ "${1#"$2"*}" != "$1" ]; }
> -# returns OK if $1 contains literal string $2 at the end, and isn't empty
> -str_ends() { [ "${1%*"$2"}" != "$1" ]; }
> -
>  # helper function for check() in module-setup.sh
>  # to check for required installed binaries
>  # issues a standardized warning message
> @@ -321,18 +314,6 @@ get_fs_env() {
>      return 1
>  }
>  
> -# get_maj_min <device>
> -# Prints the major and minor of a device node.
> -# Example:
> -# $ get_maj_min /dev/sda2
> -# 8:2
> -get_maj_min() {
> -    local _maj _min _majmin
> -    _majmin="$(stat -L -c '%t:%T' "$1" 2>/dev/null)"
> -    printf "%s" "$((0x${_majmin%:*})):$((0x${_majmin#*:}))"
> -}
> -
> -
>  # get_devpath_block <device>
>  # get the DEVPATH in /sys of a block device
>  get_devpath_block() {
> @@ -349,35 +330,6 @@ get_devpath_block() {
>      return 1
>  }
>  
> -# get a persistent path from a device
> -get_persistent_dev() {
> -    local i _tmp _dev
> -
> -    _dev=$(get_maj_min "$1")
> -    [ -z "$_dev" ] && return
> -
> -    for i in \
> -        /dev/mapper/* \
> -        /dev/disk/${persistent_policy:-by-uuid}/* \
> -        /dev/disk/by-uuid/* \
> -        /dev/disk/by-label/* \
> -        /dev/disk/by-partuuid/* \
> -        /dev/disk/by-partlabel/* \
> -        /dev/disk/by-id/* \
> -        /dev/disk/by-path/* \
> -        ; do
> -        [[ -e "$i" ]] || continue
> -        [[ $i == /dev/mapper/control ]] && continue
> -        [[ $i == /dev/mapper/mpath* ]] && continue
> -        _tmp=$(get_maj_min "$i")
> -        if [ "$_tmp" = "$_dev" ]; then
> -            printf -- "%s" "$i"
> -            return
> -        fi
> -    done
> -    printf -- "%s" "$1"
> -}
> -
>  expand_persistent_dev() {
>      local _dev=$1
>  
> @@ -609,26 +561,6 @@ host_fs_all()
>      printf "%s\n" "${host_fs_types[@]}"
>  }
>  
> -# Walk all the slave relationships for a given block device.
> -# Stop when our helper function returns success
> -# $1 = function to call on every found block device
> -# $2 = block device in major:minor format
> -check_block_and_slaves() {
> -    local _x
> -    [[ -b /dev/block/$2 ]] || return 1 # Not a block device? So sorry.
> -    if ! lvm_internal_dev $2; then "$1" $2 && return; fi
> -    check_vol_slaves "$@" && return 0
> -    if [[ -f /sys/dev/block/$2/../dev ]]; then
> -        check_block_and_slaves $1 $(<"/sys/dev/block/$2/../dev") && return 0
> -    fi
> -    [[ -d /sys/dev/block/$2/slaves ]] || return 1
> -    for _x in /sys/dev/block/$2/slaves/*/dev; do
> -        [[ -f $_x ]] || continue
> -        check_block_and_slaves $1 $(<"$_x") && return 0
> -    done
> -    return 1
> -}
> -
>  check_block_and_slaves_all() {
>      local _x _ret=1
>      [[ -b /dev/block/$2 ]] || return 1 # Not a block device? So sorry.
> @@ -680,34 +612,6 @@ for_each_host_dev_and_slaves()
>      return 1
>  }
>  
> -# ugly workaround for the lvm design
> -# There is no volume group device,
> -# so, there are no slave devices for volume groups.
> -# Logical volumes only have the slave devices they really live on,
> -# but you cannot create the logical volume without the volume group.
> -# And the volume group might be bigger than the devices the LV needs.
> -check_vol_slaves() {
> -    local _lv _vg _pv _dm
> -    for i in /dev/mapper/*; do
> -        [[ $i == /dev/mapper/control ]] && continue
> -        _lv=$(get_maj_min $i)
> -        _dm=/sys/dev/block/$_lv/dm
> -        [[ -f $_dm/uuid  && $(<$_dm/uuid) =~ LVM-* ]] || continue
> -        if [[ $_lv = $2 ]]; then
> -            _vg=$(lvm lvs --noheadings -o vg_name $i 2>/dev/null)
> -            # strip space
> -            _vg=$(printf "%s\n" "$_vg")
> -            if [[ $_vg ]]; then
> -                for _pv in $(lvm vgs --noheadings -o pv_name "$_vg" 2>/dev/null)
> -                do
> -                    check_block_and_slaves $1 $(get_maj_min $_pv) && return 0
> -                done
> -            fi
> -        fi
> -    done
> -    return 1
> -}
> -
>  # fs_get_option <filesystem options> <search for option>
>  # search for a specific option in a bunch of filesystem options
>  # and return the value
> @@ -1799,17 +1703,6 @@ get_ucode_file ()
>      fi
>  }
>  
> -# Not every device in /dev/mapper should be examined.
> -# If it is an LVM device, touch only devices which have /dev/VG/LV symlink.
> -lvm_internal_dev() {
> -    local dev_dm_dir=/sys/dev/block/$1/dm
> -    [[ ! -f $dev_dm_dir/uuid || $(<$dev_dm_dir/uuid) != LVM-* ]] && return 1 # Not an LVM device
> -    local DM_VG_NAME DM_LV_NAME DM_LV_LAYER
> -    eval $(dmsetup splitname --nameprefixes --noheadings --rows "$(<$dev_dm_dir/name)" 2>/dev/null)
> -    [[ ${DM_VG_NAME} ]] && [[ ${DM_LV_NAME} ]] || return 0 # Better skip this!
> -    [[ ${DM_LV_LAYER} ]] || [[ ! -L /dev/${DM_VG_NAME}/${DM_LV_NAME} ]]
> -}
> -
>  btrfs_devs() {
>      local _mp="$1"
>      btrfs device usage "$_mp" \
> diff --git a/dracut.spec b/dracut.spec
> index 6ef5de7..6b04794 100644
> --- a/dracut.spec
> +++ b/dracut.spec
> @@ -314,8 +314,10 @@ rm -rf -- $RPM_BUILD_ROOT
>  %dir %{dracutlibdir}
>  %dir %{dracutlibdir}/modules.d
>  %{dracutlibdir}/dracut-functions.sh
> +%{dracutlibdir}/dracut-export-functions.sh
>  %{dracutlibdir}/dracut-init.sh
>  %{dracutlibdir}/dracut-functions
> +%{dracutlibdir}/dracut-export-functions
>  %{dracutlibdir}/dracut-version.sh
>  %{dracutlibdir}/dracut-logger.sh
>  %{dracutlibdir}/dracut-initramfs-restore
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
