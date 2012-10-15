From: =?UTF-8?B?Q2FuZWsgUGVsw6FleiBWYWxkw6lz?= <caneko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Don't install FONT if it's the same as DEFAULT_FONT.
Date: Sun, 14 Oct 2012 19:51:54 -0500
Message-ID: <CADPrc82sed8VkbZDx_QkxgCXafSODyS0P3ZpmUu2myLbd=MHfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=lks9zESAtB2o5alNNenvlP2lQkvz9flQmAbu+mUEzcU=;
        b=eA4GnWL00Q2wl57LIVeIbYx8aMJcc98aiw64iGRkzrTPQTQXeHt6jFnorgTvMHOKd6
         M5sswc41joFrDLNdbEvWs4Pdbk0843YYdSQyY0yHjGqB0QOV+7kdr6DCPaZc9SFIQk04
         tVXfzntUbjCn/mikOhwKdFEXvcBcHOQXT6eEjleXEbudO2R0GDk8W/8AhS7sN50ZjkXZ
         HBQYE7y0qZ3cWlsbr87Tw68v9PQRUy9WOrdy3ldi9KckGD218a9Jgy0UTaf+UcaWl7Ac
         LEYb8IryM1P9gBBbGQeQGxKt2r8y/6OPux3bwZjW4CRZ3XvQSwzoxywmQSeaaUpkJkN9
         CJ2w==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

If the user defines FONT in /etc/vconsole.conf as the same font
defined in DEFAULT_FONT, when creating her initd she will get a
message similar to this one:

gzip: /var/tmp/initramfs.wzl9Qt/usr/share/consolefonts/LatArCyrHeb-16.p=
sfu
already exists; do you wish to overwrite (y or n)?

Signed-off-by: Canek Pel=C3=A1ez <canek-9iBUfMiLPD00npIRAbVhgQ@public.gmane.org>
---
 modules.d/10i18n/module-setup.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/10i18n/module-setup.sh b/modules.d/10i18n/module=
-setup.sh
index df6e5b1..1ed1db6 100755
--- a/modules.d/10i18n/module-setup.sh
+++ b/modules.d/10i18n/module-setup.sh
@@ -173,7 +173,7 @@ install() {

         inst_opt_decompress ${kbddir}/consolefonts/${DEFAULT_FONT}.*

-        if [[ ${FONT} ]]
+        if [[ ${FONT} ]] && [[ ${FONT} !=3D ${DEFAULT_FONT} ]]
         then
             FONT=3D${FONT%.psf*}
             inst_opt_decompress ${kbddir}/consolefonts/${FONT}.*

--=20
Canek Pel=C3=A1ez Vald=C3=A9s
Posgrado en Ciencia e Ingenier=C3=ADa de la Computaci=C3=B3n
Universidad Nacional Aut=C3=B3noma de M=C3=A9xico
