From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v1 02/11] initramfs: replace simple_strtoul() with kstrtoul()
Date: Tue, 20 Jan 2015 14:12:51 -0500
Message-ID: <1421781180-24425-3-git-send-email-zohar@linux.vnet.ibm.com>
References: <1421781180-24425-1-git-send-email-zohar@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421781180-24425-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, Al Viro <viro@ZenIV.linux.org.uk>, linux-ima-devel@lists.sourceforge.net, linux-security-module <linux-security-module@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Replace existing obsolete simple_strtoul() call with kstrtoul(),
before making other changes.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 init/initramfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index bb51b5b..5dd93ca 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -163,12 +163,15 @@ static void __init parse_header(char *s)
 {
 	unsigned long parsed[12];
 	char buf[9];
+	int ret;
 	int i;
 
 	buf[8] = '\0';
 	for (i = 0, s += 6; i < 12; i++, s += 8) {
 		memcpy(buf, s, 8);
-		parsed[i] = simple_strtoul(buf, NULL, 16);
+		ret = kstrtoul(buf, 16, &parsed[i]);
+		if (ret)
+			pr_err("invalid cpio header field (%d)", ret);
 	}
 	ino = parsed[0];
 	mode = parsed[1];
-- 
1.8.1.4
