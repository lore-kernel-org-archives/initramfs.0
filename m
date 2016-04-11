From: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Subject: [PATCH v2 1/2]: dracut: 95resume: avoid possible symbolic link
 creation error on bootup
Date: Mon, 11 Apr 2016 18:00:39 +0200
Message-ID: <1460390439.2670.24.camel@trentalancia.net>
References: <1460387473.2670.20.camel@trentalancia.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460387473.2670.20.camel-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Avoid symbolic link creation error (should apply to latest dracut versi=
on).

Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
---
=C2=A0modules.d/95resume/parse-resume.sh |=C2=A0=C2=A0=C2=A0=C2=A02 +-
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)

--- dracut-044/modules.d/95resume/parse-resume.sh	2015-11-25 14:22:28.0=
00000000 +0100
+++ dracut-044-95resume-force-symlink/modules.d/95resume/parse-resume.s=
h	2016-04-11 17:53:20.664983390 +0200
@@ -67,7 +67,7 @@ if ! getarg noresume; then
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0printf -- '%s\n' ' RUN+=3D"/sbin/initqueue --finished --unique --=
name 00resume echo %M:%m=C2=A0=C2=A0> /sys/power/resume"'
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} >> /etc/udev/ru=
les.d/99-resume.rules
=C2=A0
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0printf '[ -e "%s" ] &&=
 { ln -s "%s" /dev/resume 2> /dev/null; rm -f -- "$job" "%s/initqueue/t=
imeout/resume.sh"; }\n' \
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0printf '[ -e "%s" ] &&=
 { ln -sf "%s" /dev/resume 2> /dev/null; rm -f -- "$job" "%s/initqueue/=
timeout/resume.sh"; }\n' \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0"$resume" "$resume" "$hookdir" >> $hookdir/initqueue/settled/resu=
me.sh
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{
