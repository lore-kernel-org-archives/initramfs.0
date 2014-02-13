From: sfalken-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org
Subject: Patch for Manpage
Date: Thu, 13 Feb 2014 08:03:35 +0000
Message-ID: <2472246.g3sNxB2UqE@linux-n5po>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart25786604.pUKuXAIhTE"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--nextPart25786604.pUKuXAIhTE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Patch corrects grub paths in the manpage for both GRUB legacy and GRUB2=


diff -rupN dracut-036.old/dracut.8 dracut-036/dracut.8
=2D-- dracut-036.old/dracut.8=092014-01-29 07:36:45.000000000 +0000
+++ dracut-036/dracut.8=092014-02-13 05:39:56.965246846 +0000
@@ -189,7 +189,7 @@ If you need a special kernel module in t
 .sp
 An initramfs generated without the "hostonly" mode, does not contain a=
ny=20
system configuration files (except for some special exceptions), so the=
=20
configuration has to be done on the kernel command line\&. With this=20=

flexibility, you can easily boot from a changed root partition, without=
 the=20
need to recompile the initramfs image\&. So, you could completly change=
 your=20
root partition (move it inside a md raid with encryption and LVM on top=
), as=20
long as you specify the correct filesystem LABEL or UUID on the kernel =
command=20
line for your root device, dracut will find it and boot from it\&.
 .sp
=2DThe kernel command line usually can be configured in=20
\fI/boot/grub/grub\&.conf\fR, if grub is your bootloader and it also ca=
n be=20
edited in the real boot process in the grub menu\&.
+The kernel command line usually can be configured in=20
\fI/boot/grub/menu\&.lst\fR, for GRUB Legacy, and=20
\fI/boot/grub2/grub\&.cfg\fR, for GRUB2 if grub is your bootloader and =
it also=20
can be edited in the real boot process in the grub menu\&.
 .sp
 The kernel command line can also be provided by the dhcp server with t=
he=20
root\-path option\&. See the section called \(lqNetwork Boot\(rq\&.
 .sp
diff -rupN dracut-036.old/dracut.html dracut-036/dracut.html
=2D-- dracut-036.old/dracut.html=092014-01-29 07:36:45.000000000 +0000
+++ dracut-036/dracut.html=092014-02-12 21:41:37.988588041 +0000
@@ -1277,7 +1277,7 @@ boot from a changed root partition, with
 image. So, you could completly change your root partition (move it ins=
ide a=20
md
 raid with encryption and LVM on top), as long as you specify the corre=
ct
 filesystem LABEL or UUID on the kernel command line for your root devi=
ce,=20
dracut
=2Dwill find it and boot from it.</p><p>The kernel command line usually c=
an be=20
configured in <span class=3D"emphasis"><em>/boot/grub/grub.conf</em></s=
pan>, if
+will find it and boot from it.</p><p>The kernel command line usually c=
an be=20
configured in <span class=3D"emphasis"><em>/boot/grub/menu.lst</em></sp=
an>, for=20
GRUB Legacy, or <span class=3D"emphasis"><em>/boot/grub2/grub.cfg</em><=
/span>,=20
for GRUB2 if
 grub is your bootloader and it also can be edited in the real boot pro=
cess in
 the grub menu.</p><p>The kernel command line can also be provided by t=
he dhcp=20
server with the
 root-path option. See <a class=3D"xref" href=3D"#NetworkBoot" title=3D=
"Network=20
Boot">the section called =E2=80=9CNetwork Boot=E2=80=9D</a>.</p><p>For =
a full reference of all=20
kernel command line parameters,
@@ -3228,4 +3228,4 @@ local-fs-pre.target                dracu
                                           switch-root</pre></div><div=20=

class=3D"section"><div class=3D"titlepage"><div><div><h2 class=3D"title=
"=20
style=3D"clear: both"><a=20
id=3D"_author_4"></a>AUTHOR</h2></div></div></div><p>Harald Hoyer</p></=
div><div=20
class=3D"section"><div class=3D"titlepage"><div><div><h2 class=3D"title=
"=20
style=3D"clear: both"><a id=3D"_see_also_7"></a>SEE=20
ALSO</h2></div></div></div><p><span=20
class=3D"strong"><strong>dracut</strong></span>(8) <span=20
class=3D"strong"><strong>bootup</strong></span>(7)</p></div></div><div=20=

class=3D"appendix"><div class=3D"titlepage"><div><div><h2 class=3D"titl=
e"><a=20
id=3D"_license"></a>Appendix A. License</h2></div></div></div><p>This w=
ork is=20
licensed under the Creative Commons Attribution/Share-Alike
 License. To view a copy of this license, visit
 <a class=3D"ulink" href=3D"http://creativecommons.org/licenses/by-sa/3=
.0/"=20
target=3D"_top">http://creativecommons.org/licenses/by-sa/3.0/</a> or s=
end a=20
letter to Creative
=2DCommons, 559 Nathan Abbott Way, Stanford, California 94305,=20
USA.</p></div></div></div></body></html>
\ No newline at end of file
+Commons, 559 Nathan Abbott Way, Stanford, California 94305,=20
USA.</p></div></div></div></body></html>

--nextPart25786604.pUKuXAIhTE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iF4EABEIAAYFAlL8fGIACgkQFoHVlptUfZmHWgD/SC3eg76NCT+Th5Ek/0oHAAtI
wpavVtJNSovh25VewbkA/3PbpIca2RBPHa94Y8thUAp+we4Wgwo950Y8imcWYrX+
=msQh
-----END PGP SIGNATURE-----

--nextPart25786604.pUKuXAIhTE--
