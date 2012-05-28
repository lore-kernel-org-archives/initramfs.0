From: Juan RP <xtraeme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] modules.d/99base/init.sh: check for a valid init in
 case INIT is a symlink.
Date: Mon, 28 May 2012 16:14:35 +0200
Message-ID: <20120528161435.c91a240f.xtraeme@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding:resent-date:resent-from:resent-to:subject
         :resent-message-id;
        bh=twnmYHPgHjG5jxC3fCfgyD5S1S7cg5hUnW2Ba0/ttmY=;
        b=PHr2vw5CQzXNLt319UNamKQBh4EoMAxySz3dLZKnlRi3zNOV343nQDBN3X5/xNjXew
         TtCXGmOxOBx0MUSLXmnZ3FZWo90fRsly2fSTVeLVe5Rl6jwRQ0D/ZuAGFDOUA7cxQUjr
         9vEmfp023tJ/K0wD02WWN/She8ae0BGeVmtcY+3tUbyMkcsrA0hqICXEHO6yjbvkAVjv
         AHtYRXWjeVoeUstFUTYiYrR4Vi7NJie/OwajkrAZ7xHQ7Jf0el74Wtf4kulC27VvTxbu
         Qn4HPea55QgtFYkRcja42d9jOdAokdmctsHK3JCcV8GYtcOCantH1sbSwAbI04kOlYB4
         7+mA==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


Obviously we have to test if it's executable with the PATH to NEWROOT.
---
 modules.d/99base/init.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/99base/init.sh b/modules.d/99base/init.sh
index b8736ec..b20abc4 100755
--- a/modules.d/99base/init.sh
+++ b/modules.d/99base/init.sh
@@ -237,7 +237,7 @@ for i in "$(getarg real_init=)" "$(getarg init=)" $(getargs rd.distroinit=) /sbi
     [ -n "$i" ] || continue
 
     __p=$(readlink -f "${NEWROOT}/${i}")
-    if [ -x "$__p" ]; then
+    if [ -x "$__p" -o -x "${NEWROOT}/${__p}" ]; then
         INIT="$i"
         break
     fi
-- 
1.7.10.2
