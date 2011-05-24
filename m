From: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>
Subject: [PATCH] Remove obsolete check reference from README.modules
Date: Wed, 25 May 2011 01:31:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.1105250129350.7357@gate.bb.dicp.net>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Should be self explanatory. Now that we have all the shell commands 
condensed in the module-install.sh, the lone reference to check should be 
removed.

Signed-off-by: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>

 README.modules |    1 -
 1 files changed, 1 deletion(-)

diff --git a/README.modules b/README.modules
index 21461de..746701a 100644
--- a/README.modules
+++ b/README.modules
@@ -5,7 +5,6 @@ structure:
 dracut_install_dir/modules.d/
 	00modname/
 		module-setup.sh
-		check
 		<other files as needed by the hook>
 
 00modname: The name of the module prefixed by a two-digit numeric sort code.
