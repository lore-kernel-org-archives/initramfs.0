From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [PATCH 03/10] Defer mount to the real mount loop
Date: Sat, 4 Jul 2009 14:29:53 +0200
Message-ID: <4A4F4B41.2060205@bfh.ch>
References: <1246639520-3094-1-git-send-email-harald@redhat.com> <1246639520-3094-4-git-send-email-harald@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1246639520-3094-4-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Harald Hoyer wrote:
> Udev rules set a /dev/root symlink to the real root and add
> a mount script to /mount/. This enables the proper use of pre-mount
> scripts and prevents mount being killed by a udev timeout.

This looks look good. Network initialization now done asynchronously and 
in parallel again. Thank you!

Some comments below.

> ---
>  modules.d/40network/net-genrules.sh        |    8 ++++----
>  modules.d/95debug/install                  |    2 +-
>  modules.d/95iscsi/iscsiroot                |    2 +-
>  modules.d/95nbd/nbdroot                    |    7 ++++---
>  modules.d/95nfs/nfsroot                    |   23 +++++++++++++----------
>  modules.d/95rootfs-block/block-genrules.sh |    8 ++++----
>  modules.d/99base/init                      |    9 ++++++++-
>  7 files changed, 35 insertions(+), 24 deletions(-)
> 
> diff --git a/modules.d/40network/net-genrules.sh b/modules.d/40network/net-genrules.sh
> index f843c53..dbd0474 100755
> --- a/modules.d/40network/net-genrules.sh
> +++ b/modules.d/40network/net-genrules.sh
> @@ -19,20 +19,20 @@ fix_bootif() {
>      BOOTIF=$(getarg 'BOOTIF=')
>      if [ -n "$BOOTIF" ] ; then
>  	BOOTIF=$(fix_bootif "$BOOTIF")
> -	printf 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="%s", RUN+="/sbin/initqueue /sbin/ifup $env{INTERFACE}"\n' "$BOOTIF"
> +	printf 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="%s", RUN+="/sbin/ifup $env{INTERFACE}"\n' "$BOOTIF"
>  
>      # If we have to handle multiple interfaces, handle only them.
>      elif [ -n "$IFACES" ] ; then
>  	for iface in $IFACES ; do
> -	    printf 'ACTION=="add", SUBSYSTEM=="net", KERNEL=="%s", RUN+="/sbin/initqueue /sbin/ifup $env{INTERFACE}"\n' "$iface"
> +	    printf 'ACTION=="add", SUBSYSTEM=="net", KERNEL=="%s", RUN+="/sbin/ifup $env{INTERFACE}"\n' "$iface"
>  	done
>  
>      # Default: We don't know the interface to use, handle all
>      else
> -	printf 'ACTION=="add", SUBSYSTEM=="net", RUN+="/sbin/initqueue /sbin/ifup $env{INTERFACE}"\n'
> +	printf 'ACTION=="add", SUBSYSTEM=="net", RUN+="/sbin/ifup $env{INTERFACE}"\n'
>      fi
>  
>      # Udev event 'online' only gets fired from ifup/dhclient-script.
>      # No special rules required
> -    printf 'ACTION=="online", SUBSYSTEM=="net", RUN+="/sbin/initqueue /sbin/netroot $env{INTERFACE}"\n'
> +    printf 'ACTION=="online", SUBSYSTEM=="net", RUN+="/sbin/netroot $env{INTERFACE}"\n'
>  } > /etc/udev/rules.d/60-net.rules
> diff --git a/modules.d/95debug/install b/modules.d/95debug/install
> index 33a724d..6d4f089 100755
> --- a/modules.d/95debug/install
> +++ b/modules.d/95debug/install
> @@ -1,3 +1,3 @@
>  #!/bin/bash
> -dracut_install ln ps grep more dmesg cat rm strace free showmount
> +dracut_install ln ps grep more cat rm strace free showmount 
>  dracut_install ping netstat rpcinfo
> diff --git a/modules.d/95iscsi/iscsiroot b/modules.d/95iscsi/iscsiroot
> index 8ee7cbc..316d8f4 100755
> --- a/modules.d/95iscsi/iscsiroot
> +++ b/modules.d/95iscsi/iscsiroot
> @@ -122,7 +122,7 @@ echo "InitiatorName='$iscsi_initiator'" > /dev/.initiatorname.iscsi
>  
>  # FIXME $iscsi_protocol??
>  
> -echo "iscsi_lun=$iscsi_lun . /bin/mount-lun.sh " > /mount/iscsi.sh
> +echo "iscsi_lun=$iscsi_lun . /bin/mount-lun.sh " > /mount/01-$$-iscsi.sh

I'd do that after iscsistart. That way the file is only written if 
iscsistart succeeded.

>  
>  iscsistart -i $iscsi_initiator -t $iscsi_target_name	\
>      -g $iscsi_target_group -a $iscsi_target_ip	\
> diff --git a/modules.d/95nbd/nbdroot b/modules.d/95nbd/nbdroot
> index ad2e906..ecac211 100755
> --- a/modules.d/95nbd/nbdroot
> +++ b/modules.d/95nbd/nbdroot
> @@ -93,9 +93,10 @@ done
>  # If we didn't get a root= on the command line, then we need to
>  # add the udev rules for mounting the nbd0 device
>  if [ ! -e /etc/udev/rules.d/99-mount.rules ]; then
> -    printf 'KERNEL=="%s", RUN+="/sbin/initqueue /bin/mount -t %s -o %s %s %s"\n' \
> -	nbd0 "$nbdfstype" "$fsopts" /dev/nbd0 "$NEWROOT" \
> -		> /etc/udev/rules.d/99-mount.rules
> +    printf 'KERNEL=="nbd0", SYMLINK+="root"\n'> /etc/udev/rules.d/99-mount.rules
> +    printf '/bin/mount -t %s -o %s %s %s\n' \
> +	   "$nbdfstype" "$fsopts" /dev/nbd0 "$NEWROOT" \
> +	> /mount/01-$$-nbd.sh
>  fi

Same here, I'd only write a mount-script if nbdclient succeeds.

>  
>  nbd-client $preopts "$nbdserver" "$nbdport" /dev/nbd0 $opts || exit 1
> diff --git a/modules.d/95nfs/nfsroot b/modules.d/95nfs/nfsroot
> index 0da8ee3..5f5b08f 100755
> --- a/modules.d/95nfs/nfsroot
> +++ b/modules.d/95nfs/nfsroot
> @@ -142,14 +142,17 @@ if [ "$nfs" = "nfs4" ]; then
>      [ -z "$(pidof rpc.idmapd)" ] && rpc.idmapd
>  
>      # XXX Should we loop here?
> -    exec mount -t nfs4 -o$options${nfslock+,$nfslock} \
> -	$server:$path $NEWROOT
> -fi
> -
> -# NFSv{2,3} doesn't support using locks as it requires a helper to transfer
> -# the rpcbind state to the new root
> -[ "$nfslock" = "lock" ] && \
> -    warn "Locks unsupported on NFSv{2,3}, using nolock" 1>&2
> +    echo mount -t nfs4 -o$options${nfslock+,$nfslock} \
> +	$server:$path $NEWROOT > /mount/01-$$-nfs4.sh
> +    [ -e /dev/root ] || >/dev/root
> +else
> +    # NFSv{2,3} doesn't support using locks as it requires a helper to transfer
> +    # the rpcbind state to the new root
> +    [ "$nfslock" = "lock" ] && \
> +        warn "Locks unsupported on NFSv{2,3}, using nolock" 1>&2
>  
> -# XXX Should we loop here?
> -exec mount -t nfs -o$options${options:+,}nolock $server:$path $NEWROOT
> +    # XXX Should we loop here?
> +    echo mount -t nfs -o$options${options:+,}nolock $server:$path $NEWROOT \
> +        > /mount/01-$$-nfs.sh
> +    [ -e /dev/root ] || >/dev/root
> +fi
> diff --git a/modules.d/95rootfs-block/block-genrules.sh b/modules.d/95rootfs-block/block-genrules.sh
> index 2706dbb..5d1a669 100644
> --- a/modules.d/95rootfs-block/block-genrules.sh
> +++ b/modules.d/95rootfs-block/block-genrules.sh
> @@ -1,8 +1,8 @@
>  if [ "${root%%:*}" = "block" ]; then
>      (
> -    printf 'KERNEL=="%s", RUN+="/sbin/initqueue /bin/mount -t %s -o %s %s %s"\n' \
> -	${root#block:/dev/} "$fstype" "$rflags" "${root#block:}" "$NEWROOT"
> -    printf 'SYMLINK=="%s", RUN+="/sbin/initqueue /bin/mount -t %s -o %s %s %s"\n' \
> -	${root#block:/dev/} "$fstype" "$rflags" "${root#block:}" "$NEWROOT"
> +    printf 'KERNEL=="%s", SYMLINK+="root"\n' \
> +	${root#block:/dev/} 
> +    printf 'SYMLINK=="%s", SYMLINK+="root"\n' \
> +	${root#block:/dev/} 
>      ) >> /etc/udev/rules.d/99-mount.rules
>  fi
> diff --git a/modules.d/99base/init b/modules.d/99base/init
> index b49ba21..bb20220 100755
> --- a/modules.d/99base/init
> +++ b/modules.d/99base/init
> @@ -22,8 +22,11 @@ do_initqueue()
>          # bail out, if we have mounted the root filesystem
>  	[ -d "$NEWROOT/proc" ] && break;
>  
> +        # check if root can be mounted
> +        [ -e /dev/root ] && break;
> +
>  	if [ $UDEVVERSION -ge 143 ]; then
> -	    udevadm settle --exit-if-exists=/initqueue/work
> +	    udevadm settle --exit-if-exists=/initqueue/work --exit-if-exists=/dev/root
>  	else
>  	    udevadm settle --timeout=30
>  	fi
> @@ -33,8 +36,12 @@ do_initqueue()
>  	for job in /initqueue/*.job; do
>  	    . $job
>  	    rm -f $job
> +
>              # bail out, if we have mounted the root filesystem
>  	    [ -d "$NEWROOT/proc" ] && break;
> +
> +            # check if root can be mounted
> +	    [ -e /dev/root ] && break;
>  	done
>      done
>  }
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
