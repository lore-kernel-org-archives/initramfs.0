From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
Subject: [PATCH] network: don't die if gateway is down and root server is
 local
Date: Fri, 15 Oct 2010 13:05:36 +0100
Message-ID: <4CB84390.5060203@draigBrady.com>
References: <4CAEF060.8030701@draigBrady.com> <4CAF1D02.6060701@bfh.ch> <4CAF23BA.4010605@draigBrady.com> <4CAF27EF.80301@bfh.ch> <4CAF367D.7030707@draigBrady.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CAF367D.7030707-V8g9lnOeT5ydJdNcDFJN0w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 08/10/10 16:19, P=C3=A1draig Brady wrote:
> On 08/10/10 15:17, Seewer Philippe wrote:
>> On 10/08/2010 03:59 PM, P=C3=A1draig Brady wrote:
>=20
>>> Is it right to die if we can't contact the router?
>> Usually yes. Either because the rootserver is behind the router or i=
f
>> you supplied routing information it's safe to assume that later you =
want
>> it to work anyway.
>=20
> Well in my case the router is just needed for browsing the net.
> All other services are provided locally.
>=20
>> But yes, usually. I would have preferred to somehow a subnet check o=
n
>> the rootserver to decide what or if to check. But alas, not all netr=
oot
>> variants know the ip of their rootserver at that point.
>=20
> Right, but no need to penalize the common case.
> I.E. we can bypass all this if the rootserver is known,
> and on the same subnet.

This seems to work.

cheers,
P=C3=A1draig.

=46rom a1a1fac1a1cfc8bd22417923823f3d64c29dd44f Mon Sep 17 00:00:00 200=
1
=46rom: =3D?utf-8?q?P=3DC3=3DA1draig=3D20Brady?=3D <P@draigBrady.com>
Date: Fri, 15 Oct 2010 12:58:31 +0100
Subject: [PATCH] network: make gateway optional with a local root serve=
r

* modules.d/40network/netroot: Don't arping the gateway
if we don't need to
---
 modules.d/40network/netroot |   25 ++++++++++++++++++-------
 1 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/modules.d/40network/netroot b/modules.d/40network/netroot
index 81a9ad3..12717b1 100755
--- a/modules.d/40network/netroot
+++ b/modules.d/40network/netroot
@@ -83,22 +83,33 @@ done
 [ -e /tmp/net.$netif.override ] && . /tmp/net.$netif.override
 [ -e /tmp/dhclient.$netif.dhcpopts ] && . /tmp/dhclient.$netif.dhcpopt=
s

-# Handle STP Timeout: arping default router or if not available the
-# root server. Note: This assumes that if no router is present the
+# Handle STP Timeout: arping the default router if root server is
+# unknown or not local, or if not available the root server.
+# Note: This assumes that if no router is present the
 # root server is on the same subnet.
 #
 # TODO There's some netroot variants that don't (yet) have their
 # server-ip netroot
-[ -n "$new_routers" ] && dest=3D${new_routers%%,*}
-[ -n "$gw" ] && dest=3D$gw
-if [ -z "$dest" ] ; then
+[ "$new_routers" ] && gw_ip=3D${new_routers%%,*}
+[ "$gw" ] && gw_ip=3D$gw
+if [ "$netroot" ]; then
     dummy=3D${netroot#*:}
     dummy=3D${dummy%%:*}
     case "$dummy" in
-        [0-9]*\.[0-9]*\.[0-9]*\.[0-9]*) dest=3D$dummy;;
+        [0-9]*\.[0-9]*\.[0-9]*\.[0-9]*) netroot_ip=3D$dummy;;
     esac
 fi
-if [ -n "$dest" ] && ! arping -q -f -w 60 -I $netif $dest ; then
+dest=3D"$gw_ip"
+if [ "$netroot_ip" ]; then
+    if [ -z "$dest" ]; then
+         # no gateway so check root server
+        dest=3D"$netroot_ip"
+    elif ! ip route get "$netroot_ip" | grep -qF ' via '; then
+        # local root server, so don't arping gateway
+        dest=3D"$netroot_ip"
+    fi
+fi
+if [ "$dest" ] && ! arping -q -f -w 60 -I $netif $dest; then
     die "Resolving $dest via ARP on $netif failed"
 fi

--=20
1.6.2.5
