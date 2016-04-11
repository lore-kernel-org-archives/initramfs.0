From: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Subject: [PATCH 1/2]: dracut: 95resume: avoid possible symbolic link
 creation error on bootup
Date: Mon, 11 Apr 2016 17:11:13 +0200
Message-ID: <1460387473.2670.20.camel@trentalancia.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Avoid possible symbolic link creation error.

Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
---
=C2=A0modules.d/95resume/parse-resume.sh |=C2=A0=C2=A0=C2=A0=C2=A02 +-
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)

diff -pruN dracut-038-orig/modules.d/95resume/parse-resume.sh dracut-03=
8-95resume-force-symlink/modules.d/95resume/parse-resume.sh
--- dracut-038-orig/modules.d/95resume/parse-resume.sh	2016-04-07 12:36=
:25.522641317 +0200
+++ dracut-038-95resume-force-symlink/modules.d/95resume/parse-resume.s=
h	2016-04-07 12:37:19.864406802 +0200
@@ -67,7 +67,7 @@ if ! getarg noresume; then
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0printf -- '%s\n' ' RUN+=3D"/sbin/initqueue --finished --unique --=
name 00resume echo %M:%m=C2=A0=C2=A0> /sys/power/resume"'
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} >> /etc/udev/ru=
les.d/99-resume.rules
=C2=A0
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0printf '[ -e "%s" ] &&=
 { ln -s "%s" /dev/resume; rm -f -- "$job" "%s/initqueue/timeout/resume=
=2Esh"; }\n' \
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0printf '[ -e "%s" ] &&=
 { ln -sf "%s" /dev/resume; rm -f -- "$job" "%s/initqueue/timeout/resum=
e.sh"; }\n' \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0"$resume" "$resume" "$hookdir" >> $hookdir/initqueue/settled/resu=
me.sh
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{
