From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] 99base/init: honor env. vars provided by kernel (PATH, HOME and TERM)
Date: Sun, 26 Sep 2010 00:06:54 +0200
Message-ID: <4c9e7524.9804cc0a.3175.65a0@mx.google.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 

Let take a look at Linux sources, /usr/src/linux-2.6.35/init/main.c:

  204: char * envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };

  857: run_init_process("/sbin/init");

  817: static void run_init_process(char *init_filename)
  818: {
  819:        argv_init[0] = init_filename;
  820:        kernel_execve(init_filename, argv_init, envp_init);
  821: }

As we can see HOME=/ and TERM=linux are provided for init and this might be
expected on some systems (Gentoo comes to my mind, here ;-)).  That's why we
should give to init the same set of env. vars as Linux kernel does.
---
 modules.d/99base/init |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/modules.d/99base/init b/modules.d/99base/init
index 5a02ade..dc0a0df 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -59,8 +59,8 @@ emergency_shell()
     fi
 }
 
+OLD_PATH="$PATH"
 export PATH=/sbin:/bin:/usr/sbin:/usr/bin
-export TERM=linux
 NEWROOT="/sysroot"
 
 trap "emergency_shell Signal caught!" 0
@@ -327,8 +327,8 @@ info "Switching root"
 wait_for_loginit
 
 umask $OLD_UMASK
-unset HOME
-unset TERM
+export PATH="$OLD_PATH"
+
 exec switch_root "$NEWROOT" "$INIT" $initargs || {
     echo "Something went very badly wrong in the initramfs.  Please "
     echo "file a bug against dracut."
-- 
1.7.3
