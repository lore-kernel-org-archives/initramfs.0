From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Get rid of cat and grep
Date: Fri, 5 Jun 2009 11:20:42 -0500
Message-ID: <8E821C8B-E7E8-4F71-ACCF-872B463AE3FF@gmail.com>
References: <4A2907E7.1080008@bfh.ch>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=HD2iir3tnVG9JrmIcqv2Iouh0k8BN2xHKd9oMDYk2kk=;
        b=usVjXJEt5Stfmmaabe0zF6Yv+F4zE9iMrS8WqtSwmqbspQacZ2VSPJNI6VxNcvZFZZ
         CvT9CpHApx/tGyMJBnIiKryJbJkAcAUooxfIrBDZzMuULzJssCWZw0/a86APovdATDKv
         39H1PLwna/3w1wJLjuF7kLTg940uOeYV7TGrI=
In-Reply-To: <4A2907E7.1080008-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Why not just reimplement cat in sed?

cat() {
     for x in "$@"; do
         sed s/,/,/ < "$1"
     done
}

On Jun 5, 2009, at 6:56 AM, Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>  
wrote:

> cat and grep just bloat the initrd, this patch removes dependencies  
> on them.
>
> ---
> modules.d/40network/ifup             |    3 ++-
> modules.d/40network/install          |    2 +-
> modules.d/40network/kill-dhclient.sh |    4 +++-
> modules.d/95nbd/nbdroot              |   12 +-----------
> modules.d/95nfs/nfsroot              |   12 ++----------
> modules.d/95nfs/nfsroot-cleanup.sh   |    2 +-
> modules.d/99base/dracut-lib          |   14 ++++++++++++++
> 7 files changed, 24 insertions(+), 25 deletions(-)
>
> diff --git a/modules.d/40network/ifup b/modules.d/40network/ifup
> index 981a207..e347da5 100755
> --- a/modules.d/40network/ifup
> +++ b/modules.d/40network/ifup
> @@ -100,7 +100,8 @@ if [ -z "$ip" ]; then
>    do_dhcp;
> else
>    # spin through the kernel command line, looking for ip= lines
> -    for p in $(cat /proc/cmdline); do
> +    [ "$CMDLINE" ] || read CMDLINE </proc/cmdline;
> +    for p in $CMDLINE; do
>    [ -n "${p%ip=*}" ] && continue
>    ip_to_var ${p#ip=}
>
> diff --git a/modules.d/40network/install b/modules.d/40network/install
> index d480391..3a06f79 100755
> --- a/modules.d/40network/install
> +++ b/modules.d/40network/install
> @@ -1,5 +1,5 @@
> #!/bin/bash
> -dracut_install ip dhclient hostname cat
> +dracut_install ip dhclient hostname
> # Include wired net drivers, excluding wireless
> for modname in `find "/lib/modules/$kernel/kernel/drivers" -name  
> '*.ko'`; do
>  if nm -uPA $modname | grep -q eth_type_trans; then
> diff --git a/modules.d/40network/kill-dhclient.sh b/modules.d/ 
> 40network/kill-dhclient.sh
> index fcebd32..54b3344 100755
> --- a/modules.d/40network/kill-dhclient.sh
> +++ b/modules.d/40network/kill-dhclient.sh
> @@ -1,5 +1,7 @@
> #!/bin/sh
> for f in /tmp/dhclient.*.pid; do
> -    [ -e $f ] && kill $(cat $f)
> +    [ -e $f ] || continue
> +    read PID < $f;
> +    kill $PID;
> done
> diff --git a/modules.d/95nbd/nbdroot b/modules.d/95nbd/nbdroot
> index 1130cca..3475239 100755
> --- a/modules.d/95nbd/nbdroot
> +++ b/modules.d/95nbd/nbdroot
> @@ -71,17 +71,7 @@ getarg ro && nbdrw=ro
> getarg rw && nbdrw=rw
> fsopts=${fsopts+$fsopts,}${nbdrw}
> -if [ ! -e /tmp/nbd.present ]; then
> -    cat /proc/devices | while read t1 devt; do
> -    if [ "$devt" = "nbd" ]; then
> -        >/tmp/nfs.present
> -        break
> -    fi
> -    done
> -fi
> -if [ ! -e /tmp/nbd.present ]; then
> -    modprobe nbd || exit 1
> -fi
> +incol2 /proc/devices nbd || modprobe nbd || exit 1
> # XXX better way to wait for the device to be made?
> i=0
> diff --git a/modules.d/95nfs/nfsroot b/modules.d/95nfs/nfsroot
> index 2d08b68..da002c5 100755
> --- a/modules.d/95nfs/nfsroot
> +++ b/modules.d/95nfs/nfsroot
> @@ -46,16 +46,8 @@ getarg rw && nfsrw=rw
> nfsflags=${nfsflags+$nfsflags,}${nfsrw}
> # Load the modules so the filesystem type is there
> -if [ ! -e /tmp/nfs.present ]; then
> -    cat /proc/filesystems | while read t1 fst; do
> -        case "$fst" in
> -        nfs|nfs4) >/tmp/nfs.present; break ;;
> -    esac
> -    done
> -fi
> -if [ ! -e /tmp/nfs.present ]; then
> -    modprobe nfs || exit 1
> -fi
> +incol2 /proc/filesystems nfs  || modprobe nfs || exit 1
> +incol2 /proc/filesystems nfs4 || modprobe nfs || exit 1
> # XXX don't forget to move /var/lib/nfs/rpc_pipefs to new /
> diff --git a/modules.d/95nfs/nfsroot-cleanup.sh b/modules.d/95nfs/ 
> nfsroot-cleanup.sh
> index 4bfdd34..1a5f187 100644
> --- a/modules.d/95nfs/nfsroot-cleanup.sh
> +++ b/modules.d/95nfs/nfsroot-cleanup.sh
> @@ -4,7 +4,7 @@ pid=$(pidof rpc.statd)
> pid=$(pidof rpcbind)
> [ -n "$pid" ] && kill $pid
> -if grep -q rpc_pipefs /proc/mounts; then +if incol2 /proc/mounts / 
> var/lib/nfs/rpc_pipefs; then     # try to create the destination  
> directory
>    [ -d $NEWROOT/var/lib/nfs/rpc_pipefs ] || mkdir -p $NEWROOT/var/ 
> lib/nfs/rpc_pipefs 2>/dev/null
> diff --git a/modules.d/99base/dracut-lib b/modules.d/99base/dracut-lib
> index e3f4794..07c1bc7 100644
> --- a/modules.d/99base/dracut-lib
> +++ b/modules.d/99base/dracut-lib
> @@ -36,3 +36,17 @@ check_occurances() {
>    [ $count -eq $expected ]
> }
> +
> +incol2() {
> +    local dummy check;
> +    local file="$1";
> +    local str="$2";
> +
> +    [ -z "$file" ] && return;
> +    [ -z "$str"  ] && return;
> +
> +    while read dummy check ; do
> +    [ "$check" = "$str" ] && return 0
> +    done < $file
> +    return 1
> +}
>
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs"  
> in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
