From: Robert Schweikert <rjschwei-IBi9RG/b67k@public.gmane.org>
Subject: Fix for typo
Date: Fri, 06 Jul 2012 07:56:17 -0400
Message-ID: <4FF6D261.1030008@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

While reading through the docs I found a typo, fixed in the patch below. 
Also I noticed that there are a number of scripts in modules.d that use 
#!/bin/bash. This appears to contradict the documentation, should these 
not all be #!/bin/sh ?

Last but not least, the HACKING file does not actually provide any 
information about hacking, i.e. how to submit patches, or the "general 
rules for writing modules" posted on the web page 
(https://dracut.wiki.kernel.org/index.php/Main_Page), shouldn't this be 
information that is included in the HACKING file?

Thanks,
Robert

 From ee95d01ed7e990a6b24e94614beafef970036a49 Mon Sep 17 00:00:00 2001
From: Robert Schweikert <rjschwei-IBi9RG/b67k@public.gmane.org>
Date: Fri, 6 Jul 2012 07:49:56 -0400
Subject: [PATCH] fix typo

---
  README.modules |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/README.modules b/README.modules
index 64d533f..a8e18bf 100644
--- a/README.modules
+++ b/README.modules
@@ -51,7 +51,7 @@ check():
         functionality the module implements is being used on the host 
system.
         For example, if this module handles installing support for LUKS
         encrypted volumes, it should return 0 if all the tools to handle
-       encrpted volumes are available and the host system has the root
+       encrypted volumes are available and the host system has the root
         partition on an encrypted volume, 1 otherwise.

  depends():
-- 
1.7.7

-- 
Robert Schweikert                           MAY THE SOURCE BE WITH YOU
SUSE-IBM Software Integration Center                   LINUX
Tech Lead
rjschwei-IBi9RG/b67k@public.gmane.org
rschweik-G1DYhSM1WHTQT0dZR+AlfA@public.gmane.org
781-464-8147
