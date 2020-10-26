From: "Tkaczyk, Mariusz" <mariusz.tkaczyk-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] mdraid: add grow continue service.
Date: Mon, 26 Oct 2020 09:37:31 +0000
Message-ID: <SA0PR11MB45425BE932F6FAC71EE09BF2FF190@SA0PR11MB4542.namprd11.prod.outlook.com>
References: <20200826075259.9416-1-mariusz.tkaczyk@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5jmKj3nldx3WFmgmPo+jjtxTJvg0tKkxntXF9UTIQY=;
 b=HuHsiGsejGzu0OALAFRMdmMKjI2s0NI5AOHysonXvWWNTi5cBgS8VF/n0q9OvMLnE15qu66GFgZeZxJumfI3J+BYYTRnqinFslAGtsVRZ5+RVVcschllHEU4cw3E7Ontif0z6dXMgC91j2RA7ZuuI+EiLv7oTYzYIGZQuuvWwlA=
In-Reply-To: <20200826075259.9416-1-mariusz.tkaczyk-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
List-ID: <initramfs.vger.kernel.org>
To: "Tkaczyk, Mariusz" <mariusz.tkaczyk-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Hi,
Could someone guide me? Did I send patch correctly?
Is there another place where dracut is maintained?

TIA.
Mariusz

-----Original Message-----
From: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> On =
Behalf Of Mariusz Tkaczyk
Sent: Wednesday, August 26, 2020 9:53 AM
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH] mdraid: add grow continue service.

During raid assembly mdadm will call mdadm-grow-continue.service if reshape=
 is in progress.
If service doesn't exist then it is done via fork. But systemd will kill it=
 unconditionally after processing all events.=20

Add proper service and allow systemd to manage reshape correctly.

Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 modules.d/90mdraid/module-setup.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/modules.d/90mdraid/module-setup.sh b/modules.d/90mdraid/module=
-setup.sh
index f59d84a8..67acb047 100755
--- a/modules.d/90mdraid/module-setup.sh
+++ b/modules.d/90mdraid/module-setup.sh
@@ -136,6 +136,9 @@ install() {
         if [ -e $dracutsysrootdir$systemdsystemunitdir/mdadm-last-resort@.=
timer ]; then
             inst_simple $systemdsystemunitdir/mdadm-last-resort@.timer
         fi
+        if [ -e $dracutsysrootdir$systemdsystemunitdir/mdadm-grow-continue=
@.service ]; then
+            inst_simple $systemdsystemunitdir/mdadm-grow-continue@.service
+        fi
     fi
     inst_hook pre-shutdown 30 "$moddir/mdmon-pre-shutdown.sh"
     dracut_need_initqueue
