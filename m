From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: NFS cleaned up, one TODO
Date: Wed, 1 Jul 2009 18:04:11 +0200
Message-ID: <4A4B88FB.1030605@bfh.ch>
References: <4A4A923E.5020406@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A4A923E.5020406-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Warren Togami wrote:
> The following are now the valid syntaxes for NFS.
> 
> root=[<server-ip>:]<root-dir>[:<nfs-options>]
> root=nfs:[<server-ip>:]<root-dir>[:<nfs-options>]
> root=nfs4:[<server-ip>:]<root-dir>[:<nfs-options>]
> root=dhcp
>     root-path=<server-ip>:<root-dir>[,<nfs-options>]
>     root-path=nfs:<server-ip>:<root-dir>[,<nfs-options>]
>     root-path=nfs4:<server-ip>:<root-dir>[,<nfs-options>]
> root=/dev/nfs [nfsroot=...]
> 
> TODO:
> I managed to fix the root=/dev/nfs case that specifies nfsroot=, but I 
> don't understand why it doesn't work if you lack nfsroot=.  Two NFS 
> tests are commenteed out until that is fixed.  Any ideas?

The Problem is here:

# LEGACY convert root=<server-ip>:/<path
case "$netroot" in
    [0-9]*:/*|[0-9]*\.[0-9]*\.[0-9]*[!:]|/*)
       netroot=nfs:$netroot;;
esac

After this part netroot looks like "netroot=nfs:/dev/nfs" if
root=/dev/nfs. This is later interpreted as path.

Patch below fixes this.

diff --git a/modules.d/95nfs/parse-nfsroot.sh b/modules.d/95nfs/parse-nfsroot.sh
index f05fb2a..9e41335 100755
--- a/modules.d/95nfs/parse-nfsroot.sh
+++ b/modules.d/95nfs/parse-nfsroot.sh
@@ -95,6 +95,7 @@ fi
 
 # LEGACY convert root=<server-ip>:/<path
 case "$netroot" in
+    /dev/nfs) netroot=nfs;;
     [0-9]*:/*|[0-9]*\.[0-9]*\.[0-9]*[!:]|/*)
        netroot=nfs:$netroot;;
 esac
diff --git a/test/TEST-20-NFS/test.sh b/test/TEST-20-NFS/test.sh



 /dev/nfs)netroot=nfs;; 




> 
> Warren Togami
> wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
