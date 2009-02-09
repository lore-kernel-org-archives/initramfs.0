From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 10/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:35:20 -0800 (PST)
Message-ID: <b2a3c4c007df34baf45eef6600f03d7c6b3a724c.1234137268.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=OngWylm+FiV6GnkMH/Atmb93Nkc/VNJfvXkjJYamlAE=;
        b=M2oxyLaLxOqtvzbhVKnPlITDWFLEhOuex7IZv+1/1YjDjYD7jEp9qyo8EIovjWya/D
         aGlgTlVXSG2nL60WesFbI/XAeanHwp+EP7VFZyS7ziDJqfMUXSZcZbzyBbJ9B31icsAe
         Q5deiGrmZELV3fk9fvx1GFWOohYRaD9W4v4+s=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Clean up initialization in dracut.

The source keyword is deprecated, and kernel / outfile are more legible as
conditional lists.
---
 dracut |   19 ++++++-------------
 1 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/dracut b/dracut
index 82cf9e5..bd592d0 100755
--- a/dracut
+++ b/dracut
@@ -23,29 +23,22 @@ while (($# > 0)); do
     shift
 done
 
-if [ -n "$2" ]; then
-    kernel=$2
-else
-    kernel=$(uname -r)
-fi
-if [ -n "$1" ]; then
-    outfile=$(readlink -f $1)
-else
+[[ $2 ]] && kernel=$2 || kernel=$(uname -r)
+[[ $1 ]] && outfile=$(readlink -f $1) || \
     outfile="/boot/initrd-$kernel.img"
-fi
 
-if [ -f "$outfile" -a  -z "$force" ]; then
+if [[ -f $outfile && ! $force ]]; then
     echo "Will not override existing initramfs ($outfile) without --force"
     exit 1
 fi
 
-if [ -n "$allowlocal" -a -f ./init ]; then
-    source ./dracut-functions
+if [[ $allowlocal && -f ./init ]]; then
+    . ./dracut-functions
     initfile=./init
     switchroot=./switch_root
     rulesdir=./rules.d
 else
-    source /usr/libexec/dracut/functions
+    . /usr/libexec/dracut/functions
     initfile=/usr/libexec/dracut/init
     switchroot=/usr/libexec/dracut/switch_root
     rulesdir=/usr/libexec/dracut/rules.d
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
