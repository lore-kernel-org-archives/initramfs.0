From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 6/5] Even more dracut functionality
Date: Wed, 11 Feb 2009 17:53:36 -0600
Message-ID: <1234396416.8898.1.camel@sentry-no.fnordovax.org>
References: <255e595fd4f868ab0f6e085deb0bfd4a2afc8ae7.1234395178.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:in-reply-to
         :references:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=Q7MwoYxZu3k/fgC0L0VI2khSEfuHlzhZspUDyyy4D6M=;
        b=CcF192uoYwA0HJRbYbEzGizEQs0ugA/l3Cmo/whTSbqHfo8jvRyi78vfB/7l7jpZSH
         UtO6dNt9T9ZBERwL6rwFI+G/2JOczGbSr2j4a6Wq3sPgk3T3q18crQJQf5CGeThSByL4
         MBfh7b/wgSvcWivAZYGSeRsnbIK7eRDDqEdtg=
In-Reply-To: <255e595fd4f868ab0f6e085deb0bfd4a2afc8ae7.1234395178.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

fixed library-matching regex
    
Forgot about /lib64, oops.
---
 dracut-functions |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index e80d786..a0a1906 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -68,7 +68,7 @@ inst_binary() {
     [[ -f $initdir$target ]] && return 0
     # I love bash!
     while read line; do
-       [[ $line =~ '([^ ]*/lib/[^ ]*\.so[^ ]*|not found)' ]] || continue
+       [[ $line =~ '([^ ]*/lib[^/]*/[^ ]*\.so[^ ]*|not found)' ]] || continue
        FILE=${BASH_REMATCH[1]}
         [[ $FILE = 'not found' ]] && {
            echo "Missing a shared library required by $bin." >&2



--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
