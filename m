From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] ifcfg: write DNS1=... for nameserver= args (RHBZ#815369)
Date: Tue, 24 Apr 2012 12:45:23 +0200
Message-ID: <4F968443.8020403@redhat.com>
References: <1335212725-20178-1-git-send-email-wwoods@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1335212725-20178-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 23.04.2012 22:25, schrieb Will Woods:
> If you're using a static network config, you'll want to keep your
> nameservers around when NM starts. Write DNS1 (and DNS2, DNS3, etc..)
> into the ifcfg file.
> 
> Thanks to Mark Hamzy <hamzy-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org> for the patch.
> ---
>  modules.d/45ifcfg/write-ifcfg.sh |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/modules.d/45ifcfg/write-ifcfg.sh b/modules.d/45ifcfg/write-ifcfg.sh
> index c072a13..3e1d89b 100755
> --- a/modules.d/45ifcfg/write-ifcfg.sh
> +++ b/modules.d/45ifcfg/write-ifcfg.sh
> @@ -53,6 +53,14 @@ for netif in $IFACES ; do
>              echo "NETMASK=$mask"
>              [ -n "$gw" ] && echo "GATEWAY=$gw"
>          fi
> +        namesrv=$(getargs nameserver)
> +        if [ -n "$namesrv" ]; then
> +            i=1
> +            for n in $namesrv; do
> +                echo DNS$i=$n
> +                i=$(($i+1))
> +            done
> +        fi
>      } > /tmp/ifcfg/ifcfg-$netif
>  
>      # bridge needs different things written to ifcfg

Hmm, I have this in my queue (different location):

diff --git a/modules.d/45ifcfg/write-ifcfg.sh b/modules.d/45ifcfg/write-ifcfg.sh
index c072a13..b81ac39 100755
--- a/modules.d/45ifcfg/write-ifcfg.sh
+++ b/modules.d/45ifcfg/write-ifcfg.sh
@@ -138,6 +138,11 @@ for netif in $IFACES ; do
             } >> /tmp/ifcfg/ifcfg-$ethname
         fi
     fi
+    i=1
+    for ns in $(getargs nameserver); do
+        echo "DNS${i}=${ns}" >> /tmp/ifcfg/ifcfg-$netif
+        i=$((i+1))
+    done
 done

 # Pass network opts
