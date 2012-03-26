From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: =?UTF-8?q?=5BPATCH=202/2=5D=20document=20--tmpdir=20option?=
Date: Mon, 26 Mar 2012 14:28:36 +0200
Message-ID: <1332764916-22282-2-git-send-email-aidecoe@aidecoe.name>
References: <1332764916-22282-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1332764916-22282-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 dracut.8.asc      |    6 ++++++
 dracut.conf.5.asc |    3 +++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/dracut.8.asc b/dracut.8.asc
index 10cccc0..7c53314 100644
--- a/dracut.8.asc
+++ b/dracut.8.asc
@@ -217,6 +217,12 @@ Default:
 Default:
    _/etc/dracut.conf.d_
=20
+**--tmpdir**=C2=A0_<temporary directory>_::
+    specify temporary directory to use.
++
+Default:
+   _/var/tmp_
+
 **--sshkey**=C2=A0_<sshkey file>_:: ssh key file used with ssh-client =
module.
=20
 **-l, --local**::
diff --git a/dracut.conf.5.asc b/dracut.conf.5.asc
index 8709617..017a221 100644
--- a/dracut.conf.5.asc
+++ b/dracut.conf.5.asc
@@ -67,6 +67,9 @@ line are not interpreted.
 *hostonly=3D*"__{yes|no}__"::
     Host-Only mode: Install only what is needed for booting the local =
host instead of a generic host.
=20
+*tmpdir=3D*"__<temporary directory>__"::
+    Specify temporary directory to use.
+
 [WARNING]
 =3D=3D=3D=3D
 If chrooted to another root other than the real root device, use --fst=
ab and provide a valid _/etc/fstab_.
--=20
1.7.8.5
