From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 9/9] Add NBD support
Date: Mon, 01 Jun 2009 04:41:41 -0500
Message-ID: <1243849301.647.20.camel@sentry-no.fnordovax.org>
References: <cover.1243833882.git.dave@thedillows.org>
	 <2b117123ecd2d93cec8598593e966029dfb4777e.1243833882.git.dave@thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=jI7VQAMWDI1Bj7/4Gx+wsgdP9K2YG4HOaYEUvtXyZ+o=;
        b=nJGBe7VFHE9H7J0+QQKzetut+1sWXj1LOm4d4vU9oL91WpxnMEjCiCfx7egOyBj7NN
         xYvpoZ29HSkEa7ESAyNmEBs78GDafNDzI8YR5be9+R28Ib0b7HraurQSHrZhv9tz5Idh
         4AHeB36VdDzY7cHfNzZVL7fpnyVr3cp0xd0Cs=
In-Reply-To: <2b117123ecd2d93cec8598593e966029dfb4777e.1243833882.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, 2009-06-01 at 00:59 -0400, David Dillow wrote:
> This adds basic support for root on a network block device to
> the netroot framework.
> 
> Signed-off-by: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
> ---
>  modules.d/95nbd/check            |   11 ++++
>  modules.d/95nbd/install          |    7 +++
>  modules.d/95nbd/nbd-netroot.sh   |   11 ++++
>  modules.d/95nbd/nbdroot          |   96 ++++++++++++++++++++++++++++++++++++++
>  modules.d/95nbd/parse-nbdroot.sh |   49 +++++++++++++++++++
>  5 files changed, 174 insertions(+), 0 deletions(-)
>  create mode 100755 modules.d/95nbd/check
>  create mode 100755 modules.d/95nbd/install
>  create mode 100755 modules.d/95nbd/nbd-netroot.sh
>  create mode 100755 modules.d/95nbd/nbdroot
>  create mode 100755 modules.d/95nbd/parse-nbdroot.sh
> 
> diff --git a/modules.d/95nbd/check b/modules.d/95nbd/check
> new file mode 100755
> index 0000000..f94d63b
> --- /dev/null
> +++ b/modules.d/95nbd/check
> @@ -0,0 +1,11 @@
> +#!/bin/sh
> +# We depend on network modules being loaded
> +[ "$1" = "-d" ] && echo network
> +
> +# If hostonly was requested, fail the check if we are not actually
> +# booting from root.
> +[ "$1" = "-h" ] && ! egrep -q '/ /dev/nbd[0-9]*' /proc/mounts && exit 1
> +
> +# If our prerequisites are not met, fail anyways.
> +which nbd-client >/dev/null 2>&1 || exit 1
> +exit 0
> diff --git a/modules.d/95nbd/install b/modules.d/95nbd/install
> new file mode 100755
> index 0000000..3a80da1
> --- /dev/null
> +++ b/modules.d/95nbd/install
> @@ -0,0 +1,7 @@
> +#!/bin/bash
> +
> +inst nbd-client
> +inst_hook cmdline 90 "$moddir/parse-nbdroot.sh"
> +inst_hook netroot 90 "$moddir/nbd-netroot.sh"
> +inst "$moddir/nbdroot" "/sbin/nbdroot"
> +instmods nbd
> diff --git a/modules.d/95nbd/nbd-netroot.sh b/modules.d/95nbd/nbd-netroot.sh
> new file mode 100755
> index 0000000..74b3da8
> --- /dev/null
> +++ b/modules.d/95nbd/nbd-netroot.sh
> @@ -0,0 +1,11 @@
> +#!/bin/sh # for highlighting
> +
> +if [ "$root" = "dhcp" ]; then
> +    if [ -n "$new_root_path" -a -z "${new_root_path%%nbd:*}" ]; then
> +	root="$new_root_path"
> +    fi
> +fi
> +
> +if [ -z "${root%nbd:*}" ]; then
> +    handler=/sbin/nbdroot
> +fi
> diff --git a/modules.d/95nbd/nbdroot b/modules.d/95nbd/nbdroot
> new file mode 100755
> index 0000000..51120c2
> --- /dev/null
> +++ b/modules.d/95nbd/nbdroot
> @@ -0,0 +1,96 @@
> +#!/bin/sh
> +
> +. /lib/dracut-lib
> +
> +PATH=$PATH:/sbin:/usr/sbin
> +
> +# XXX needs error handling like ifup/dhclient-script
> +
> +if getarg rdnetdebug; then
> +    exec > /tmp/nbdroot.$1.$$.out
> +    exec 2>> /tmp/nbdroot.$1.$$.out
> +    set -x
> +fi
> +
> +# root is in the form root=nbd:server:port:fstype:fsopts:nbdopts
> +netif="$1"
> +root="$2"
> +
> +root=${root#nbd:}
> +nbdserver=${root%%:*}; root=${root#*:}
> +nbdport=${root%%:*}; root=${root#*:}
> +nbdfstype=${root%%:*}; root=${root#*:}
> +nbdflags=${root%%:*}
> +nbdopts=${root#*:}
> +
> +if [ "$nbdopts" = "$nbdflags" ]; then
> +    unset nbdopts
> +fi
> +if [ "$nbdflags" = "$nbdfstype" ]; then
> +    unset nbdflags
> +fi
> +if [ "$nbdfstype" = "$nbdport" ]; then
> +    unset nbdfstype
> +fi
> +if [ -z "$nbdfstype" ]; then
> +    nbdfstype=auto
> +fi
> +
> +# look through the NBD options and pull out the ones that need to
> +# go before the host etc. Append a ',' so we know we terminate the loop
> +nbdopts=${nbdopts},
> +while [ -n "$nbdopts" ]; do
> +    f=${nbdopts%%,*}
> +    nbdopts=${nbdopts#*,}
> +    if [ -z "$f" ]; then
> +        break
> +    fi
> +    if [ -z "${f%bs=*}" -o -z "${f%timeout=*}" ]; then
> +        preopts="$preopts $f"
> +        continue
> +    fi
> +    opts="$opts $f"
> +done
> +
> +# look through the flags and see if any are overridden by the command line
> +nbdflags=${nbdflags},
> +while [ -n "$nbdflags" ]; do
> +    f=${nbdflags%%,*}
> +    nbdflags=${nbdflags#*,}
> +    if [ -z "$f" ]; then
> +        break
> +    fi
> +    if [ "$f" = "ro" -o "$f" = "rw" ]; then
> +        nbdrw=$f
> +        continue
> +    fi
> +    fsopts=${fsopts+$fsopts,}$f
> +done
> +
> +getarg ro && nbdrw=ro
> +getarg rw && nbdrw=rw
> +fsopts=${fsopts+$fsopts,}${nbdrw}
> +
> +modprobe nbd || exit 1
> +
> +# XXX better way to wait for the device to be made?
> +i=0
> +while [ ! -b /dev/nbd0 ]; do
> +    [ $i -ge 20 ] && exit 1
> +    sleep 0.1
> +    i=$(( $i + 1))
> +done
> +
> +# XXX netroot expects to have the handler mount things, but we should
> +# XXX allow LVM, LUKS, etc over nbd
> +
> +nbd-client $preopts "$nbdserver" "$nbdport" /dev/nbd0 $opts || exit 1

Ah, but we are not really a netroot in the sense that NFS is -- all we
are doing is attaching a block device.  Once it is attached the usual
root-on-block-device rules should kick in as soon as udev sees the block
devices.

> +if ! mount -t $nbdfstype -o$fsopts /dev/nbd0 $NEWROOT; then
> +    # Mount failed, clean up after ourselves so if we try a different
> +    # interface it can succeed
> +    nbd-client -d /dev/nbd0
> +    exit 1
> +fi

why not just poke udev with udevadm trigger if there is any doubt?

> +exit 0
> diff --git a/modules.d/95nbd/parse-nbdroot.sh b/modules.d/95nbd/parse-nbdroot.sh
> new file mode 100755
> index 0000000..4bedaab
> --- /dev/null
> +++ b/modules.d/95nbd/parse-nbdroot.sh
> @@ -0,0 +1,49 @@
> +#!/bin/dash
> +
> +# It'd be nice if this could share rules with 99-block.sh, but since
> +# the kernel side adds nbd{1..16} when the module is loaded -- before
> +# they are associated with a server -- we cannot use the udev add rule
> +# to find it
> +#
> +# XXX actually we could, if we move to root=XXX and netroot=XXX, then
> +# you could do root=LABEL=/ nbdroot=XXX, or netroot=nbd:XXX
> +#
> +# However, we need to be 90-nbd.sh to catch root=/dev/nbd*
> +#
> +# Preferred format:
> +#	root=nbd:srv:port[:fstype[:rootflags[:nbdopts]]]
> +#
> +# nbdopts is a comma seperated list of options to give to nbd-client
> +#
> +#
> +# Legacy formats:
> +#	nbdroot=srv,port
> +#	nbdroot=srv:port[:fstype[:rootflags[:nbdopts]]]
> +#	root=dhcp nbdroot=srv:port[:fstype[:rootflags[:nbdopts]]]
> +#	root=nbd nbdroot=srv:port[:fstype[:rootflags[:nbdopts]]]
> +#
> +
> +case "$root" in
> +    nbd|dhcp|'')
> +	if getarg nbdroot= > /dev/null; then
> +	    root=nbd:$(getarg nbdroot=)
> +	fi
> +	;;
> +esac
> +
> +# Convert the Debian style to our syntax, but avoid matches on fs arguments
> +case "$root" in
> +    nbd:*,*)
> +	if check_occurances "$root" ',' 1 && check_occurances "$root" ':' 1;
> +	then
> +	    root=${root%*,}:${root#*,}
> +	fi
> +	;;
> +esac
> +
> +if [ "${root%%:*}" = "nbd" ]; then
> +    # XXX validate options here?
> +    # XXX generate udev rules?
> +    rootok=1
> +    netroot=nbd
> +fi
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
