From: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] cryptroot-ask: check that plymouth is running before use
Date: Fri, 11 Mar 2011 01:54:04 +0300
Message-ID: <1299797644-6951-1-git-send-email-arvidjaar@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:message-id:x-mailer;
        bh=OKzI30Lw9v7RFLaS9TohCHbI/KNbHimR+Kj1LB8OAoA=;
        b=OOe8f6YmpaSnba0qU6iAkvbrmyhCVuqPdhT3If3JIBCYVPw72k0btzhTSaR1JrKIvG
         JAZKHAT42VQx4gqmDe2Dh+tw+bVOpoIx6YxHnMTg3gDIsQ4x14YxPe8Le8E/u22atsiz
         aIYAQf6xErqweB2P5OV42AMJlqT60qTHOHTz4=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Otherwise there is no way to skip pasword prompt. --has-active-vt
seems to correctly catch also the case when plymouthd is started
but splash is disabled.

Signed-off-by: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
 modules.d/90crypt/cryptroot-ask.sh |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90crypt/cryptroot-ask.sh
index 5150688..9c99ccc 100755
--- a/modules.d/90crypt/cryptroot-ask.sh
+++ b/modules.d/90crypt/cryptroot-ask.sh
@@ -80,9 +80,8 @@ if [ -n "$(getarg rd.luks.key)" ]; then
     rmdir "$mntp"
     unset mntp keypath keydev
 else
-    # Prompt for password with plymouth, if installed.
-    # Should we check if plymouthd is running?
-    if [ -x /bin/plymouth ]; then
+    # Prompt for password with plymouth, if installed and running.
+    if [ -x /bin/plymouth ] && /bin/plymouth --has-active-vt; then
         prompt="Password [$device ($luksname)]:" 
         if [ ${#luksname} -gt 8 ]; then
             sluksname=${sluksname##luks-}
-- 
tg: (661f9a3..) upstream/crypto-plymouth (depends on: origin/master)
