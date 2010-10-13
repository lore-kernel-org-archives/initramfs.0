From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 2/2] suppress modprobe errors on builtins (credits to Kay Sievers)
Date: Wed, 13 Oct 2010 19:39:14 +0200
Message-ID: <1286991554-3715-2-git-send-email-aidecoe@aidecoe.name>
References: <1286991554-3715-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1286991554-3715-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

Install /lib/modules/$kv/modules.builtin.bin to suppress modprobe error
messages saying module was not found, while it's built-in.

Credits go to Kay Sievers who enlighten us about meaning of this cool
file.
---
 modules.d/90kernel-modules/install |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/modules.d/90kernel-modules/install b/modules.d/90kernel-modules/install
index 9810d12..863ffac 100755
--- a/modules.d/90kernel-modules/install
+++ b/modules.d/90kernel-modules/install
@@ -4,3 +4,4 @@
 [ -f /etc/modprobe.conf ] && dracut_install /etc/modprobe.conf
 dracut_install $(find /etc/modprobe.d/ -type f -name '*.conf')
 inst_hook cmdline 01 "$moddir/parse-kernel.sh"
+inst "$srcmods/modules.builtin.bin"
-- 
1.7.3.1
