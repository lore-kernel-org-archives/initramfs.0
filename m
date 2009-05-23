From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/4] Point README at README.modules for more detail on writing modules
Date: Fri, 22 May 2009 19:24:33 -0700 (PDT)
Message-ID: <135c308df563ecf8c9e5923ebc66bd017b9ff199.1243045308.git.victor.lowther@gmail.com>
References: <97274286f3d147cdb21897569d71a1cf5ff4eb07.1243045308.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=Tsvpiwka9SE71fgy+aGazPJc5vbVWVqBy7JfmckYSsk=;
        b=vw8+EHxQPGGQmISqxZ8Yihj45KWmDne+zbP+j6z48mqXAU/8U5889liTm+1pYBeuk+
         4NffJ9to8LyFYT8slZECqZX4if4mSKL6gyY6xukwaTJoh/v5VGsGCH6sI2Qf2RrKVT0j
         B5OY4Aa7C5H1fJLo2xvj3kLurHphm58DlRLL8=
In-Reply-To: <97274286f3d147cdb21897569d71a1cf5ff4eb07.1243045308.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 README |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/README b/README
index 7f6af6f..c8a648d 100644
--- a/README
+++ b/README
@@ -37,7 +37,8 @@ Some general rules for writing modules:
  * Generator modules should have a two digit numeric prefix -- they run in
    ascending sort order. Anything in the 90-99 range is stuff that dracut
    relies on, so try not to break those hooks.
- * Generator modules and hooks must have a .sh extension.
+ * Hooks must have a .sh extension.
+ * Generator modules are described in more detail in README.modules.
  * We have some breakpoints for debugging your hooks.  If you pass 'break'
    as a kernel parameter, the initramfs will drop to a shell just before
    switching to a new root. You can pass 'break=hookpoint', and the initramfs
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
