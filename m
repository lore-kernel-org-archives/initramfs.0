From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/5] Even more dracut cleanups
Date: Wed, 11 Feb 2009 15:42:05 -0800 (PST)
Message-ID: <f7b2ee4fd7b9ce42b2a4469c006c100bbe3bbd5c.1234395178.git.victor.lowther@gmail.com>
References: <255e595fd4f868ab0f6e085deb0bfd4a2afc8ae7.1234395178.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=y1MQejfNg7PbEGIU7aW6v1mUhnaBssSrDhKZQMPaOeQ=;
        b=Ab/N7nthvmgV3CnscFVhcb5htKMuzfbdIboCj7Gb1rpOGB1J5nhpEkFAv2+XcMdtWE
         5Yp+A3A04L6Z1YpYwBBpaaosIOoRyYwnI6DXDWBjXv4+MaawwEyaiT1lwLb3QDIJRJFS
         Mn3+l9xTD+ADR188avsbrcVpbo4AJ+y2otTtc=
In-Reply-To: <255e595fd4f868ab0f6e085deb0bfd4a2afc8ae7.1234395178.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Use ldd to find shared library deps.

This replaces the eu-readelf and ld-linux.so.2 hackery.

As a bonus it will keep working if someone (for some bizzare reason) 
needs to load a non-elf executable or shared library on the initrd.
---
 dracut-functions |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 8beba8b..62038f6 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -66,16 +66,10 @@ inst_binary() {
     local bin="$1" target="${2:-$1}"
     local LDSO NAME IO FILE ADDR I1 n f TLIBDIR
     [[ -f $initdir$target ]] && return 0
-
-    LDSO=$(LANG=C eu-readelf -l $bin 2>/dev/null | \
-	awk '/interpreter/ {print $4}' |sed -e 's/]$//')
-    [[ $LDSO && $LDSO != $bin ]] || LDSO="$IF_RTLD"
-    [[ $LDSO && $LDSO != $bin ]] || return 1
-    [[ $IF_RTLD ]] || IF_RTLD="$LDSO"
-
     # I love bash!
-    while read NAME I0 FILE ADDR I1 ; do
-	[[ $FILE = $bin ]] && continue 
+    while read line; do
+	[[ $line =~ '([^ ]*/lib/[^ ]*\.so[^ ]*)' ]] || continue
+	FILE=${BASH_REMATCH[1]}
         [[ $FILE = not || $NAME = not ]] && {
 	    echo "Missing a shared library required by $bin." >&2
 	    echo "dracut cannot create an initrd." >&2
@@ -96,8 +90,7 @@ inst_binary() {
 	    continue
 	}
         inst_library "$FILE" 
-    done < <(LD_TRACE_PRELINKING=1 LD_WARN= LD_TRACE_LOADED_OBJECTS=1 \
-            $LDSO $bin 2>/dev/null)
+    done < <(ldd $bin 2>/dev/null)
     inst_simple "$bin" "$target"
 }
 
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
