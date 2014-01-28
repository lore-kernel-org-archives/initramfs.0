From: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] skipcpio: return something at end of program
Date: Tue, 28 Jan 2014 16:41:08 -0300
Message-ID: <1390938068-5109-1-git-send-email-crrodriguez@opensuse.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cristianrodriguez.net; s=google;
        h=sender:from:to:cc:subject:date:message-id;
        bh=+qPcVluQ/FnTsVfQUu0v33yogNxOUt4D3+x2hxIffEc=;
        b=hQZW2TLXk/bnaXBzMmt9vXn3Wdyhbs9GcqtPklDNAyMcWuWms3nYuqKjMn+ilgXLQx
         jPK6zae9XzU8JZ5rT8MoA7jof3Rt8ufKQLY29598GPTi9fzksFdALHQ3NspTN5kfZaxi
         M+V3JlkUmj5BFkccDcaeeHMudH5H6I4FvV4wI=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>

Otherwise the compiler emits a warning and the return vale is
in theory undefined.
---
 skipcpio/skipcpio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/skipcpio/skipcpio.c b/skipcpio/skipcpio.c
index fbf391b..c912061 100644
--- a/skipcpio/skipcpio.c
+++ b/skipcpio/skipcpio.c
@@ -120,4 +120,6 @@ int main(int argc, char **argv)
                         break;
         }
         fclose(f);
+
+        return EXIT_SUCCESS;
 }
-- 
1.8.4.5
