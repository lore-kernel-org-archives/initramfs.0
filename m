From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: dracut and ubuntu 8.10
Date: Fri, 6 Mar 2009 17:07:04 +0100
Message-ID: <49B14A28.1050609@bfh.ch>
References: <49A8602D.7020708@bfh.ch> <49B13EDD.2080700@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49B13EDD.2080700-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

I fell into the 80 chars per line trap, sorry about that. the install 
script was mangled up. this should hopefully fixe it.

---
diff --cc modules.d/95udev-rules.ub810/install
index f4067dd,1898fb1..0000000
--- a/modules.d/95udev-rules.ub810/install
+++ b/modules.d/95udev-rules.ub810/install
@@@ -7,7 -7,7 +7,9 @@@ mkdir -p "$initdir/var/run
   dracut_install udevd udevadm pkill
   dracut_install /etc/udev/udev.conf

- for rules in 05-options.rules 20-names.rules 
40-basic-permissions.rules 60-per
  -for rules in 05-options.rules 20-names.rules 
40-basic-permissions.rules 60-per
++for rules in 05-options.rules 20-names.rules 40-basic-permissions.rules \
++    60-persistent-storage.rules 61-persistent-storage-edd.rules \
++    80-programs.rules 90-modprobe.rules 95-udev-late.rules; do
       dracut_install /etc/udev/rules.d/$rules
   done



--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
