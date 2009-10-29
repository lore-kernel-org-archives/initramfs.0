From: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Subject: [PATCH] dracut-gencmdline: fix freadlink() on debian
Date: Thu, 29 Oct 2009 09:26:20 +0000
Message-ID: <4AE95FBC.2010501@tuffmail.co.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=c7z+NRTLasTlFXiP16llspkBM/Ga4OH53QJ3FRaRJL8=;
        b=tzZ+7o6evDhCL7pwfhxY3YBSIj/pXS0KZFc4ISFjhqlt7m7904JnR6gzyMNh2oddeg
         8tRLrnateAc05fSBbkRMNU6E6ay1Iz9/szDB7Ydxy/tlJ7zs4WaODLHXjGqWGiVNV0dI
         hMPeJLa5L0xd+bdZpsXKUU6EAQjSfC3cKb3/M=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

In Debian, readlink lives in /bin.

diff --git a/dracut-gencmdline b/dracut-gencmdline
index 689f49e..978f5a2 100755
--- a/dracut-gencmdline
+++ b/dracut-gencmdline
@@ -154,7 +154,7 @@ qpopd() {
 
 
 freadlink() {
-    /usr/bin/readlink -f "$1"
+    readlink -f "$1"
 }
 
 resolve_device_name() {

