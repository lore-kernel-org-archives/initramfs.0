From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 03/16] Clean up some conditional checking when trying to find our config files.
Date: Sat, 14 Aug 2010 14:23:24 -0500 (CDT)
Message-ID: <ef5afb56d5b0073885e92a7fbe0bd79dfe84fb77.1281812505.git.victor.lowther@gmail.com>
References: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:message-id
         :in-reply-to:references:from:subject:to:x-mailer:date;
        bh=B0ppyay58vhbTSWBDiqzzMVjCWereOJvc5neXTq92MQ=;
        b=P6LjtrjExiX58FADvTtHTfsMHx2nxIahOg7d/uYgVQWvhJhRcRaulzLD0vH6tobf9r
         7zTF/3inTgsNX6r3TmafNOSUBnvew2NjcD7X76v4ewSjTkvLyI27je0adnv7onX5Yk5u
         e4U+Y7xPD886uErBLPZ/ffv01PiBT8PMh1lJo=
In-Reply-To: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

No point in checking the same condition twice when compound commands will do.

---
 dracut |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/dracut b/dracut
index 541bfc0..a653981 100755
--- a/dracut
+++ b/dracut
@@ -131,13 +131,13 @@ export PATH
 
 # if we were not passed a config file, try the default one
 if [[ ! -f $conffile ]]; then
-    [[ $allowlocal ]] || conffile="/etc/dracut.conf"
-    [[ $allowlocal ]] && conffile="$dracutbasedir/dracut.conf"
+    [[ $allowlocal ]] && conffile="$dracutbasedir/dracut.conf" || \
+        conffile="/etc/dracut.conf"
 fi
 
 if [[ ! -d $confdir ]]; then
-    [[ $allowlocal ]] || confdir="/etc/dracut.conf.d"
-    [[ $allowlocal ]] && confdir="$dracutbasedir/dracut.conf.d"
+    [[ $allowlocal ]] && confdir="$dracutbasedir/dracut.conf.d" \
+        confdir="/etc/dracut.conf.d"
 fi
 
 # source our config file
-- 
1.7.2.1
