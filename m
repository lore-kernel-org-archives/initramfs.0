From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH 3/6] Module scripts should be executable
Date: Fri, 27 Nov 2009 11:57:13 +0100
Message-ID: <1259319436-14925-4-git-send-email-philippe.seewer@bfh.ch>
References: <1259319436-14925-1-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1259319436-14925-1-git-send-email-philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 0 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 modules.d/40network/ifname-genrules.sh
 mode change 100644 => 100755 modules.d/40network/parse-bridge.sh
 mode change 100644 => 100755 modules.d/40network/parse-ifname.sh

diff --git a/modules.d/40network/ifname-genrules.sh b/modules.d/40network/ifname-genrules.sh
old mode 100644
new mode 100755
diff --git a/modules.d/40network/parse-bridge.sh b/modules.d/40network/parse-bridge.sh
old mode 100644
new mode 100755
diff --git a/modules.d/40network/parse-ifname.sh b/modules.d/40network/parse-ifname.sh
old mode 100644
new mode 100755
-- 
1.6.5.3
