From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: Re: Intend of hostonly-cmdline?
Date: Tue, 13 May 2014 23:26:12 +0400
Message-ID: <20140513232612.24671da1@work.puleglot>
References: <2263850.UM9clb02rz@skinner>
	<536A19D7.2010405@redhat.com>
	<20140507154733.386369cd@work.puleglot>
	<536A2222.50606@redhat.com>
	<536A22C9.8000007@redhat.com>
	<20140507171527.2d826560@work.puleglot>
	<20140508175412.2386aa29@work.puleglot>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date; bh=Mg8SK9WBvdqBw0Hmn1v1UIZ40qTl+5e0XtTAs9XQ4Bg=;
	b=jHkyfASH7qrB5WO5X/V2DLqGJqmthLu2U12DVvy8ddtaJ6KoCKpdvy+VRxqSEzKTuL2y+DQNb1ugqAZFmz8+36eExc44NRWoqKahDO3ZU/0G81Lfns1b1e5YR7yejZHr0T2lNOErIFsdN3c4z6Ve0dpl0DF7fDaD6eZfP6XvF10=;
In-Reply-To: <20140508175412.2386aa29-d/9N6kaejYfpx9ONITL1FA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="koi8-r"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

=F7 Thu, 8 May 2014 17:54:12 +0400
Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org> =D0=C9=DB=C5=D4:

> Here is a possible fix that works fine on my system (hostonly +
> hostonly-cmdline + empty /etc/crypttab + no rd.luks* in kernel
> cmdline).
>=20
> diff --git a/modules.d/90crypt/parse-crypt.sh b/modules.d/90crypt/par=
se-crypt.sh
> index a6b5252..8bb1328 100755
> --- a/modules.d/90crypt/parse-crypt.sh
> +++ b/modules.d/90crypt/parse-crypt.sh
> @@ -35,8 +35,8 @@ else
>                          printf -- 'ENV{ID_FS_TYPE}=3D=3D"crypto_LUKS=
", '
>                          printf -- 'ENV{ID_FS_UUID}=3D=3D"*%s*", ' $l=
uksid
>                          printf -- 'RUN+=3D"%s --settled --unique --o=
netime ' $(command -v initqueue)
> -                        printf -- '--name systemd-cryptsetup-%%k %s =
start ' $(command -v systemctl)
> -                        printf -- 'systemd-cryptsetup@luks$$(dev_uni=
t_name -$env{ID_FS_UUID}).service"\n'
> +                        printf -- '--name crypt-run-generator-%%k %s=
 ' $(command -v crypt-run-generator)
> +                        printf -- '$env{DEVNAME} luks-$env{ID_FS_UUI=
D}"\n'
>                      } >> /etc/udev/rules.d/70-luks.rules.new
>                  fi
>              fi
>=20

Hmm.. I just walked through commit history and it turned out that my
patch almost reverts your following commits (with minor difference in
initqueue args):

ab9b04f55bb9917749e9ddb52ce8f5f1ef56af99
5ac8420abcfd5665f712f18f8678f3977e039969

What was the reason to replace crypt-run-generator with "systemctl
start systemd-cryptsetup@..." in udev rules?

--=20
Alexander Tsoy
