From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut: don't skip zero-length string outfile argument
Date: Tue, 29 Mar 2011 10:27:33 +0200
Message-ID: <4D9197F5.9030900@redhat.com>
References: <1301352736-5715-1-git-send-email-aidecoe@aidecoe.name> <1301354408-sup-3380@ittemni>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1301354408-sup-3380@ittemni>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Am 29.03.2011 01:22, schrieb Amadeusz =C5=BBo=C5=82nowski:
> Excerpts from Amadeusz =C5=BBo=C5=82nowski's message of Tue Mar 29 00=
:52:16 +0200 2011:
>> +outfile=3D"unset"
>=20
> This is bad for file.

used this:

diff --git a/dracut b/dracut
index 6b67dc0..0324ac5 100755
--- a/dracut
+++ b/dracut
@@ -237,8 +237,9 @@ while (($# > 0)); do
                        ;;
         -*) printf "\nUnknown option: %s\n\n" "$1" >&2; usage; exit 1;=
;
         *)
-            if ! [[ $outfile ]]; then
+            if ! [[ $outfile_set ]]; then
                 outfile=3D$1
+                outfile_set=3Dy
             elif [[ $kernel =3D "unset" ]]; then
                 kernel=3D$1
             else
