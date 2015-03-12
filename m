From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Subject: Re: dracut, degraded md arrays, resume and systemd.
Date: Thu, 12 Mar 2015 18:41:15 +1100
Message-ID: <20150312184115.34f40a09@notabene.brown>
References: <20150311112845.01dd3269@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/Z99ym4Iq9vk+S/C5p1uaKOo"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150311112845.01dd3269-wvvUuzkyo1EYVZTmpyfIwg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/Z99ym4Iq9vk+S/C5p1uaKOo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Mar 2015 11:28:45 +1100 NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org> wrote:


> BTW, I also have a problem in a similar config where the md/raid RAID1 is
> encrypted.  Systemd gives up waiting for the encrypted device after 90
> seconds:
> [   92.250437] linux systemd[1]: Dependency failed for Cryptography Setup=
 for cr_md1.
>=20
> but mdraid_start doesn't get run until 120 seconds have elapsed.
> I haven't looked into setup of encrypted devices yet, but if anyone has
> suggestions, I'm very interested :-)

I've looked into this problem some more.

The main problem is that generator_wait_for_dev in rootfs-generator.sh
doesn't always do the same thing.

When you "systemctl daemon-reload", systemd will remove all
of /run/systemd/generator and then re-run all the generators.

generator_wait_for_dev will only create files in /run/systemd/generator if
the .../initqueue/finished/devexists.... file doesn't exist.
So the first time, this file is created and so are the generator files.
Subsequent times, nothing is created, so the /run/systemd/generator files a=
re
not recreated.

This means that the timeout set by timeout.conf is ignored, and the default
timeout is used instead.
The default timeout is 90 second.  The rd.retry timeout, which determines
when the md array will be assembled, is 120 seconds.  So systemd times out
first.

If I apply this patch:

diff --git a/modules.d/98systemd/rootfs-generator.sh b/modules.d/98systemd/=
rootfs-generator.sh
index f3c7d1f237df..97512c07ab06 100755
--- a/modules.d/98systemd/rootfs-generator.sh
+++ b/modules.d/98systemd/rootfs-generator.sh
@@ -11,14 +11,15 @@ generator_wait_for_dev()
     _timeout=3D$(getarg rd.timeout)
     _timeout=3D${_timeout:-0}
=20
-    [ -e "$hookdir/initqueue/finished/devexists-${_name}.sh" ] && return 0
+    if ! [ -e "$hookdir/initqueue/finished/devexists-${_name}.sh" ]; then
=20
-    printf '[ -e "%s" ]\n' $1 \
-        >> "$hookdir/initqueue/finished/devexists-${_name}.sh"
-    {
-        printf '[ -e "%s" ] || ' $1
-        printf 'warn "\"%s\" does not exist"\n' $1
-    } >> "$hookdir/emergency/80-${_name}.sh"
+        printf '[ -e "%s" ]\n' $1 \
+            >> "$hookdir/initqueue/finished/devexists-${_name}.sh"
+        {
+            printf '[ -e "%s" ] || ' $1
+            printf 'warn "\"%s\" does not exist"\n' $1
+        } >> "$hookdir/emergency/80-${_name}.sh"
+    fi
=20
     _name=3D$(dev_unit_name "$1")
     if ! [ -L /run/systemd/generator/initrd.target.wants/${_name}.device ]=
; then


Then it does the right thing ... mostly.

I get a successful boot, but there are warning messages about
a timeout waiting for dev-md-2.device.   This doesn't seem to be fatal,
but it would be good to get rid of it.

systemd knows about this device because the cryptsetup generator tells it.
So it seems to make sense to tell systemd that all devices in /etc/crypttab
should have the correct timeout.  We cannot simply use "wait_for_dev", as we
don't want to wait for the device necessarily, but we want to be sure that
systemd doesn't complain about it.

So I have split "set_systemd_timeout_for_dev" out of "wait_for_dev", and th=
en
called it on all crypttab devices, as shown in these patches:

diff --git a/modules.d/90crypt/parse-crypt.sh b/modules.d/90crypt/parse-cry=
pt.sh
index 94ad1f63ae6f..5a64652cc51c 100755
--- a/modules.d/90crypt/parse-crypt.sh
+++ b/modules.d/90crypt/parse-crypt.sh
@@ -14,6 +14,10 @@ else
     LUKS=3D$(getargs rd.luks.uuid -d rd_LUKS_UUID)
     tout=3D$(getarg rd.luks.key.tout)
=20
+    while read _dev _uuid ; do
+        set_systemd_timeout_for_dev $_dev
+    done
+
     if [ -n "$LUKS" ]; then
         for luksid in $LUKS; do
=20
diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 079c9a21ecad..15e6b992b114 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -892,12 +892,10 @@ dev_unit_name()
     printf -- "%s" "$dev"
 }
=20
-# wait_for_dev <dev>
-#
-# Installs a initqueue-finished script,
-# which will cause the main loop only to exit,
-# if the device <dev> is recognized by the system.
-wait_for_dev()
+# set_systemd_timeout_for_dev <dev>
+# Set 'rd.timeout' as the systemd timeout for <dev>
+
+set_systemd_timeout_for_dev()
 {
     local _name
     local _needreload
@@ -912,19 +910,6 @@ wait_for_dev()
     _timeout=3D$(getarg rd.timeout)
     _timeout=3D${_timeout:-0}
=20
-    _name=3D"$(str_replace "$1" '/' '\x2f')"
-
-    type mark_hostonly >/dev/null 2>&1 && mark_hostonly "$hookdir/initqueu=
e/finished/devexists-${_name}.sh"
-
-    [ -e "${PREFIX}$hookdir/initqueue/finished/devexists-${_name}.sh" ] &&=
 return 0
-
-    printf '[ -e "%s" ]\n' $1 \
-        >> "${PREFIX}$hookdir/initqueue/finished/devexists-${_name}.sh"
-    {
-        printf '[ -e "%s" ] || ' $1
-        printf 'warn "\"%s\" does not exist"\n' $1
-    } >> "${PREFIX}$hookdir/emergency/80-${_name}.sh"
-
     if [ -n "$DRACUT_SYSTEMD" ]; then
         _name=3D$(dev_unit_name "$1")
         if ! [ -L ${PREFIX}/etc/systemd/system/initrd.target.wants/${_name=
}.device ]; then
@@ -949,6 +934,36 @@ wait_for_dev()
         fi
     fi
 }
+# wait_for_dev <dev>
+#
+# Installs a initqueue-finished script,
+# which will cause the main loop only to exit,
+# if the device <dev> is recognized by the system.
+wait_for_dev()
+{
+    local _name
+    local _noreload
+
+    if [ "$1" =3D "-n" ]; then
+        _noreload=3D-n
+        shift
+    fi
+
+    _name=3D"$(str_replace "$1" '/' '\x2f')"
+
+    type mark_hostonly >/dev/null 2>&1 && mark_hostonly "$hookdir/initqueu=
e/finished/devexists-${_name}.sh"
+
+    [ -e "${PREFIX}$hookdir/initqueue/finished/devexists-${_name}.sh" ] &&=
 return 0
+
+    printf '[ -e "%s" ]\n' $1 \
+        >> "${PREFIX}$hookdir/initqueue/finished/devexists-${_name}.sh"
+    {
+        printf '[ -e "%s" ] || ' $1
+        printf 'warn "\"%s\" does not exist"\n' $1
+    } >> "${PREFIX}$hookdir/emergency/80-${_name}.sh"
+
+    set_systemd_timeout_for_dev $_noreload $1
+}
=20
 cancel_wait_for_dev()
 {


and that seems do do what I want.

Is this an appropriate fix?
If you like I can send them as properly formatted patches.

Thanks,
NeilBrown

--Sig_/Z99ym4Iq9vk+S/C5p1uaKOo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVQFDGznsnt1WYoG5AQLznxAAinNh3bUCUu2ghHg0iUaZymqvfCQm8dNh
9CaQd92GFdkr6TFMkqtgECj1qQkWtDbR3oRBS2abkGWNZpJnmNZwB70pWM88+dd1
p9I0cchmPlNUq8UqpTA0ieTBkLtylR4x5Yq8wm1bG2j546ULsEsh2DCnuXXwqHzU
We9GagtzK/4sYZ37RB4u6dJAirtl8JKI55I76oKsOCPf6KyBl7wTUqVgedvaQWB/
YWe8aKGP/xyEjPs+ymPYi/ruUZ07xR4CYD+nL+fBnC7mSScCxl5K9IowWsSiSgQQ
DmqXrpL721bSlqpqwGJXaCLF87Ram0IC3lNwW8Tm0B91MduKrSebZkxL7FUfPNQe
QaC/Rfn3cgDCTWa8bvz2knWF5kI7g0M75byKfxiDNKBRMjjhAWjRaHiQMBwAPcTc
3AyV3KGJTtsHwHtehxrUwuWg6TWyi81EMT+Jbzh3ZMKV7NNgL0R2bOLimX6tSV3U
wMxt1b5nwY3D/nAe88va1cnQ7vC+xOVjz8gtRp4i4y2HM5YFwM1YnzA5swFAx5dt
kTOmafm27cm+3i56u4SV5VD97nvgoQvZvsHsrKA2iLTVvnnzWDCUYc8AaXGa5MAl
BXiVYLKvWLbmPpacwiEbYnBElVzYNcgsUumVA4N+aQqS7Otr7YqCNU6u8rdYL0EU
g10U3yY6J3U=
=x+e+
-----END PGP SIGNATURE-----

--Sig_/Z99ym4Iq9vk+S/C5p1uaKOo--
