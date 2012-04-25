From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dracut does not mount iscsi targets specified using --mount option
Date: Wed, 25 Apr 2012 11:26:15 +0200
Message-ID: <4F97C337.8040604@gmail.com>
References: <20120418222829.GG2224@redhat.com> <4F8FD3E5.90103@redhat.com> <20120420135156.GE22419@redhat.com> <1335154319.18028.14.camel@cr0> <4F95076A.9060504@redhat.com> <1335167619.18028.35.camel@cr0> <4F9514E5.3010003@redhat.com> <20120423125449.GF8103@redhat.com> <1335237489.32756.8.camel@cr0> <20120424210224.GJ26708@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=WjpY/UpIZXJNbIGxiGRui18ODcjWPsSwbryjgGTjcsE=;
        b=muJes0DAbLq0ayIGJQ5Zj9oaeoSMKeCYS0xyY345dx1Z24hgJEOcZWUOio7HARuSZ8
         pI+cfQmb45C6bdPE6hK137cfjqONtKF1IQn4LbIRXGg/X9lCdS/tyPfnbtKZvyzB3hLg
         8ZiZAvjJ/evAmdNDqwSexQDvQW3PORTJyOaA24JhXHN8gD8fFd1MQTzo4oIZggtj2MJq
         +T0nsBdFRFwnhqq5aiy7JSP83q/iuRGrN9MiaEuro4HVqaquweTcEPk7K50LKpzm9U7G
         SuSAB1TBBLtuA5QF675E+tuf/CwBLNkZ06LxkmwgPhNZh8Nu4MN1ztQSqBPvQEVsde/6
         3QKw==
In-Reply-To: <20120424210224.GJ26708-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Am 24.04.2012 23:02, schrieb Vivek Goyal:
> Following is a small patch  which seems to fix the issue of dumping to
> multipath device for me. Is it this simple. Harald?
> 
> 
> ---
>  lib/dracut/modules.d/90multipath/module-setup.sh |   13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> Index: /lib/dracut/modules.d/90multipath/module-setup.sh
> ===================================================================
> --- .orig/lib/dracut/modules.d/90multipath/module-setup.sh	2012-04-16 10:03:27.000000000 -0400
> +++ /lib/dracut/modules.d/90multipath/module-setup.sh	2012-04-24 16:59:53.831999986 -0400
> @@ -17,11 +17,14 @@ check() {
>      }
>  
>      if [[ $hostonly ]]; then
> -        _rootdev=$(find_root_block_device)
> -        if [[ $_rootdev ]]; then
> -            check_block_and_slaves is_mpath "$_rootdev" && return 0
> -        fi
> -        return 1
> +	local _found
> +	local _dev
> +	for fs in ${host_fs_types[@]}; do
> +		_dev=$(echo $fs | awk -F '|' '{print $1}')
> +		is_mpath $(get_maj_min $_dev) && _found="1"
> +	done
> +	[[ $_found ]] || return 1
> +	unset _found
>      fi
>  
>      return 0
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


it can be even simpler:

diff --git a/modules.d/90multipath/module-setup.sh
b/modules.d/90multipath/module-setup.sh
index 2bc1b41..ae9ec59 100755
--- a/modules.d/90multipath/module-setup.sh
+++ b/modules.d/90multipath/module-setup.sh
@@ -11,18 +11,16 @@ check() {
     [[ $debug ]] && set -x

     is_mpath() {
-        [ -e /sys/dev/block/$1/dm/uuid ] || return 1
-        [[ $(cat /sys/dev/block/$1/dm/uuid) =~ ^mpath- ]] && return 0
+        local _dev
+        _dev=${1##/dev/}
+        [ -e /sys/dev/block/$_dev/dm/uuid ] || return 1
+        [[ $(cat /sys/dev/block/$_dev/dm/uuid) =~ ^mpath- ]] && return 0
         return 1
     }

-    if [[ $hostonly ]]; then
-        _rootdev=$(find_root_block_device)
-        if [[ $_rootdev ]]; then
-            check_block_and_slaves is_mpath "$_rootdev" && return 0
-        fi
-        return 1
-    fi
+    [[ $hostonly ]] || [[ $mount_needs ]] && {
+        for_each_host_dev_fs is_mpath || return 1
+    }

     return 0
 }

diff --git a/modules.d/95iscsi/module-setup.sh b/modules.d/95iscsi/module-setup.sh
index 2f343ee..34e101c 100755
--- a/modules.d/95iscsi/module-setup.sh
+++ b/modules.d/95iscsi/module-setup.sh
@@ -15,8 +15,11 @@ check() {
     [[ $debug ]] && set -x

     is_iscsi() (
-        [[ -L /sys/dev/block/$1 ]] || return
-        cd "$(readlink -f /sys/dev/block/$1)"
+        local _dev
+        _dev=${1##/dev/}
+
+        [[ -L /sys/dev/block/$_dev ]] || return
+        cd "$(readlink -f /sys/dev/block/$_dev)"
         until [[ -d sys || -d iscsi_session ]]; do
             cd ..
         done
@@ -24,14 +27,7 @@ check() {
     )

     [[ $hostonly ]] || [[ $mount_needs ]] && {
-        _rootdev=$(find_root_block_device)
-        if [[ $_rootdev ]]; then
-            # root lives on a block device, so we can be more precise about
-            # hostonly checking
-            check_block_and_slaves is_iscsi "$_rootdev" || return 1
-        else
-            return 1
-        fi
+        for_each_host_dev_fs is_iscsi || return 1
     }
     return 0
 }
