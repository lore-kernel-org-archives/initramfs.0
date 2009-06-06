From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH 5/9] NFS test: re-add the fix for the terminal
Date: Sat,  6 Jun 2009 05:23:26 -0400
Message-ID: <d462f6dc65255931a2ba2b432568ec962f783f50.1244279679.git.dave@thedillows.org>
References: <cover.1244279679.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1244279679.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
In-Reply-To: <cover.1244279679.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
References: <cover.1244279679.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>

When debugging, this is still needed as we won't be redirecting out
output to /dev/null or a file. However, we need to guard against not
having a terminal.
---
 test/TEST-20-NFS/test.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/test/TEST-20-NFS/test.sh b/test/TEST-20-NFS/test.sh
index e120f64..580c4df 100755
--- a/test/TEST-20-NFS/test.sh
+++ b/test/TEST-20-NFS/test.sh
@@ -16,6 +16,9 @@ run_server() {
 	-initrd initramfs.server -pidfile server.pid -daemonize || return 1
     sudo chmod 644 server.pid || return 1
 
+    # Cleanup the terminal if we have one
+    tty -s && stty sane
+
     echo Sleeping 10 seconds to give the server a head start
     sleep 10
 }
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
