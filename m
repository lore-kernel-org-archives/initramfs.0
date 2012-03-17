From: Wim Muskee <wimmuskee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] provide name based nbd connects
Date: Sat, 17 Mar 2012 12:33:55 +0100
Message-ID: <CAKzfqkf5Vn_RijjJ0Vames6zAsypTbNUJ+tqxD4A8S3XA-qbqw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=wFKXsrqsDOcL+NFmPYWcO2ZkPA/a4lGcO/lmV8wC/Ek=;
        b=0KkqgdfI19PDxq89/SkhcTMVj/9bEu0B8IfCutmaHUZjxLGmsdo9CfcdvLzOzkma8s
         /iEqayuyGZXDZjbERvURkdBdgvMhY72RG1eImCarmQNZ11FzlHHvYOyL8vi4MttdJuG2
         5aaPlu2UfYE1LdwBDD7WH0Ww7YtwSZG9kHbahhbzkO9qamQw3XV2T/TAQPeJ48gQIvjY
         XNQrTBXqpBO7R7xFq5wlX0e7HJobcDsS1nWvSz++7NyV14Z7zmYeOTJNXckigIWM2HSq
         HtxqE0nOtbJuG7leMwvsPCMFYZIqSe05BtymSMeHChHYGothzGPAKkJnwRgLOOBlI6bH
         VB2A==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Because nbd-server also provides name-based exports instead of
port-based ones, make it possible to connect to those.

--- modules.d/95nbd/nbdroot.sh.orig     2012-03-17 12:23:52.988936315 +0100
+++ modules.d/95nbd/nbdroot.sh  2012-03-17 12:26:12.048798184 +0100
@@ -30,6 +30,11 @@
 nbdflags=${root%%:*}
 nbdopts=${root#*:}

+# If nbdport not an integer, then assume name based import
+if [[ $nbdport != [0-9]* ]]; then
+    nbdport="-N $nbdport"
+fi
+
 if [ "$nbdopts" = "$nbdflags" ]; then
     unset nbdopts
 fi
