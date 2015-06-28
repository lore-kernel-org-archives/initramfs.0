From: Nathan McSween <nwmcsween-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] skipcpio.c: Linux only accepts 070701 cpio magic, this also fixes a comparision of signed char to 0xc7 (type limits)
Date: Sun, 28 Jun 2015 19:42:29 +0000
Message-ID: <1435520549-27302-2-git-send-email-nwmcsween@gmail.com>
References: <1435520549-27302-1-git-send-email-nwmcsween@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tBdt9FS85MHK2If/j8gScKlI0lCKEqOL8d0r6X3p1+8=;
        b=tQ8AznGum5e5faBxRGZbnJ515BSr2IcK7qzlNXXe6zDOfOkYmXUkZvhehlHZWRCBYE
         baR28z3bKaiqwdQWP6a94L1ZafgzrH1mLrqgHN4hZFUIs8mHsgf5RB1D1iN8fUIctWsY
         pqQ5Ej2qNo65Th9qi8iYEJDKpQxmKJs1ijvmmVYdMZwxIqg8t0md8yHOuVCR02WI4QGu
         6UALCYYfOby+is+2YbVkvHhqt4en5KpOWJLqVTm9NNpIgiCQg14zPzgAI7k85r48PZu9
         CBLG6xbyUPeeLI3kL/lH5qf4fGMnSADjG/yQ4yYFIZa95GfbO5yjUMOePrdXTsCAge+c
         +ofw==
In-Reply-To: <1435520549-27302-1-git-send-email-nwmcsween-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nathan McSween <nwmcsween-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
 skipcpio/skipcpio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/skipcpio/skipcpio.c b/skipcpio/skipcpio.c
index 445d7f6..486e00f 100644
--- a/skipcpio/skipcpio.c
+++ b/skipcpio/skipcpio.c
@@ -59,9 +59,8 @@ int main(int argc, char **argv)
         }
         fseek(f, 0, SEEK_SET);

-        /* check, if this is a cpio archive */
-        if ((buf[0] == 0x71 && buf[1] == 0xc7)
-            || (buf[0] == '0' && buf[1] == '7' && buf[2] == '0' && buf[3] == '7' && buf[4] == '0' && buf[5] == '1')) {
+        /* check, if this is a cpio archive, linux only accepts "070701" */
+        if (!memcmp(buf "070701", 6)) {
                 long pos = 0;

                 /* Search for CPIO_END */
-- 
2.4.5
