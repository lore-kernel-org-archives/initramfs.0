From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
Subject: Re: [PATCH] network: don't die if gateway is down and root server
 is local
Date: Fri, 15 Oct 2010 15:03:29 +0100
Message-ID: <4CB85F31.5010207@draigBrady.com>
References: <4CAEF060.8030701@draigBrady.com> <4CAF1D02.6060701@bfh.ch> <4CAF23BA.4010605@draigBrady.com> <4CAF27EF.80301@bfh.ch> <4CAF367D.7030707@draigBrady.com> <4CB84390.5060203@draigBrady.com> <4CB85A73.6010902@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CB85A73.6010902-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 15/10/10 14:43, Harald Hoyer wrote:
>=20
> please use [ -n "$var" ]
>=20

Done, and added a couple of comments.

cheers,
P=C3=A1draig.

=46rom 3030d23e31f3975c0c44207b0faae0792d5cc9b0 Mon Sep 17 00:00:00 200=
1
=46rom: =3D?utf-8?q?P=3DC3=3DA1draig=3D20Brady?=3D <P@draigBrady.com>
Date: Fri, 15 Oct 2010 12:58:31 +0100
Subject: [PATCH] network: don't die if gateway is down and root server =
is local

* modules.d/40network/netroot: Don't arping the gateway
if we don't need to
---
 modules.d/40network/netroot |   28 ++++++++++++++++++++++------
 1 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/modules.d/40network/netroot b/modules.d/40network/netroot
index 81a9ad3..948f68b 100755
--- a/modules.d/40network/netroot
+++ b/modules.d/40network/netroot
@@ -83,21 +83,37 @@ done
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
+
+# Get router IP if set
+[ -n "$new_routers" ] && gw_ip=3D${new_routers%%,*}
+[ -n "$gw" ] && gw_ip=3D$gw
+# Get root server IP if set
+if [ -n "$netroot" ]; then
     dummy=3D${netroot#*:}
     dummy=3D${dummy%%:*}
     case "$dummy" in
-        [0-9]*\.[0-9]*\.[0-9]*\.[0-9]*) dest=3D$dummy;;
+        [0-9]*\.[0-9]*\.[0-9]*\.[0-9]*) netroot_ip=3D$dummy;;
     esac
 fi
+# Default arping dest to router
+dest=3D"$gw_ip"
+# Change to arping root server if appropriate
+if [ -n "$netroot_ip" ]; then
+    if [ -z "$dest" ]; then
+         # no gateway so check root server
+        dest=3D"$netroot_ip"
+    elif ! ip route get "$netroot_ip" | grep -qF ' via ' ; then
+        # local root server, so don't arping gateway
+        dest=3D"$netroot_ip"
+    fi
+fi
 if [ -n "$dest" ] && ! arping -q -f -w 60 -I $netif $dest ; then
     die "Resolving $dest via ARP on $netif failed"
 fi
--=20
1.6.2.5
