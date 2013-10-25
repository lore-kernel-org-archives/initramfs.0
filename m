From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: Re: [ANNOUNCE] dracut 034
Date: Fri, 25 Oct 2013 18:57:10 +0400
Message-ID: <20131025185710.64749db3@work.puleglot>
References: <5253DD0C.7050506@redhat.com>
	<l4dk8e$fv8$1@ger.gmane.org>
	<526A7412.8030804@redhat.com>
	<l4dsjp$20r$1@ger.gmane.org>
	<526A80D9.4060907@gmail.com>
	<l4dvs8$g48$1@ger.gmane.org>
	<526A8412.3040002@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:Message-ID:Subject:To:From:Date; bh=A9jjUBFLqv+oFEJH8k7jnNTpYoJjVUZEfuJoI+mjKQ0=;
	b=QP7FIA23hbNZSl61dma1vXrMv5snfXRr8ithCMOElfCDHA6SR9DmIz3EJDHFuqI193rTJirlAVWylhWPC4kbP63C0iAsZTe9gNQZhJd7eIl0Nad+L0Rxa19xa8dr3AAPL7qpqLiDQ8IXmgZtHXuzw3lfCV69jkTke6LtvAfn4mA=;
In-Reply-To: <526A8412.3040002-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="koi8-r"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

=F7 Fri, 25 Oct 2013 16:45:38 +0200
Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =D0=C9=DB=C5=D4:

> On 10/25/2013 04:40 PM, EatDirt wrote:
> > looks good; but usrmount does not get included (and is not banned i=
n
> > /etc/dracut.conf neither in /etc/drakcut.conf.d/*)
>=20
> The output of:
>=20
> # dracut --debug test.img
>=20
> would be very interesting then.
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Typo?

diff --git a/modules.d/98usrmount/module-setup.sh b/modules.d/98usrmoun=
t/module-setup.sh
index 1af789f..d8a0ec2 100755
--- a/modules.d/98usrmount/module-setup.sh
+++ b/modules.d/98usrmount/module-setup.sh
@@ -7,7 +7,7 @@ check() {
     local _init
     [[ $mount_needs ]] && return 1
     _init=3D$(readlink -f /sbin/init)
-    [[ "$init" =3D=3D "${init##/usr}" ]] && return 255
+    [[ "$_init" =3D=3D "${_init##/usr}" ]] && return 255
     return 0
 }

--=20
Alexander Tsoy
