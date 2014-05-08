From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: Re: Intend of hostonly-cmdline?
Date: Thu, 8 May 2014 17:54:12 +0400
Message-ID: <20140508175412.2386aa29@work.puleglot>
References: <2263850.UM9clb02rz@skinner>
	<536A19D7.2010405@redhat.com>
	<20140507154733.386369cd@work.puleglot>
	<536A2222.50606@redhat.com>
	<536A22C9.8000007@redhat.com>
	<20140507171527.2d826560@work.puleglot>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date; bh=Ztkh+42o7RFpl8gP1/i+Z34WtA0V2dWPWZcUvIA5+40=;
	b=dh+YIGn5nq/52I60xNsCLTC0nGfOp2DKBOtVxTqsFfBn4qOiyDzE5pqX54wEAFvSOAgwZxz5tRKYf/y0+KMFilAy5OhoRCNytKZmEJZDWd99DXe7BWtLZKZDYVBE4dW/jG1/9QMaMx+RTAPRO4JvrmsH+ztBtKKKhLF34OMUgOY=;
In-Reply-To: <20140507171527.2d826560-d/9N6kaejYfpx9ONITL1FA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="koi8-r"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

=F7 Wed, 7 May 2014 17:15:27 +0400
Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org> =D0=C9=DB=C5=D4:

> =F7 Wed, 07 May 2014 14:10:49 +0200
> Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> =D0=C9=DB=C5=D4:
>=20
> > On 07.05.2014 14:08, Harald Hoyer wrote:
> > > On 07.05.2014 13:47, Alexander Tsoy wrote:
> > >> Actually hostonly-cmdline is partially broken with systemd in
> > >> initramfs. For example systemd-cryptsetup-generator does not
> > >> read /etc/cmdline.d/*.conf files, so rd.luks* parameters must be
> > >> appended to kernel cmdline anyway.
> > >>
> > >=20
> > > True! Good point!
> > > Although /etc/crypttab is included with hostonly.
> > >=20
> >=20
> > Ah, oh.. I forgot, dracut *does* use rd.luks.uuid from the kernel c=
ommand line
> > and creates /etc/crypttab lines from it in the initramfs.
> > So basically it *should* work with systemd.
>=20
> This doesn't work with full disk encryption. Unit file does not get
> generated and I see this message:
>=20
> [    7.142993] testhost dracut-initqueue[202]: Failed to start system=
d-cryptsetup@luks\x2d342d2414\x2d159c\x2d48d7\x2da0b7\x2d5b59fa6e27a5.s=
ervice: Unit=20
> systemd-cryptsetup@luks\x2d342d2414\x2d159c\x2d48d7\x2da0b7\x2d5b59fa=
6e27a5.service failed to load: No such file or directory.

Note that I don't have an entry for this luks device in /etc/crypttab. =
I
always thought that this is not necessary since all needed options
are in cmdline.

>=20
> Probably this is because crypt-run-generator get executed from udev
> rules only if *both* of the following conditions are true:
> - there is no rd.luks.uuid parameter in both cmdline
> and /etc/cmdline.d/*.conf
> - rd.auto is enabled
>=20

Here is a possible fix that works fine on my system (hostonly +
hostonly-cmdline + empty /etc/crypttab + no rd.luks* in kernel
cmdline).

diff --git a/modules.d/90crypt/parse-crypt.sh b/modules.d/90crypt/parse=
-crypt.sh
index a6b5252..8bb1328 100755
--- a/modules.d/90crypt/parse-crypt.sh
+++ b/modules.d/90crypt/parse-crypt.sh
@@ -35,8 +35,8 @@ else
                         printf -- 'ENV{ID_FS_TYPE}=3D=3D"crypto_LUKS",=
 '
                         printf -- 'ENV{ID_FS_UUID}=3D=3D"*%s*", ' $luk=
sid
                         printf -- 'RUN+=3D"%s --settled --unique --one=
time ' $(command -v initqueue)
-                        printf -- '--name systemd-cryptsetup-%%k %s st=
art ' $(command -v systemctl)
-                        printf -- 'systemd-cryptsetup@luks$$(dev_unit_=
name -$env{ID_FS_UUID}).service"\n'
+                        printf -- '--name crypt-run-generator-%%k %s '=
 $(command -v crypt-run-generator)
+                        printf -- '$env{DEVNAME} luks-$env{ID_FS_UUID}=
"\n'
                     } >> /etc/udev/rules.d/70-luks.rules.new
                 fi
             fi

--=20
Alexander Tsoy
