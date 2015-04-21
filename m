From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut-systemd: ensure grep is installed as needed by
 rootfs-generator
Date: Tue, 21 Apr 2015 16:38:06 +0200
Message-ID: <553660CE.7090509@redhat.com>
References: <20150409140840.0bb6d59d@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150409140840.0bb6d59d-wvvUuzkyo1EYVZTmpyfIwg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 09.04.2015 06:08, NeilBrown wrote:
> 
> 
> rootfs-generator uses 'grep', but it is not installed in the initramfs by 
> default. So explicitly install it when installing rootfs-generator.sh
> 
> Signed-off-by: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
> 
> diff --git a/modules.d/98dracut-systemd/module-setup.sh 
> b/modules.d/98dracut-systemd/module-setup.sh index 
> d9175573c777..780b39a2b4a1 100755 --- 
> a/modules.d/98dracut-systemd/module-setup.sh +++ 
> b/modules.d/98dracut-systemd/module-setup.sh @@ -41,6 +41,7 @@ install() {
> inst_script "$moddir/dracut-mount.sh" /bin/dracut-mount inst_script 
> "$moddir/dracut-pre-pivot.sh" /bin/dracut-pre-pivot
> 
> +    inst_multiple grep inst_script "$moddir/rootfs-generator.sh" 
> $systemdutildir/system-generators/dracut-rootfs-generator
> 
> for i in \
> 

I removed the usage of "grep" from  rootfs-generator.sh for this simple case
of finding a string in a small file.

<http://git.kernel.org/cgit/boot/dracut/dracut.git/commit/?id=d3d52b20e9374a6553c7a6cbe9ff0a9e08df10f9>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVNmDKAAoJEANOs3ABTfJwBKkQAJw1LBHJmY9K/7bOYcO5e/ay
KPFignkvBBkimRewfPViKP1kRBW5Vj678sSQLEWrdXf21XUPnu4y1i6Elz0R7qzq
efXs0MsuI13WVXi8nuQ4UPeqvNicMkA8QWfbuQEO0isoTRjs00lz56G9noKbAAJV
vO1tu1TmroKp2IsaUkZTC6AzvYs2aS0kEfk45F6L09jsi0BXztLCF3ud4xpsw0LR
LTBGEkH4MzluDPxxZijGHGTXuuB1o73/t8L83qTtoi7xLnq6RimBdt+XTNW7khv3
q2X3wVyBzO2yW3H5aOMgU2UqfnVgzE0VXljUqUiLi34jIBkO17HPqKM+J25d2WL+
Sz2p3tRbwmxPEmTZurxDiJN9f0A/vV0xldAF0Gbbjm8tEUSLhD2GDjCiLgaSyjtb
KGEiQK5ZYtcE1u7Jxa0r8QuPeulJuM6CPx7xvAbyVWATJ97+LjvGfmAC78Xq3bXx
ftHPWy8v9WsVv4REhza6bAuRexF20Gs59t/Kg7O/Rmp2ZXp9ElMwlhjmos/BmZCr
q8oNyPfNo7/YUkI2tV+raKXuzhwZKWwp2E2soaUr3E9u0ZGaorS4Fwv3VmFNe/rK
KAxVSJJ4hQDKEGL+k/vEW/3olnxkNT77aB4xIgX+mhDkMhayGfo5/tyrTHoUrihN
Bwg8TjLCoW/dO7XOCIFq
=iT9u
-----END PGP SIGNATURE-----
