From: Tobias Geerinckx <tobias.geerinckx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] lsinitrd.sh: don't choke on LZO-compressed images
Date: Tue,  3 Jun 2014 04:59:34 +0200
Message-ID: <1401764374-17744-1-git-send-email-tobias.geerinckx@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=KtL+586h3uV4liUpf8Ow+pacM3JdeqPfLFn98C9H6Jo=;
        b=xXXZcfzvHavlWi5PJASX+9C7kNuPzKZJ6FRney11+acyQum0wUvSY0oCvZnmHY9WEG
         Hy1/4nimLZxFKg6g7jeAbMSF6G89pI8Z2Ek5CLJDOwhoxaC+KJZu7dR0BSjeJyUNJ/xB
         4fng/wkgPZnmUaBTt8Ag6HiqhDtLZ/obemYe4ysKTUQwpCg6JgqxWlG/q6IbEndZxeLQ
         tdKOvYFLYloILnv49xyFqCy5BdzqrNW+N5LLJ5036WO4+JEgL5zvFBh+7qXgS5OFW3oK
         00O2QBQFq/KlJGdqBZpn6cwtsMMzeUWQP/aJhh9VzDiNFnG0n6QPdMjHEv9+AIAL/69F
         602w==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tobias Geerinckx <tobias.geerinckx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

lsinitrd (and hence dracut) currently fail to list the contents of any
LZO-compressed image, and merely spit out misleading xzcat errors.

I guess no-one actually uses them.
---
 lsinitrd.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lsinitrd.sh b/lsinitrd.sh
index a697bc2..4ba8752 100755
--- a/lsinitrd.sh
+++ b/lsinitrd.sh
@@ -180,6 +180,9 @@ CAT=$({
             $'\x02\x21'*)
                 echo "lz4 -d -c"
                 ;;
+            $'\x89'LZO$'\0'*)
+                echo "lzop -d -c"
+                ;;
             *)
                 if echo "test"|xz|xzcat --single-stream >/dev/null 2>&1; then
                     echo "xzcat --single-stream --"
-- 
2.0.0
