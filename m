From: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Subject: [PATCH] dracut-gencmdline: emit "resume="
Date: Thu, 29 Oct 2009 09:27:07 +0000
Message-ID: <4AE95FEB.7090304@tuffmail.co.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=CMiIziOMgt84EPsfhb/v2qBw4BvuzzGEvbW8KDYP8dA=;
        b=R4LNp6yYQIWRx4EgDmNDbWNa7APT6g1hCAohST9U6uxxRYGGi2xtQt8RZoueyBrqSk
         IAT9UjorQI0Jf/uiIi3fExWHbiuGOM0acGkUA2T3tyjGzk4Qe0ksfNmN7tW19aVbXyFo
         Lc9cOV7sS+YkF1fawsVTE7CYPTghtn6BsKOIY=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I haven't tested resume either way, but I can't imagine it working if
we don't tell it which device to use :-).

diff --git a/dracut-gencmdline b/dracut-gencmdline
index 978f5a2..625546c 100755
--- a/dracut-gencmdline
+++ b/dracut-gencmdline
@@ -711,5 +711,9 @@ if [ -n "$rootdev" ]; then
     echo -n "root=$rootdev "
 fi
 
+if [ -n "$swsuspdev" ]; then
+    echo -n "resume=$swsuspdev "
+fi
+
 echo
 # vim:ts=8:sw=4:sts=4:et

