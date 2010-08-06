From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] dracut.kernel.7.xml: updated I18N and LUKS sections
Date: Fri, 6 Aug 2010 13:14:18 +0200
Message-ID: <20100806131418.5401d6a9@aidecoe.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/OYKpTuq75JqxHClfN+DSYzz"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/OYKpTuq75JqxHClfN+DSYzz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

10i18n/README: typo corrected
---
 dracut.kernel.7.xml     |   81 ++++++++++++++++++++++++++++++++++---------=
---
 modules.d/10i18n/README |    2 +-
 2 files changed, 61 insertions(+), 22 deletions(-)

diff --git a/dracut.kernel.7.xml b/dracut.kernel.7.xml
index e55d8cc..69925a2 100644
--- a/dracut.kernel.7.xml
+++ b/dracut.kernel.7.xml
@@ -168,62 +168,77 @@ This parameter can be specified multiple times.</para>
     </refsect2>
     <refsect2>
       <title>I18N</title>
-      <para> e.g.
-      <programlisting>
-LANG=3Den_US.UTF-8
-SYSFONT=3Dlatarcyrheb-sun16
-KEYTABLE=3Dde-latin1-nodeadkeys
-      </programlisting>
-      </para>
       <variablelist>
         <varlistentry>
           <term>
-            <envar>KEYBOARDTYPE=3D</envar>
-            <replaceable>{sun|pc}</replaceable>
+            <envar>KEYMAP=3D</envar>
+            <replaceable>&lt;keymap base file name&gt;</replaceable>
           </term>
           <listitem>
-            <para>will be written to /etc/sysconfig/keyboard in the initra=
mfs</para>
+            <para>keyboard translation table loaded by loadkeys; taken fro=
m keymaps directory; will be written to /etc/sysconfig/keyboard in the init=
ramfs, e.g.: <programlisting>KEYMAP=3Dde-latin1-nodeadkeys</programlisting>=
</para>
           </listitem>
         </varlistentry>
         <varlistentry>
           <term>
-            <envar>KEYTABLE=3D<replaceable>&lt;keytable filename&gt;</repl=
aceable></envar>
+            <envar>EXT_KEYMAPS=3D</envar>
+            <replaceable>&lt;list of keymap base file names&gt;</replaceab=
le>
           </term>
           <listitem>
-            <para>will be written to /etc/sysconfig/keyboard in the initra=
mfs</para>
+            <para>list of extra keymaps to bo loaded (sep. by space); will=
 be written to /etc/sysconfig/keyboard in the initramfs</para>
           </listitem>
         </varlistentry>
         <varlistentry>
           <term>
-            <envar>SYSFONT=3D<replaceable>&lt;Console font&gt;</replaceabl=
e></envar>
+            <envar>UNICODE=3D</envar>
+            <replaceable>&lt;1|0&gt;</replaceable>
           </term>
           <listitem>
-            <para>will be written to /etc/sysconfig/i18n in the initramfs<=
/para>
+            <para>boolean, indicating UTF-8 mode; will be written to /etc/=
sysconfig/i18n in the initramfs</para>
           </listitem>
         </varlistentry>
         <varlistentry>
           <term>
-            <envar>SYSFONTACM=3D</envar>
-            <replaceable>&lt;Console map&gt;</replaceable>
+            <envar>SYSFONT=3D</envar>
+            <replaceable>&lt;font base file name&gt;</replaceable>
           </term>
           <listitem>
-            <para>will be written to /etc/sysconfig/i18n in the initramfs<=
/para>
+            <para>console font; taken from consolefonts directory;  will b=
e written to /etc/sysconfig/i18n in the initramfs; e.g.: <programlisting>SY=
SFONT=3DLatArCyrHeb-16</programlisting></para>
           </listitem>
         </varlistentry>
         <varlistentry>
           <term>
-            <envar>UNIMAP=3D<replaceable>&lt;Unicode font map&gt;</replace=
able></envar>
+            <envar>CONTRANS=3D</envar>
+            <replaceable>&lt;console map base file name&gt;</replaceable>
           </term>
           <listitem>
-            <para>will be written to /etc/sysconfig/i18n in the initramfs<=
/para>
+            <para>see description of '-m' parameter in setfont manual; tak=
en from consoletrans directory; will be written to /etc/sysconfig/i18n in t=
he initramfs</para>
           </listitem>
         </varlistentry>
         <varlistentry>
           <term>
-            <envar>LANG=3D<replaceable>&lt;locale&gt;</replaceable></envar>
+            <envar>UNIMAP=3D</envar>
+            <replaceable>&lt;unicode table base file name&gt;</replaceable>
           </term>
           <listitem>
-            <para>will be written to /etc/sysconfig/i18n in the initramfs<=
/para>
+            <para>see description of '-u' parameter in setfont manual; tak=
en from unimaps directory; will be written to /etc/sysconfig/i18n in the in=
itramfs</para>
+          </listitem>
+        </varlistentry>
+        <varlistentry>
+          <term>
+            <envar>LANG=3D</envar>
+            <replaceable>&lt;locale&gt;</replaceable>
+          </term>
+          <listitem>
+            <para>taken from the environment; if no UNICODE is defined we =
set its value in basis of LANG value (whether it ends with ".utf8" (or simi=
lar) or not); will be written to /etc/sysconfig/i18n in the initramfs; e.g.=
: <programlisting>LANG=3Dpl_PL.utf8</programlisting></para>
+          </listitem>
+        </varlistentry>
+        <varlistentry>
+          <term>
+            <envar>LC_ALL=3D</envar>
+            <replaceable>&lt;locale&gt;</replaceable>
+          </term>
+          <listitem>
+            <para>taken from the environment; will be written to /etc/sysc=
onfig/i18n in the initramfs</para>
           </listitem>
         </varlistentry>
       </variablelist>
@@ -301,6 +316,30 @@ This parameter can be specified multiple times.</para>
       </variablelist>
     </refsect2>
     <refsect2>
+      <title>crypt LUKS - experimental removable keys support</title>
+      <para>works only when plymouth module is not included</para>
+      <variablelist>
+        <varlistentry>
+          <term>
+            <envar>rd_LUKS_KEYPATH=3D</envar>
+            <replaceable>&lt;path to keyfile&gt;</replaceable>
+          </term>
+          <listitem>
+            <para>path to keyfile inside remove device filesystem</para>
+          </listitem>
+        </varlistentry>
+        <varlistentry>
+          <term>
+            <envar>rd_LUKS_KEYDEV_UUID=3D</envar>
+            <replaceable>&lt;rem. device uuid&gt;</replaceable>
+          </term>
+          <listitem>
+            <para>UUID of removalbe device storing keyfile; UUID doesn't h=
ave to be exact just like for rd_LUKS_UUID</para>
+          </listitem>
+        </varlistentry>
+      </variablelist>
+    </refsect2>
+    <refsect2>
       <title>MD</title>
       <variablelist>
         <varlistentry>
diff --git a/modules.d/10i18n/README b/modules.d/10i18n/README
index 09cb642..c1878a7 100644
--- a/modules.d/10i18n/README
+++ b/modules.d/10i18n/README
@@ -120,5 +120,5 @@ file (the same where you put mappings).
 3. Kernel parameters
=20
 If you create generic initramfs you can set up i18n by kernel
-parameters using variables listed in 2.1. (expect of UNIKEYMAP
+parameters using variables listed in 2.1. (except of UNIKEYMAP
 and GRP_TOGGLE) The recommended minimum is: SYSFONT, KEYMAP and UNICODE.
--=20
1.7.2

--Sig_/OYKpTuq75JqxHClfN+DSYzz
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAkxb7ooACgkQ+hU8EsKEdQ1vjgCgoL4SNJhs/Bh1uDpoBremtARV
hcwAn2+eUnNGNWUE0IDtTKZ5/dN8oPyx
=Vzr5
-----END PGP SIGNATURE-----

--Sig_/OYKpTuq75JqxHClfN+DSYzz--
