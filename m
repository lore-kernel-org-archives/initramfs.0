From: Nathan McSween <nwmcsween-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] skipcpio.c: fix up cpio magic comparison
Date: Sun, 28 Jun 2015 19:42:28 +0000
Message-ID: <1435520549-27302-1-git-send-email-nwmcsween@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=GuStMc8TwfazJhR2JGbq1XbkoZTKuNsWB+rqG07GE08=;
        b=Ya+JYlHTSugaDf+avyZ7Gnqt+0xuVUkL0iFMiAw8xp642k78kHuc4c4AgMm77CrPy6
         8hWL2GLoLGE+U9p0wPprrf70Gaz9VWaW4hnDKRcIFA7LlGPHlrWk2KHwGrxWESDDPVba
         ebNhoGkn+FH/T0TtBndvPCleXehqHexux4KDqVIGpkBj9h98q/d3QElcwy6vfcAxr3tl
         58qK+5xjCJl884PyGAZLdsT0qUWaME3Fag1ItUDysri8hD5A2hPIWZNyXEFiJNyiWCgG
         2FKhBbdH4Y96Z1X5AWQDdgrqhlIgCa/AOdhvdIpuLVh1VG09WcXVkvHwj9RguYden6Td
         POrw==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nathan McSween <nwmcsween-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Nathan McSween (1):
  skipcpio.c: Linux only accepts 070701 cpio magic, this also fixes a
    comparision of signed char to 0xc7 (type limits)

 skipcpio/skipcpio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.4.5
