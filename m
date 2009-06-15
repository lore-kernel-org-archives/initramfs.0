From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [PATCH] Don't start mdmon if it isn't installed
Date: Tue, 16 Jun 2009 00:05:28 +0200
Message-ID: <4A36C5A8.8070801@bfh.ch>
References: <4A36C0D2.6070406@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A36C0D2.6070406-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This is a better version of the previous patch:
Don't install the pre-pivot script if mdmon isn't available.

diff --git a/modules.d/90mdraid/install b/modules.d/90mdraid/install
index 1885f7c..d35dfce 100755
--- a/modules.d/90mdraid/install
+++ b/modules.d/90mdraid/install
@@ -3,9 +3,11 @@ dracut_install mdadm
  inst /etc/passwd
  inst /etc/group
  instmods =drivers/md
-[ -x  /sbin/mdmon ] && dracut_install mdmon
  inst_rules "$moddir/70-mdadm.rules"
  [ -f /etc/mdadm/mdadm.conf ] && inst /etc/mdadm/mdadm.conf /etc/mdadm.conf
  [ -f /etc/mdadm.conf ] && inst /etc/mdadm.conf
-inst_hook pre-pivot 30 "$moddir/mdmon-pre-pivot.sh"

+if [ -x  /sbin/mdmon ] ; then
+    dracut_install mdmon
+    inst_hook pre-pivot 30 "$moddir/mdmon-pre-pivot.sh"
+fi

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
