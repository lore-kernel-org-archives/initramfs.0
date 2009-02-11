From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 7/9] Dracut cleanups, part 2
Date: Wed, 11 Feb 2009 03:46:52 -0800 (PST)
Message-ID: <9c66fc4b37728c53f7ee3afaa00c23e50017e2aa.1234351770.git.victor.lowther@gmail.com>
References: <215b373ce2de8b9c47c7f3bd3550c7fc96a49614.1234351770.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=EcUWsvDp9w0EElUs5uHDCVvUvBJGm7Uof8X0yHUbXVI=;
        b=RzNppIWkC6ates0yCnbTKiF+oflyojfpbk8iV8gaDZ/dvdEH1cdpF9HHcYe03xucCc
         kPHnuCK7tiWqLhhS2gB2aSynW4Ab15j9/FNTVroEvLyU/Xz1EXXH9RWVFPY9R9fJn4uU
         JhaaPfimVffORFYXwZ7YHW0b1+5pNJbn4pUzU=
In-Reply-To: <215b373ce2de8b9c47c7f3bd3550c7fc96a49614.1234351770.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Missed some non-POSIX substitution in root filesystem label parsing.

---
 init |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/init b/init
index 84ae051..4b36e69 100755
--- a/init
+++ b/init
@@ -10,7 +10,7 @@ emergency_shell()
     echo ; echo
     echo "Bug in initramfs /init detected. Dropping to a shell. Good luck!"
     echo
-    sh < /dev/console
+    exec sh -i
 }
 
 getarg() {
@@ -34,7 +34,7 @@ export TERM=linux
 trap "emergency_shell" 0
 # /dev/console comes from the built-in initramfs crud in the kernel
 # someday, we may need to mkdir /dev first here
-exec > /dev/console 2>&1 < /dev/console
+# exec > /dev/console 2>&1 < /dev/console
 
 # mount some important things
 mount -t proc /proc /proc
@@ -66,7 +66,7 @@ NEWROOT="/sysroot"
 root=$(getarg root); root=${root#root=}
 case $root in
     LABEL=*) root=${root#LABEL=}
-             root=${root//\//\\x2f}
+             root="$(echo $root |sed 's,/,\\x2f,g')"
 	     root="/dev/disk/by-label/${root}" ;;
     UUID=*) root="/dev/disk/by-uuid/${root#UUID=}" ;;
     '') echo "Warning: no root specified"
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
