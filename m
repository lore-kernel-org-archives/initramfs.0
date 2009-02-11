From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 5/5] Even more dracut cleanups
Date: Wed, 11 Feb 2009 15:42:14 -0800 (PST)
Message-ID: <305b7888771cf55840ae96b808cb2c867764b71a.1234395178.git.victor.lowther@gmail.com>
References: <255e595fd4f868ab0f6e085deb0bfd4a2afc8ae7.1234395178.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=/VBpvv0+8evmHv/jclUjE82JGt3DzRb7w9048y8kkpE=;
        b=rlBzVtQ1zyTUTGHjtZpuigI9WCRkogvXRrrcUj7QIOFllhSuI09pK0AND3RBFwka2F
         /RjmTuA2/g8Xbfq9jdPKzAT343FQk38XRJDo03IDN+z0LGPNijmn1WLvUbe6SsZ3uaB5
         WIzwtMlP88/jH0gwwDtrs5QvKKm+I7NNBpIEE=
In-Reply-To: <255e595fd4f868ab0f6e085deb0bfd4a2afc8ae7.1234395178.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Really die if a library is not found.

Also explain how to find out what the missing library is.
---
 dracut-functions |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 62038f6..e80d786 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -68,10 +68,11 @@ inst_binary() {
     [[ -f $initdir$target ]] && return 0
     # I love bash!
     while read line; do
-	[[ $line =~ '([^ ]*/lib/[^ ]*\.so[^ ]*)' ]] || continue
+	[[ $line =~ '([^ ]*/lib/[^ ]*\.so[^ ]*|not found)' ]] || continue
 	FILE=${BASH_REMATCH[1]}
-        [[ $FILE = not || $NAME = not ]] && {
+        [[ $FILE = 'not found' ]] && {
 	    echo "Missing a shared library required by $bin." >&2
+	    echo "Run \"ldd $bin\" to find out what it is." >&2
 	    echo "dracut cannot create an initrd." >&2
 	    exit 1
 	}
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
