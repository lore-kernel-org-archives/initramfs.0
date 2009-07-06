From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [RFC ONLY 3/5] netroot: remove netif from handler invocation
Date: Mon, 6 Jul 2009 15:56:33 +0200
Message-ID: <4A520291.7010203@bfh.ch>
References: <cover.1246656269.git.dave@thedillows.org> <44494af931ad839908cb4542f7c35ae59a4ef65e.1246656269.git.dave@thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <44494af931ad839908cb4542f7c35ae59a4ef65e.1246656269.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

David Dillow wrote:
> Now that netroot is serialized and only one interface can be configured
> at a time, netif is almost completely unneeded by the netroot handlers.
> The remaining hold out is nfsroot, which uses it to get the command line
> overrides and the DHCP root information.

Loosing arguments is always good.

The only thing I don't like about this is that netroot needs to
implement a few specialities just for NFS. I'd prefer netroot to be
(mount-)protocol independent. 

On the other hand, I like the idea that network root handlers shouldn't
care a thing about network configuration and options.

Question: Is it possible that other netroot handlers we haven't
implemented or thought about might need to know about interfaces?

Discussion: Instead of implementing the dhcp options server failover
just for nfs, why not extend this to all protocols?

> 
> By adding that information to the calling convention, we can get rid
> of netif, and prepare for the next steps of moving parsing and validation
> into the handlers themselves.
> ---
>  modules.d/40network/netroot |   16 ++++++++++------
>  modules.d/95iscsi/iscsiroot |    7 +++----
>  modules.d/95nbd/nbdroot     |    9 ++++-----
>  modules.d/95nfs/nfsroot     |   20 ++++++++------------
>  4 files changed, 25 insertions(+), 27 deletions(-)
> 
> diff --git a/modules.d/40network/netroot b/modules.d/40network/netroot
> index 645bbba..c9ebf4c 100755
> --- a/modules.d/40network/netroot
> +++ b/modules.d/40network/netroot
> @@ -44,15 +44,20 @@ done
>  netif=$1
>  [ -e "/tmp/net.bootdev" ] && read netif < /tmp/net.bootdev
>  
> +# Load command line overrides to get the server override
> +[ -e /tmp/net.$netif.override ] && . /tmp/net.$netif.override
> +[ -n "$srv" ] && server_id=$srv
> +
> +# Load dhcp options and get the first fallback to the server
> +[ -e /tmp/dhclient.$netif.dhcpopts ] && . /tmp/dhclient.$netif.dhcpopts
> +[ -z "$server_id" ] && server_id=$new_dhcp_server_identifier
> +
>  # Figure out the handler for root=dhcp by recalling all netroot cmdline 
>  # handlers
>  if [ "$netroot" = "dhcp" ] ; then
>      # Unset root so we can check later
>      unset root
>  
> -    # Load dhcp options
> -    [ -e /tmp/dhclient.$netif.dhcpopts ] && . /tmp/dhclient.$netif.dhcpopts
> -
>      # If we have a specific bootdev with no dhcpoptions or empty root-path, 
>      # we die. Otherwise we just warn
>      if [ -z "$new_root_path" ] ; then
> @@ -92,9 +97,8 @@ done
>  [ -e /tmp/net.$netif.hostname ]    && . /tmp/net.$netif.hostname
>  [ -e /tmp/net.$netif.resolv.conf ] && cp -f /tmp/net.$netif.resolv.conf /etc/resolv.conf
>  
> -# Run the handler; don't store the root, it may change from device to device
> -# XXX other variables to export?
> -if $handler $netif $netroot $NEWROOT; then
> +# Run the handler to mount/login into the root device
> +if $handler "$netroot" "$server_id" "$new_root_path" $NEWROOT; then
>      # Network rootfs mount successful
>      for iface in $IFACES ; do
>  	[ -f /tmp/dhclient.$iface.lease ] &&    cp /tmp/dhclient.$iface.lease    /tmp/net.$iface.lease
> diff --git a/modules.d/95iscsi/iscsiroot b/modules.d/95iscsi/iscsiroot
> index 2b041cc..923141c 100755
> --- a/modules.d/95iscsi/iscsiroot
> +++ b/modules.d/95iscsi/iscsiroot
> @@ -11,14 +11,13 @@
>  PATH=$PATH:/sbin:/usr/sbin
>  
>  if getarg rdnetdebug; then
> -    exec > /tmp/iscsiroot.$1.$$.out
> -    exec 2>> /tmp/iscsiroot.$1.$$.out
> +    exec > /tmp/iscsiroot.$$.out
> +    exec 2>> /tmp/iscsiroot.$$.out
>      set -x
>  fi

Maybe this is just me nagging around, but do the changes above have
anything to do with removing netif?

>  
>  # root is in the form root=iscsi:[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>
> -netif="$1"
> -root="$2"
> +root="$1"
>  
>  # read static conf settings
>  for conf in conf/conf.d/*; do
> diff --git a/modules.d/95nbd/nbdroot b/modules.d/95nbd/nbdroot
> index c7f24e8..f76211c 100755
> --- a/modules.d/95nbd/nbdroot
> +++ b/modules.d/95nbd/nbdroot
> @@ -5,15 +5,14 @@
>  PATH=$PATH:/sbin:/usr/sbin
>  
>  if getarg rdnetdebug; then
> -    exec > /tmp/nbdroot.$1.$$.out
> -    exec 2>> /tmp/nbdroot.$1.$$.out
> +    exec > /tmp/nbdroot.$$.out
> +    exec 2>> /tmp/nbdroot.$$.out
>      set -x
>  fi

Same here, is this netif related?

>  
>  # root is in the form root=nbd:srv:port[:fstype[:rootflags[:nbdopts]]]
> -netif="$1"
> -root="$2"
> -NEWROOT="$3"
> +root="$1"
> +NEWROOT="$4"
>  
>  # If it's not nbd we don't continue
>  [ "${root%%:*}" = "nbd" ] || return
> diff --git a/modules.d/95nfs/nfsroot b/modules.d/95nfs/nfsroot
> index f005378..847ec60 100755
> --- a/modules.d/95nfs/nfsroot
> +++ b/modules.d/95nfs/nfsroot
> @@ -43,16 +43,17 @@ root_to_var() {
>  PATH=$PATH:/sbin:/usr/sbin
>  
>  if getarg rdnetdebug ; then 
> -    exec > /tmp/nfsroot.$1.$$.out
> -    exec 2>> /tmp/nfsroot.$1.$$.out
> +    exec > /tmp/nfsroot.$$.out
> +    exec 2>> /tmp/nfsroot.$$.out
>      set -x
>  fi

And another one here. Is this Netif removal related?

>  
>  # root is in the form root=nfs[4]:[server:]path[:options], either from
>  # cmdline or dhcp root-path
> -netif="$1"
> -root="$2"
> -NEWROOT="$3"
> +root="$1"
> +server_id=$2
> +root_path=$3
> +NEWROOT="$4"
>  
>  # Continue if nfs prefix
>  case "${root%%:*}" in
> @@ -62,20 +63,15 @@ esac
>  
>  root_to_var $root
>  
> -#Load other data that might provide info
> -[ -f /tmp/net.$netif.override ] && . /tmp/net.$netif.override
> -[ -f /tmp/dhclient.$netif.dhcpopts ] && . /tmp/dhclient.$netif.dhcpopts
> -
>  #Empty path means try dhcp root-path, this is ok here since parse-nfsroot.sh
>  #already takes care of nfs:... formatted root-path
> -[ -z "$path" ] && root_to_var $nfs:$new_root_path
> +[ -z "$path" ] && root_to_var $nfs:$root_path
>  
>  #Empty path defaults to "/tftpboot/%s" only in nfsroot.txt legacy mode
>  [ -z "$path" ] && [ "$(getarg root=)" = "/dev/nfs" ] && path="/tftpboot/%s"
>  
>  if [ -z "$server" ] ; then
> -    # XXX new_dhcp_next_server is unconfirmed this is an assumption
> -    for var in $srv $new_dhcp_server_identifier $new_dhcp_next_server $new_root_path '' ; do
> +    for var in $server_id $root_path '' ; do
>  	[ -n "$var" ] && server=$var && break;
>      done
>  
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
