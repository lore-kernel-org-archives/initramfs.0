From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut-026: lsinitrd doesn't work with provided image
Date: Tue, 12 Mar 2013 15:54:24 +0800
Message-ID: <513EDF30.7090408@redhat.com>
References: <CAKzfqkfwg_tW70VJbmgKg-Vs3O2DWLX36o0bMZhYvTL9U9QCRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKzfqkfwg_tW70VJbmgKg-Vs3O2DWLX36o0bMZhYvTL9U9QCRQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Wim Muskee <wimmuskee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 03/12/2013 02:53 AM, Wim Muskee wrote:
> hi,
> 
> In dracut-026:
> # dracut /boot/initramfs-dracut-x86_64-3.3.8-gentoo 3.3.8-gentoo
> # lsinitrd /boot/initramfs-dracut-x86_64-3.3.8-gentoo
> 
> No <initramfs file> specified and the default image
> '/boot/initramfs-3.2.1-gentoo-r2.img}' cannot be accessed!
> 
> Usage: lsinitrd [-s] [<initramfs file> [<filename>]]
> 
> Looking at the lsinitrd, the provided image seems to be always
> overwritten after it has been set from $1.
> 

The machine-id section should only be run in case without $1 as image name.
Is below fix works for you?

diff --git a/lsinitrd.sh b/lsinitrd.sh
index 7a09423..fe723f7 100755
--- a/lsinitrd.sh
+++ b/lsinitrd.sh
@@ -54,23 +54,23 @@ if [[ "$1" ]]; then
         usage
         exit 1
     fi
-fi
-
-[[ -f /etc/machine-id ]] && read MACHINE_ID < /etc/machine-id
-
-if [[ $MACHINE_ID ]] && ( [[ -d /boot/${MACHINE_ID} ]] || [[ -L /boot/${MACHINE_ID} ]] ); then
-    image="/boot/${MACHINE_ID}/${KERNEL_VERSION}/initrd"
 else
-    image="/boot/initramfs-${KERNEL_VERSION}.img}"
-fi
+    [[ -f /etc/machine-id ]] && read MACHINE_ID < /etc/machine-id
 
-if ! [[ -f "$image" ]]; then
-    {
+    if [[ $MACHINE_ID ]] && ( [[ -d /boot/${MACHINE_ID} ]] || [[ -L /boot/${MACHINE_ID} ]] ); then
+        image="/boot/${MACHINE_ID}/${KERNEL_VERSION}/initrd"
+    else
+        image="/boot/initramfs-${KERNEL_VERSION}.img}"
+    fi
+
+    if ! [[ -f "$image" ]]; then
+        {
         echo "No <initramfs file> specified and the default image '$image' cannot be accessed!"
         echo
-    } >&2
-    usage
-    exit 1
+        } >&2
+        usage
+        exit 1
+    fi
 fi
 
 CAT=zcat
