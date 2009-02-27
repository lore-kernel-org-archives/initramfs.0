From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] Modify Makefile to understand the new module structure.
Date: Thu, 26 Feb 2009 16:02:50 -0800 (PST)
Message-ID: <299faeb1d193fdf4a449b2ba4bcbbf828a6f2482.1235692800.git.victor.lowther@gmail.com>
References: <fe553fde63ff13111aa00375b11923904c584326.1235692799.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=Thy0rHGq/dwAkOSI/qJkl4asHGpsCz/YeC4dZj+5mNo=;
        b=WLdVBQVO8+fmuQha7qit6QQPmPaglP/lG14usNHTU2bWaxFw7MdSrNCVISkWOCOnB4
         yzPrLvvax2aSHxRB5zf8trRjw/0qs5Sb0HmGTkAokchU6TjBN8P0zLeO3OqpUVb5+555
         JKxkahKg0Z0qlyMa9xBtnwPZ2anNX4tceVygU=
In-Reply-To: <fe553fde63ff13111aa00375b11923904c584326.1235692799.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 Makefile |   10 ++--------
 dracut   |    2 +-
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index dbc2a7d..039ec9e 100644
--- a/Makefile
+++ b/Makefile
@@ -4,16 +4,10 @@ all:
 install:
 	mkdir -p $(DESTDIR)/usr/libexec/dracut
 	mkdir -p $(DESTDIR)/sbin
-	mkdir -p $(DESTDIR)/usr/libexec/dracut/hooks
-	mkdir -p $(DESTDIR)/usr/libexec/dracut/modules
+	mkdir -p $(DESTDIR)/usr/libexec/dracut/modules.d
 	install -m 0755 dracut $(DESTDIR)/sbin/dracut
-	install -m 0755 init $(DESTDIR)/usr/libexec/dracut/init
-	install -m 0755 switch_root $(DESTDIR)/usr/libexec/dracut/switch_root
 	install -m 0755 dracut-functions $(DESTDIR)/usr/libexec/dracut/functions
-	mkdir $(DESTDIR)/usr/libexec/dracut/rules.d
-	for rule in rules.d/*.rules ; do install -m 0644 $$rule $(DESTDIR)/usr/libexec/dracut ; done
-	for hook in hooks/*.sh ; do install -m 0755 $$hook $(DESTDIR)/usr/libexec/dracut ; done
-	for module in modules/*.sh; do install -m 0755 $$module $(DESTDIR)/usr/libexec/dracut ; done
+	for module in modules/*/*; do install -D -m 0755 $$module $(DESTDIR)/usr/libexec/dracut ; done
 clean:
 	rm -f *~
 
diff --git a/dracut b/dracut
index 3078241..5811f57 100755
--- a/dracut
+++ b/dracut
@@ -34,7 +34,7 @@ if [[ -f $outfile && ! $force ]]; then
     exit 1
 fi
 
-[[ $allowlocal && -f ./init ]] && dsrc="." || dsrc=/usr/libexec/dracut
+[[ $allowlocal && -f dracut-functions ]] && dsrc="." || dsrc=/usr/libexec/dracut
 . $dsrc/dracut-functions
 initfile=$dsrc/init
 switchroot=$dsrc/switch_root
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
